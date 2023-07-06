import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ml_model_downloader/firebase_ml_model_downloader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_model_downloader/firebase_ml_model_downloader.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tflite/tflite.dart';

// import 'package:tflite/tflite.dart';
// import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';

class ObjectDetection extends StatefulWidget {
  const ObjectDetection({Key? key}) : super(key: key);

  @override
  State<ObjectDetection> createState() => _ObjectDetectionState();
}

class _ObjectDetectionState extends State<ObjectDetection> {
  ImagePicker picker = ImagePicker();

  XFile? image;
  File? file;

  _getFromGallery() async {
    image = await picker.pickImage(source: ImageSource.gallery);

    print("imag ${image?.path}");
    file = File(image!.path);
    print(file);

    // getModel(file!);
    setState(() {});
  }

  late final InputImage inputImage;

  // Use DetectionMode.stream when processing camera feed.
// Use DetectionMode.single when processing a single image.
  final mode = DetectionMode.single;

// Options to configure the detector while using with base model.
//   final options = ObjectDetectorOptions(mode: mode, classifyObjects: true);

// Options to configure the detector while using a local custom model.
//   final options = LocalObjectDetectorOptions( mode: null);

// Options to configure the detector while using a Firebase model.
  late final ObjectDetector objectDetector;

  List? _label;

  /*Method used to use custom model from firebase, not working. Code kept for reference*/

  // late final Future<FirebaseCustomModel>_model ;

  // googleMlKit() async {
  //   // final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(pickedImage);
  //   // final ObjectDetector objectDetector = ObjectDetector.instance.objectDetector();
  //   print("1");
  //
  //   final options = ObjectDetectorOptions(
  //       mode: mode, classifyObjects: true, multipleObjects: true);
  //
  //   // final opt = FirebaseObjectDetectorOptions(mode: mode,
  //   //     modelName: modelName,
  //   //     classifyObjects: classifyObjects,
  //   //     multipleObjects: multipleObjects)
  //
  //   inputImage = InputImage.fromFile(File(file!.path));
  //
  //   // FirebaseCustomModel firebaseCustomModel = FirebaseCustomModel(
  //   //     file: file, size: size, name: name, hash: hash)
  //
  //   FirebaseObjectDetectorModelManager firebaseObjectDetectorModelManager =
  //       FirebaseObjectDetectorModelManager();
  //
  //   objectDetector = ObjectDetector(options: options);
  //   print("2");
  //   print(inputImage.filePath);
  //   // final imageNew = inputImage.filePath
  //   //;
  //
  //   var sample = InputImage.fromFile(File(file!.path));
  //   print("Sample ${sample.inputImageData}");
  //   try {
  //     final List<DetectedObject> objects =
  //         await objectDetector.processImage(inputImage);
  //     // print(inputImage.filePath);
  //     print("3");
  //     print(objects.toString());
  //
  //     for (DetectedObject detectedObject in objects) {
  //       final rect = detectedObject.boundingBox;
  //       final trackingId = detectedObject.trackingId;
  //       print("4");
  //       print(rect);
  //       print(trackingId);
  //       for (Label label in detectedObject.labels) {
  //         setState(() {
  //           // _label = label.text;
  //         });
  //         print('${label.text} ${label.confidence}');
  //       }
  //     }
  //   } on PlatformException catch (e) {
  //     print("error $e");
  //   }
  //
  //   objectDetector.close();
  // }

  /*Method used for another package may need it for future references. */

  // initalizeModel() async {
  //   try {
  //     String? res = await Tflite.loadModel(
  //         model: "assets/ml/mobilenet_v1_1.0_224.tflite",
  //         labels: "assets/ml/mobilenet_v1_1.0_224.txt",
  //         numThreads: 1,
  //         // defaults to 1
  //         isAsset: true,
  //         // defaults to true, set to false to load resources outside assets
  //         useGpuDelegate:
  //             false // defaults to false, set to true to use GPU delegate
  //         );
  //
  //     print("res $res");
  //   } catch (e) {
  //     print("error $e");
  //   }
  // }

