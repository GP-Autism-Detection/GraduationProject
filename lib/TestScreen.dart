import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);
  @override
  State<TestScreen> createState() => _TestScreen();
}

class _TestScreen extends State<TestScreen> {
  List<File> selectedImages = [];
  List<double> conf = [];
  var totalconf = 0.0;
  bool finalconf = false;
  late File _image;
  late List _results;
  bool imageSelect = true;
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
        model: "assets/model.tflite", labels: "assets/model.txt"))!;
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
      _image = image;
      imageSelect = false;
    });

    print('Confidence: ${(_results[0]['confidence']).toStringAsFixed(2)}' "%");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
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
                  child: imageSelect == true
                      ? null //show nothing if no picture selected
                      : Container(
                          child: Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.width * 0.83,
                                width: MediaQuery.of(context).size.width * 0.83,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    _image,
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
                                      'Result: ${_results[0]['label']}'
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
                        finalconf = false;
                        conf.clear();
                        totalconf = 0.0;
                        selectedImages.clear();
                        uploadImage2();
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
    imageClassification(image);
  }

  Future pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
    );
    File image = File(pickedFile!.path);
    imageClassification(image);
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      totalconf = _results[0]['confidence'];
      finalconf = true;
    });
  }

  Future uploadImage2() async {
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
      await Future.delayed(const Duration(seconds: 1));
      imageClassification(selectedImages[i]);
      await Future.delayed(const Duration(seconds: 1));
      conf.add(_results[0]['confidence']);
      totalconf += conf[i];
    }
    setState(() {
      totalconf = totalconf / selectedImages.length;
      finalconf = true;
    });

    print("Final Confidence : ${(totalconf * 100).toStringAsFixed(2)}" "%");
  }
}
