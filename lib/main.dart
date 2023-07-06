import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'image_labelling.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: ObjectDetection(),
    );
  }
}

// class CameraScreen extends StatefulWidget {
//   @override
//   _CameraScreenState createState() => _CameraScreenState();
// }
//
// class _CameraScreenState extends State<CameraScreen> {
//   late CameraController _cameraController;
//   late Future<void> _initializeCameraControllerFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeCamera();
//   }
//
//   Future<void> _initializeCamera() async {
//     final cameras = await availableCameras();
//     final camera = cameras.first;
//
//     _cameraController = CameraController(
//       camera,
//       ResolutionPreset.medium,
//     );
//
//     _initializeCameraControllerFuture = _cameraController.initialize();
//   }
//
//   // final ImageLabelerOptions options = ImageLabelerOptions(confidenceThreshold: 0.8);
//   // final imageLabeler = ImageLabeler(options: options);
//
//
//   void initaliseImage() async {
//     final path = 'assets/ml/object_labeler.tflite';
//     // final modelPath = await _getModel(path);
//     // final options = LocalLabelerOptions(modelPath: modelPath);
//     // _imageLabeler = ImageLabeler(options: options);
//
//   }
//   @override
//   void dispose() {
//     // _canProcess = false;
//     // imageLabeler.close();
//     super.dispose();
//   }
//   // Future<void> processImage(InputImage inputImage) async {
//   //
//   //
//   //   final labels = await imageLabeler.processImage(inputImage);
//   //   if (inputImage.inputImageData?.size != null &&
//   //       inputImage.inputImageData?.imageRotation != null) {
//   //     final painter = LabelDetectorPainter(labels);
//   //     _customPaint = CustomPaint(painter: painter);
//   //   } else {
//   //     String text = 'Labels found: ${labels.length}\n\n';
//   //     for (final label in labels) {
//   //       text += 'Label: ${label.label}, '
//   //           'Confidence: ${label.confidence.toStringAsFixed(2)}\n\n';
//   //     }
//   //
//   //   }
//   //   if (mounted) {
//   //     setState(() {});
//   //   }
//   // }
//   // void _processImage() async {
//   //   final List<ImageLabel> labels = await imageLabeler.processImage(inputImage);
//   //
//   //   for (ImageLabel label in labels) {
//   //     final String text = label.label;
//   //     final int index = label.index;
//   //     final double confidence = label.confidence;
//   //   }
//   // }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Take Picture'),
//         ),
//         body: Column(
//           // crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//                 onPressed: () async {
//                   _getFromGallery();
//                 },
//                 child: Text("Take picture"))
//           ],
//         ));
//   }
//
//  Future<dynamic> _bottomSheet() {
//     Size size = MediaQuery.of(context).size;
//    return  showModalBottomSheet(
//         context: context, builder: (context) =>
//        Column(
//          children: [
//            Container(
//              margin: EdgeInsets.only(bottom: 25),
//              child: Center(
//                child: Text(
//                  "Upload Picture",
//                  style: TextStyle(
//                      color: Colors.black,
//                      fontWeight: FontWeight.w500,
//                      fontSize: 17),
//                ),
//              ),
//            ),
//            Padding(
//              padding: const EdgeInsets.only(bottom: 35.0),
//              child: Row(
//                children: [
//                  SizedBox(
//                    width: size.width / 2,
//                    child: ListTile(
//                      title: IconButton(
//                        onPressed: _getFromCamera(),
//                        icon: Icon(
//                          Icons.camera,
//                          size: 45,
//                        ),
//                        color: Colors.blue,
//                      ),
//                      subtitle: Center(child: Text("Camera")),
//                    ),
//                  ),
//                  SizedBox(
//                    width: size.width / 2,
//                    child: ListTile(
//                      title: IconButton(
//                        onPressed: _getFromGallery,
//                        icon: Icon(
//                          Icons.image,
//                          size: 45,
//                        ),
//                        color: Colors.blue,
//                      ),
//                      subtitle: Center(child: Text("Gallery")),
//                    ),
//                  )
//                ],
//              ),
//            ),
//          ],
//        ));
//   }
//
//   _getFromGallery() async {
//     Size size = MediaQuery.of(context).size;
//
//     var img = await ImagePicker().pickImage(source: ImageSource.gallery);
//     print("imag ${img?.path}");
//     File file = File(img!.path);
//
//     if (img.path.isNotEmpty) {
//       await showModalBottomSheet(
//           context: context,
//           builder: (context) {
//             return Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 18.0),
//                   child: SizedBox(
//                     width: size.width,
//                     height: size.height * 0.4,
//                     child: Image.file(file),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 10.0),
//                   child: Center(
//                     child: ElevatedButton(
//                         child: Text("Send"), onPressed: () async {}),
//                   ),
//                 )
//               ],
//             );
//           });
//     }
//
//     setState(() {});
//   }
//
//   _getFromCamera() async {
//     Size size = MediaQuery.of(context).size;
//
//     var img = await ImagePicker().pickImage(source: ImageSource.gallery);
//     print("imag ${img?.path}");
//     File file = File(img!.path);
//
//     if (img.path.isNotEmpty) {
//       await showModalBottomSheet(
//           context: context,
//           builder: (context) {
//             return Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 18.0),
//                   child: SizedBox(
//                     width: size.width,
//                     height: size.height * 0.4,
//                     child: Image.file(file),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 10.0),
//                   child: Center(
//                     child: ElevatedButton(
//                         child: Text("Send"), onPressed: () async {}),
//                   ),
//                 )
//               ],
//             );
//           });
//     }
//
//     setState(() {});
//   }
// }