  // getModel(File filepath) async {
  //   print(filepath.path.toString());
  //   recognitions = await Tflite.runModelOnImage(
  //       path: filepath.path,
  //       // required
  //       imageMean: 0.0,
  //       // defaults to 117.0
  //       imageStd: 255.0,
  //       // defaults to 1.0
  //       numResults: 2,
  //       // defaults to 5
  //       threshold: 0.2,
  //       // defaults to 0.1
  //       asynch: true // defaults to true
  //       );
  //
  //   print(recognitions);
  //   // print(recognitions![0]["label"]);
  // }

  var _model;

  late final FirebaseModelDownloadConditions conditions;
  late final FirebaseModelDownloadType type;

  // late final Future<FirebaseCustomModel> modelManager;

  File? localPath;

  /*Method 2: Load the model from firebase before processing the image*/
  /* Method not implemented and tested need more reference article to implement this idea.*/


  // Future getModelData() async {
  //   await Firebase.initializeApp();
  //
  //   // final  remoteModel = FirebaseCustomModel(file: null, size: null, name: '', hash: '');
  //
  //   print("11");
  //   const type = FirebaseModelDownloadType.localModelUpdateInBackground;
  //
  //   var modelManager = FirebaseModelDownloader.instance
  //       .getModel('Vegitation-Plant-Detector', type)
  //       .then((value) async {
  //     print("value .. ${value.file}");
  //
  //     final directory = await getApplicationDocumentsDirectory();
  //     final h = ("${directory.path}/assetsModel");
  //
  //     final val = File(h);
  //
  //     // await val.readAsBytesSync(value.file);
  //
  //     // await OpenFile.open(value.file.path);
  //     return localPath = value.file;
  //   });
  //
  //   conditions = FirebaseModelDownloadConditions(
  //     iosAllowsBackgroundDownloading: true,
  //     androidDeviceIdleRequired: false,
  //   );
  //
  //   print("modelManager ${modelManager.toString()}");
  //
  //   // OpenFile openFile;
  //
  //   // setState(() {
  //   //   modelManager = _model;
  //   // });
  //   // final bool response = await modelManager.isModelDownloaded('Vegitation-Plant-Detection');
  //   //
  //   // print("response $response");
  //
  //   // final bool isDownloaded = await modelManager.downloadModel('Vegitation-Plant-Detection');
  //   //
  //   // print("downloaded $isDownloaded");
  //
  //   // final bool isDeleted = await modelManager.deleteModel('Vegitation-Plant-Detection');
  // }



  Future loadModel() async {
    final con = await Tflite.loadModel(
        model: 'assets/ml/crop_model_1.0.0.tflite',
        labels: 'assets/ml/crop_labels.txt');
    print("condd $con");
  }



  Future runImageModel() async {
    var model = await Tflite.runModelOnImage(
      path: file!.path,
      // imageMean: 117.0,
      // imageStd: 1.0,
      numResults: 5,
      threshold: 0.1,
    );

    print("modelRun.. $model");

    setState(() {
      _label = model!;
    });

    // await Tflite.close();
  }

  // runModel() async {
  //
  //
  //   final FirebaseObjectDetectorModelManager objectDetectorModelManager = FirebaseObjectDetectorModelManager();
  //   final detect = FirebaseObjectDetectorOptions(mode: mode,
  //       modelName: 'Vegitation-Plant-Detection',
  //       classifyObjects: true,
  //       multipleObjects: false);
  //
  //   print("detect ${detect.modelName}");
  // }
  //
  // loadFirebaseModel() async {
  //   Tflite.loadModel(model: 'Vegitation-Plant-Detector');
  // }
  @override
  void initState() {
    // initalizeModel();

    // getModelData();
    loadModel();
    // getModelData();
    super.initState();
  }

  @override
  void dispose() {
    // objectDetector.close();
    // file;
    Tflite.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Classification"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getFromGallery,
        child: Icon(Icons.add),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          image == null
              ? Expanded(
                  child: Image.asset(
                    "assets/images/loading gif.gif",
                    fit: BoxFit.fill,
                  ),
                )
              : Expanded(
                  child: Image.file(
                    File(image!.path),
                    fit: BoxFit.contain,
                  ),
                ),
          Expanded(
              child: Text(
            _label.toString() == "null"
                ? "Loading.."
                : _label![0]["label"].toString(),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          )),
          ElevatedButton(
              onPressed: () async {
                runImageModel();
                // getModel(file!);
                // googleMlKit();
                // getModelData();
                // runModel();

                // ImageClassification();

              },
              child: Text("Analyse"))
        ],
      ),
    );
  }
}
