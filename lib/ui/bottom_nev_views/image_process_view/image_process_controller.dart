import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:screenshot/screenshot.dart';
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;
import 'package:image/image.dart' as image_lib;
class ImageProcessController extends GetxController {
  final ScreenshotController screenshotController = ScreenshotController();
  File? file;
  late DiseaseModel diseaseModel;
  final Classifier classifier = Classifier();
  var _image;

  var outputText = ''.obs;

  get image => _image;

  set image(value) {
    _image = value;
  }

  List<String> classNames = [
    'Eczema',
    'Melanoma',
    'Atopic Dermatitis',
    'Basal Cell Carcinoma (BCC)',
    'Melanocytic Nevi (NV)',
    'Benign Keratosis-like Lesions (BKL)',
    'Psoriasis pictures Lichen Planus and related diseases',
    'Seborrheic Keratoses and other Benign Tumors',
    'Tinea Ringworm Candidiasis and other Fungal Infections',
    'Normal Skin',
    'Warts Molluscum and other Viral Infections',
  ];

  Future<void> pickImageFrom(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        image = pickedFile.path;
      }
    } catch (e) {
      Get.snackbar('Error', 'Error: $e',
          snackPosition: SnackPosition.TOP, backgroundColor: Colors.red);
      print("Error picking image: $e");
    }
  }

  /// Download receipt
  Future<void> downloadResultImg() async {
    try {
      final capturedImage = await screenshotController.capture();
      if (capturedImage != null) {
        final result = await ImageGallerySaver.saveImage(
          capturedImage,
          quality: 100,
          name: 'Result',
        );

        if (result['isSuccess']) {
          Get.snackbar(
            'Success',
            'Result saved to gallery',
            backgroundColor: Colors.green.withOpacity(.4),
          );
        } else {
          Get.snackbar(
            'Error',
            'Failed to save Result',
            backgroundColor: Colors.red.withOpacity(.4),
          );
        }
      } else {
        Get.snackbar(
          'Error',
          'Failed to capture Result',
          backgroundColor: Colors.red.withOpacity(.4),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Exception',
        e.toString(),
        backgroundColor: Colors.red.withOpacity(.4),
      );
    }
  }

  /// Ask from AI
  Future<void> askedFromAi() async {
    // Implementation for AI interaction
  }

  /// Image Process
  void getDiseaseStatus(DiseaseProvider diseaseProvider) async {
    if (image == null) {
      print("No image selected");
      return;
    }

    print("IMAGE PATH: $image");

    try {
      late double confidence;
      await classifier.getDisease(image, classNames).then((value) {
        debugPrint(value.toString());

        diseaseModel = DiseaseModel(
          name: value["label"],
          imagePath: classifier.imageFile.path,
        );

        confidence = value['confidence'];
      });

      // Check confidence
      if (confidence > 0.05) {
        diseaseProvider.setDiseaseStatus(diseaseModel);

        outputText.value = "Disease detected: ${diseaseModel.name}";
      } else {
        outputText.value = "Disease detection confidence too low.";
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to process image: $e',
        backgroundColor: Colors.red.withOpacity(.4),
      );
    }
  }
}

// Classifier.dart
class Classifier extends GetxController {
  late File imageFile;
  late List outputs;
  late tfl.Interpreter interpreter;

  bool checkImageIsPng(String path) {
    return path.endsWith(".png");
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

  Future<Map<String, dynamic>> getDisease(String path, List<String> classNames) async {
    if (checkImageIsPng(path)) {
      path = convertPngToJpg(path, path.replaceAll(".png", ".jpg"));
    }

    imageFile = File(path);
    int noOfClasses = classNames.length;

    await loadModel();
    var value = await classifyImage(imageFile, noOfClasses);
    interpreter.close();

    print("VALUE: $value");

    int maxIndex = value![0]
        .indexOf(value[0].reduce((curr, next) => curr > next ? curr : next));

    String predictedClass = classNames[maxIndex];
    double confidence = value[0][maxIndex];

    debugPrint("Predicted Class: $predictedClass");
    debugPrint("Confidence: $confidence");

    return {"label": predictedClass, "confidence": confidence};
  }
  // loadModel() async {
  //   interpreter = await tfl.Interpreter.fromAsset(
  //       'assets/ml_models/model_unquant.tflite');
  //   print('loaded');
  // }

  Future<void> loadModel() async {
    try {
      interpreter = await tfl.Interpreter.fromAsset('model_unquant.tflite');
      print('Model loaded successfully');
    } catch (e) {
      print('Error loading model: $e');
    }
  }

  Future<List?> classifyImage(File image, int noOfClasses) async {
    try {
      var img = image_lib.decodeImage(image.readAsBytesSync());
      var resizedImg = image_lib.copyResize(img!, width: 256, height: 256);
      var imgBytes = resizedImg.getBytes();
      var floatImgBytes = imgBytes.map((byte) => byte / 255.0).toList();
      var input = floatImgBytes.reshape([1, 256, 256, 3]);
      var output = List.filled(1, List.filled(noOfClasses, 0.0));

      interpreter.run(input, output);
      debugPrint("Output: $output");
      return output;
    } catch (e) {
      debugPrint("Classification failed: $e");
      return null;
    }
  }
}

// DiseaseProvider.dart
class DiseaseProvider with ChangeNotifier {
  late DiseaseModel _diseaseModel;

  DiseaseModel get disease => _diseaseModel;

  void setDiseaseStatus(DiseaseModel diseaseModel) {
    _diseaseModel = diseaseModel;
    notifyListeners();
  }
}

// DiseaseModel.dart
class DiseaseModel {
  final String name;
  late String imagePath;

  DiseaseModel({required this.name, required this.imagePath});
}