import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:graduation_project_app/MenuScreen.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image/image.dart' as img;
import 'dart:ui' as ui;
import 'package:path_provider/path_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);
  @override
  State<TestScreen> createState() => _TestScreen();
}

class _TestScreen extends State<TestScreen> {
  List<File> selectedImages = [];
  List<File> croppedImages = [];
  List<double> conf = [];
  List<String> labels = [];
  int counter = 0;
  var totalconf = 0.0;
  bool finalconf = false;
  late File _image;
  late List _results;
  bool imageSelect = false;
  //For Detection
  final key = GlobalKey();
  List<Face> _faces = [];
  late ui.Image _uiimage;
  late File _repaintedimage;
  var imgbytes;
  late File _Croppedfile;
  bool imagecrop = false;
  bool detected = false;
  late File file1;
  late File croppedFile;
  late var finallabel = '';
  late FToast fToast;
  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    loadModel();
  }

  @override
  void dispose() {
    super.dispose();
    Tflite.close();
  }

  Future loadModel() async {
    Tflite.close();
    String res;
    res = (await Tflite.loadModel(
        model: "assets/converted_model.tflite", labels: "assets/model.txt"))!;
    print("Models loading status: $res");
  }

  showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 17.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.blue[500],
      ),
      child: Text("Model_toast".tr(),
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
          )),
    );
    fToast.showToast(
      child: toast,
      toastDuration: Duration(seconds: 7),
    );
  }

  Future imageClassification(File image) async {
    final List? recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    setState(() {
      _results = recognitions!;
      //_image = image;
      //_Croppedfile = image;
      imageSelect = true;
      //imagecrop = true;
      //imageCache.clear();
    });

    print('Confidence: ${(_results[0]['confidence'] * 100).toStringAsFixed(2)}'
        "%");
    print('Result: ${_results[0]['label']}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        leading: BackButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MenuScreen()),
            );
          },
        ),
        title: Text(
          'Model_appbar'.tr(),
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 23,
          ),
        ),
      ),
      body: Container(
        //color: Theme.of(context).colorScheme.background,
        padding: EdgeInsetsDirectional.symmetric(horizontal: 35, vertical: 50),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsetsDirectional.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(16),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Center(
                    child: imagecrop == false
                        ? null //show nothing if no picture selected
                        : Container(
                            child: Column(
                              children: [
                                SizedBox(
                                  key: key,
                                  height:
                                      MediaQuery.of(context).size.width * 0.9,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      _Croppedfile,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Divider(
                                  height: 25,
                                  thickness: 1,
                                ),
                                // ignore: unnecessary_null_comparison
                                finalconf != false
                                    ? Text(
                                        '${'Model_result'.tr()}$finallabel\n${'Model_Confidence'.tr(namedArgs: {
                                              'conf':
                                                  '${(totalconf * 100).toStringAsFixed(2)} %'
                                            })}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )
                                    : Container(),
                                const Divider(
                                  height: 25,
                                  thickness: 1,
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          labels.clear();
                          conf.clear();
                          totalconf = 0.0;
                          counter = 0;
                          croppedImages.clear();
                          _faces.clear();
                          imagecrop = false;
                          finalconf = false;
                          imageCache.clear();
                          PaintingBinding.instance.imageCache.clear();
                          pickImage();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width - 150,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 17),
                          decoration: BoxDecoration(
                            color: Colors.blue[500],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            'Model_take_photo'.tr(),
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      GestureDetector(
                        onTap: () {
                          labels.clear();
                          conf.clear();
                          totalconf = 0.0;
                          counter = 0;
                          croppedImages.clear();
                          selectedImages.clear();
                          //_Croppedfile.delete();
                          _faces.clear();
                          imagecrop = false;
                          finalconf = false;
                          imageCache.clear();
                          PaintingBinding.instance.imageCache.clear();
                          uploadImage2();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width - 150,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 17),
                          decoration: BoxDecoration(
                            color: Colors.blue[500],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            'Model_from_gal'.tr(),
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Future uploadImage() async {
  //   final ImagePicker _picker = ImagePicker();
  //   final XFile? pickedFile = await _picker.pickImage(
  //     source: ImageSource.gallery,
  //   );
  //   File image = File(pickedFile!.path);
  //   final options = FaceDetectorOptions();
  //   final faceDetector = FaceDetector(options: options);
  //   final inputImage = InputImage.fromFile(image);
  //
  //   final List<Face> faces = await faceDetector.processImage(inputImage);
  //
  //   if (mounted) {
  //     _loadImage(image);
  //     setState(() {
  //       _faces = faces;
  //     });
  //   }
  // }

  Future _loadImage(File file) async {
    final data = await file.readAsBytes();

    await decodeImageFromList(data).then((value) => setState(() {
          _uiimage = value;
        }));
    await getImage();
  }

  Future getImage() async {
    ui.PictureRecorder recorder = ui.PictureRecorder();
    Canvas canvas = Canvas(recorder);
    var painter = FacePainter(_uiimage, _faces);
    var size = const Size(double.infinity, double.infinity);
    painter.paint(canvas, size);
    ui.Image renderedImage =
        await recorder.endRecording().toImage(_uiimage.width, _uiimage.height);

    var pngBytes =
        await renderedImage.toByteData(format: ui.ImageByteFormat.png);
    var bytes = await pngBytes!.buffer.asUint8List();

    setState(() {
      _uiimage = renderedImage;
      imgbytes = bytes;
    });
    await cropimage();
  }

  Future cropimage() async {
    int x = _faces[0].boundingBox.left.toInt();
    int y = _faces[0].boundingBox.top.toInt();
    int w = _faces[0].boundingBox.width.toInt();
    int h = _faces[0].boundingBox.height.toInt();

    final Directory tempDir = await getTemporaryDirectory();

    file1 = File("${tempDir.path}/image.png");

    final data = await _uiimage.toByteData(
      format: ui.ImageByteFormat.png,
    );

    final bytes = data?.buffer.asUint8List();

    file1 = await file1.writeAsBytes(bytes as List<int>, flush: true);

    img.Image? originalImage =
        img.decodeImage(File(file1.path).readAsBytesSync());
    img.Image cropped =
        img.copyCrop(originalImage!, x: x, y: y, width: w, height: h);

    final jpg = img.encodeJpg(cropped);

    croppedFile = File("${tempDir.path}/image$counter _cropped.png");

    croppedFile.writeAsBytes(jpg);
    counter++;
    croppedImages.add(croppedFile);

    await Future.delayed(const Duration(seconds: 1));
    await imageClassification(croppedFile);
  }

  Future pickImage() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
            child: CircularProgressIndicator(
          color: Colors.blue,
        ));
      },
    );
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
    );
    File image = File(pickedFile!.path);
    final options = FaceDetectorOptions();
    final faceDetector = FaceDetector(options: options);
    final inputImage = InputImage.fromFile(image);
    final List<Face> faces = await faceDetector.processImage(inputImage);

    if (faces.isEmpty) {
      Navigator.of(context).pop();
      showToast();
      setState(() {
        imagecrop = false;
      });
    } else {
      _faces = faces;
      await _loadImage(image);
      totalconf = _results[0]['confidence'];
      finallabel = _results[0]['label'];
      setState(() {
        _Croppedfile = croppedImages[0];
        detected = true;
        finalconf = true;
        imagecrop = true;
      });
      Navigator.of(context).pop();
    }
    //imageClassification(image);
  }

  Future uploadImage2() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
            child: CircularProgressIndicator(
          color: Colors.blue,
        ));
      },
    );
    final ImagePicker _picker = ImagePicker();
    final pickedFile = await _picker.pickMultiImage();
    List<XFile> xfilePick = pickedFile;
    setState(() {
      if (xfilePick.isNotEmpty) {
        for (var i = 0; i < xfilePick.length; i++) {
          selectedImages.add(File(xfilePick[i].path));
        }
      }
    });
    for (var i = 0; i < selectedImages.length; i++) {
      final options = FaceDetectorOptions();
      final faceDetector = FaceDetector(options: options);
      final inputImage = InputImage.fromFile(selectedImages[i]);
      final List<Face> faces = await faceDetector.processImage(inputImage);
      detected = false;
      if (mounted) {
        //Check if face is detected or not
        if (faces.isEmpty) {
          Navigator.of(context).pop();
          showToast();
          setState(() {
            imagecrop = false;
          });
        } else {
          setState(() {
            detected = true;
            _faces = faces;
            _image = selectedImages[i];
          });
          //If Detected Continue the Model
          await _loadImage(selectedImages[i]);
          setState(() {
            _Croppedfile = croppedImages[i];
            imagecrop = true;
          });

          if (_results[0]['confidence'] == 1) {
            var tmp = 0.9999;
            conf.add(tmp);
            labels.add(_results[0]['label']);
          } else {
            conf.add(_results[0]['confidence']);
            labels.add(_results[0]['label']);
          }
        }
      }
    }
    if (detected != false) {
      GetResults();
    }
  }

  Future GetResults() async {
    if (selectedImages.length > 1) {
      for (var i = 0; i < selectedImages.length; i++) {
        if (labels[i] == 'Autistic') {
          totalconf += conf[i];
        } else if (labels[i] == 'Non-autistic') {
          totalconf += 1 - conf[i];
        }
      }

      totalconf = totalconf / selectedImages.length;
      if (totalconf < 0.5) {
        totalconf = 1 - totalconf;
        setState(() {
          finallabel = 'Non-Autistic';
        });
      } else if (totalconf > 0.5) {
        setState(() {
          finallabel = 'Autistic';
        });
      }
    } else {
      if (labels[0] == 'Autistic') {
        totalconf += conf[0];
        setState(() {
          finallabel = 'Autistic';
        });
      } else if (labels[0] == 'Non-autistic') {
        totalconf += 1 - conf[0];
      }
      if (totalconf < 0.5) {
        totalconf = 1 - totalconf;
        setState(() {
          finallabel = 'Non-Autistic';
        });
      }
    }
    Navigator.of(context).pop();
    setState(() {
      finalconf = true;
    });

    print("Final Confidence : ${(totalconf * 100).toStringAsFixed(2)}" "%");
    print("Final Label : " + finallabel);
  }
}

class FacePainter extends CustomPainter {
  final ui.Image image;
  final List<Face> faces;
  final List<Rect> rects = [];

  FacePainter(this.image, this.faces) {
    for (var i = 0; i < faces.length; i++) {
      rects.add(faces[i].boundingBox);
    }
  }

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.yellow;

    canvas.drawImage(image, Offset.zero, Paint());
    for (var i = 0; i < faces.length; i++) {
      canvas.drawRect(rects[i], paint);
    }
  }

  @override
  bool shouldRepaint(FacePainter old) {
    return image != old.image || faces != old.faces;
  }
}
