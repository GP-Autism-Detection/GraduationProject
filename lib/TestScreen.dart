import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:graduation_project_app/MenuScreen.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image/image.dart' as img;
import 'dart:ui' as ui;
import 'package:path_provider/path_provider.dart';

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
  late File file1;
  late File croppedFile;
  late var finallabel = '';
  // if (tempDir.existsSync()) {
  //   tempDir.deleteSync(recursive: true);
  // }
  //tempDir.deleteSync(recursive: true);
  //tempDir.create();
  //late File croppedFile;
  //late File file1;
  @override
  void initState() {
    super.initState();

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
        backgroundColor: Colors.lightBlue,
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
          'Autisim Classification',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 23,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 35, vertical: 50),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
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
                              Container(
                                key: key,
                                height:
                                    MediaQuery.of(context).size.width * 0.83,
                                width: MediaQuery.of(context).size.width * 0.83,
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
                                      'Result: $finallabel'
                                      "\n"
                                      'Confidence : ${(totalconf * 100).toStringAsFixed(2)} %',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  : Container(),
                              Divider(
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
                      onTap: pickImage,
                      child: Container(
                        width: MediaQuery.of(context).size.width - 150,
                        alignment: Alignment.center,
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 17),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          'Take A Photo',
                          style: TextStyle(color: Colors.white, fontSize: 16),
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
                        //file1.delete();
                        //croppedFile.delete();
                        //print(key.currentContext?.size);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width - 150,
                        alignment: Alignment.center,
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 17),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          'Pick From Gallery',
                          style: TextStyle(color: Colors.white, fontSize: 16),
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
    );
  }

  Future uploadImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    File image = File(pickedFile!.path);
    //imageClassification(image);
    final options = FaceDetectorOptions();
    final faceDetector = FaceDetector(options: options);
    final inputImage = InputImage.fromFile(image);

    final List<Face> faces = await faceDetector.processImage(inputImage);

    if (mounted) {
      _loadImage(image);
      setState(() {
        _faces = faces;
      });
    }
  }

  Future _loadImage(File file) async {
    final data = await file.readAsBytes();

    await decodeImageFromList(data).then((value) => setState(() {
          _uiimage = value;
          getImage();
        }));
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
    cropimage(_faces);

    setState(() {
      _uiimage = renderedImage;
      imgbytes = bytes;
    });
  }

  Future cropimage(List<Face> faces) async {
    int x = faces[0].boundingBox.left.toInt();
    int y = faces[0].boundingBox.top.toInt();
    int w = faces[0].boundingBox.width.toInt();
    int h = faces[0].boundingBox.height.toInt();

    final Directory tempDir = await getTemporaryDirectory();

    // if (tempDir.existsSync()) {
    //   tempDir.deleteSync(recursive: true);
    // }
    //tempDir.deleteSync(recursive: true);
    //tempDir.create();
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

    //final tempDir2 = await getTemporaryDirectory();
    //tempDir2.deleteSync(recursive: true);
    //tempDir2.create();
    croppedFile = File("${tempDir.path}/image$counter _cropped.png");

    croppedFile.writeAsBytes(jpg);
    counter++;
    croppedImages.add(croppedFile);
    //await Future.delayed(const Duration(seconds: 1));

    //_Croppedfile = croppedFile;

    //await Future.delayed(const Duration(seconds: 1));
    await Future.delayed(const Duration(seconds: 1));
    imageClassification(croppedFile);
    //await Future.delayed(const Duration(seconds: 1));
    //await Future.delayed(const Duration(seconds: 1));
    // await Future.delayed(const Duration(seconds: 1));

    // setState(() {
    //   imagecrop =true;
    // });

    // setState(() {
    //   //_Croppedfile = croppedFile;
    // });
  }

  Future pickImage() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
    );
    File image = File(pickedFile!.path);
    imageClassification(image);
    await Future.delayed(const Duration(seconds: 1));
    Navigator.of(context).pop();
    setState(() {
      _image = image;
      totalconf = _results[0]['confidence'];
      finallabel = _results[0]['label'];
      finalconf = true;
      imageSelect = false;
      imagecrop = true;
      _Croppedfile = image;
    });
  }

  Future uploadImage2() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
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
    //Loading Circle Screen
    for (var i = 0; i < selectedImages.length; i++) {
      final options = FaceDetectorOptions();
      final faceDetector = FaceDetector(options: options);
      final inputImage = InputImage.fromFile(selectedImages[i]);

      final List<Face> faces = await faceDetector.processImage(inputImage);
      _faces = faces;

      if (mounted) {
        //await Future.delayed(const Duration(seconds: 1));
        setState(() {
          _image = selectedImages[i];
        });

        _loadImage(selectedImages[i]);

        //await imageClassification;
        await Future.delayed(const Duration(seconds: 1));
        await Future.delayed(const Duration(seconds: 1));
        await Future.delayed(const Duration(seconds: 1));
        await Future.delayed(const Duration(seconds: 1));
        await Future.delayed(const Duration(seconds: 1));
        //await Future.delayed(const Duration(seconds: 1));
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
      // await Future.delayed(const Duration(seconds: 1));
      // conf.add(_results[0]['confidence']);
      // totalconf += conf[i];
    }

    GetResults();
  }

  Future GetResults() async {
    //await Future.delayed(const Duration(seconds: 3));

    if (selectedImages.length > 1) {
      for (var i = 0; i < selectedImages.length; i++) {
        if (labels[i] == 'Autistic') {
          totalconf += conf[i];
        } else if (labels[i] == 'Non-autistic') {
          totalconf += 1 - conf[i];

          // if(conf[i]>(1-conf[i+1])){
          //   finallabel=labels[i];
          // }
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
      // if(totalconf<0.5) {
      //   totalconf = 1 - totalconf;
      //   setState(() {
      //     finallabel = 'Non-autistic';
      //   });
      // }
      // else if (totalconf> 0.5){
      //   setState(() {
      //     finallabel = 'Autistic';
      //   });
      // }
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
      //finallabel = 'Autistic';
      finalconf = true;
      //file1.delete();
      //croppedFile.delete();
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
