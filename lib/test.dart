import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;
import 'package:image/image.dart' as image_lib;
import 'dart:typed_data';

class ModelTestClass extends StatefulWidget {
  const ModelTestClass({super.key});

  @override
  State<ModelTestClass> createState() => _ModelTestClassState();
}

class _ModelTestClassState extends State<ModelTestClass> {
  File? file;
  final Classifier classifier = Classifier();
  late DiseaseModel diseaseModel;

  List<String> classNames = [
    'Eczema',
    'Melanoma',
    'Atopic Dermatitis',
    'Basal Cell Carcinoma (BCC)',
    'Melanocytic Nevi (NV)',
    'Benign Keratosis-like Lesions (BKL)',
    'Psoriasis pictures Lichen Planus and related disea',
    'Seborrheic Keratoses and other Benign Tumors',
    'Tinea Ringworm Candidiasis and other Fungal Infect',
    'Noraml Skin',
    'Warts Molluscum and other Viral Infections',
  ];
  void getDiseaseStatus(DiseaseProvider diseaseProvider) async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      file = File(image!.path);
    });

    print("IMAGE");

    if (file == null) {
      return;
    }
    print("IMAGE PATH: ${file!.path}");

    bool isLoading = false;

    if (file != null) {
      setState(() {
        isLoading = true;
      });

      late double confidence;
      await classifier.getDisease(file!.path, classNames).then((value) {
        debugPrint(value.toString());

        diseaseModel = DiseaseModel(
            name: value["label"], imagePath: classifier.imageFile.path);

        confidence = value['confidence'];
      });

      // Check confidence
      if (confidence > 0.05) {
        diseaseProvider.setDiseaseStatus(diseaseModel);

        // if (diseaseModel.name == "no_tumor") {
        //   if (!mounted) return;
        //   setState(() {
        //     isLoading = false;
        //     _outputText = "No disease detected.";
        //   });
        //   return;
        // }
        if (!mounted) return;
        setState(() {
          isLoading = false;
          _outputText = "Disease detected: ${diseaseModel.name}";
        });
      } else {
        // Display unsure message
      }
    }
  }

  String _outputText = "Please pick an image."; // Initial text

  @override
  void initState() {
    super.initState();
    classifier.loadModel();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (file != null)
              Image.file(
                file!,
                width: 200,
                height: 200,
              )
            else
              const Text('No image selected'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final vm = Provider.of<DiseaseProvider>(context, listen: false);
                getDiseaseStatus(vm);
              },
              child: const Text('Pick Image from Gallery'),
            ),
            const SizedBox(height: 20),
            Text(_outputText)
          ],
        ),
      ),
    );
  }
}

class Classifier {
  late File imageFile;
  late List outputs;
  late tfl.Interpreter interpreter;

  bool checkImageIsPng(String path) {
    if (path.contains(".png")) {
      return true;
    } else {
      return false;
    }
  }

  String convertPngToJpg(String inputPath, String outputPath) {
    final File inputFile = File(inputPath);
    if (!inputFile.existsSync()) {
      debugPrint('Input file does not exist!');
      return '';
    }

    List<int> bytes = inputFile.readAsBytesSync();
    image_lib.Image? image = image_lib.decodeImage(Uint8List.fromList(bytes));

    if (image != null) {
      File(outputPath).writeAsBytesSync(image_lib.encodeJpg(image));
      return outputPath;
    } else {
      debugPrint('Failed to decode PNG image');
      return '';
    }
  }

  Future<Map<String, dynamic>> getDisease(
      String path, List<String> classNames) async {
    if (checkImageIsPng(path)) {
      path = convertPngToJpg(path, path.replaceAll(".png", ".jpg"));
    }
    imageFile = File(path);
    int noOfClasses = 11;

    // await loadModel();
    var value = await classifyImage(imageFile, noOfClasses);
    interpreter.close();

    print("VALUE: $value");

    int maxIndex = value![0].indexOf(value[0]
        .reduce((double curr, double next) => curr > next ? curr : next));

    String predictedClass = classNames[maxIndex];
    double confidence = value[0][maxIndex];

    debugPrint("Predicted Class: $predictedClass");
    debugPrint("Confidence: $confidence");

    return {"label": predictedClass, "confidence": confidence};
  }

  loadModel() async {
    interpreter = await tfl.Interpreter.fromAsset(
        'assets/ml_models/model_unquant.tflite');
    print('loaded');
  }

  Future<List?> classifyImage(File image, int noOfClasses) async {
    try {
      var img = image_lib.decodeImage(image.readAsBytesSync());
      var resizedImg = image_lib.copyResize(img!, width: 256, height: 256);
      var imgBytes = resizedImg.getBytes();
      var floatImgBytes = imgBytes.map((byte) => byte / 255.0).toList();
      var input = floatImgBytes.reshape([1, 256, 256, 3]);
      var output = List.filled(
          1,
          List.filled(noOfClasses,
              0.0)); // Adjusted to shape [1, noOfClasses] for the number of classes

      interpreter.run(input, output);
      debugPrint("output$output");
      return output;
    } catch (e) {
      return null;
    }
  }
}

class DiseaseProvider with ChangeNotifier {
  late DiseaseModel _diseaseModel;

  DiseaseModel get disease => _diseaseModel;

  void setDiseaseStatus(DiseaseModel diseaseModel) {
    _diseaseModel = diseaseModel;
    notifyListeners();
  }
}

class DiseaseModel {
  final String name;

  late String imagePath;

  DiseaseModel({required this.name, required this.imagePath});
}
