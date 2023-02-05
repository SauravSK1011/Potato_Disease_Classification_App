import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tdcapp/helper/Predict.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var predictionimage;
  final imagepicker = ImagePicker();
  File _imagefile = File('assets/image.png');
  bool isImageLoded = false;
  _imageformgallery() async {
    await Future.delayed(const Duration(seconds: 1), () {});
    var image = await imagepicker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return null;
    } else {
      setState(() {
        _imagefile = File(image.path);
        isImageLoded = true;
      });
    }
  }

  _imageformcamara() async {
    await Future.delayed(const Duration(seconds: 1), () {});
    var image = await imagepicker.pickImage(source: ImageSource.camera);
    if (image == null) {
      return null;
    } else {
      setState(() {
        _imagefile = File(image.path);
        isImageLoded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var predictionimage = "";
    bool t = false;
    var output = "";
    var isImageLoded1 = false;
    return Scaffold(
      body: Container(
        width: width,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            height: height / 18,
          ),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
            color: Colors.white,
            elevation: 25,
            child: const Padding(
              padding:
                  EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
              child: Text(
                "Crop Disease Prediction",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          !isImageLoded
              ? Text("Please choose a image first",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))
              : Container(),
          isImageLoded
              ? Center(
                  child: Container(
                    height: 250,
                    width: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: FileImage(_imagefile),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                )
              : Container(),
          const SizedBox(
            height: 50,
          ),
          isImageLoded
              ? ElevatedButton(
                  onPressed: () async {
                    predictionimage = (await Predict.predictimg(_imagefile));
                    var snackBar1 = SnackBar(
                        content: Text(
                            "Pridiction is " + predictionimage.toString()));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar1);
                    ;
                    print(predictionimage.toString());
                  },
                  child: Text(
                    "Predict",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                )
              : Container(),
        ]),
      ),
      floatingActionButton: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height - 186,
          ),
          SpeedDial(
            animatedIcon: AnimatedIcons.menu_close,
            backgroundColor: Colors.blue,
            overlayColor: Colors.black,
            overlayOpacity: 0.7,
            children: [
              SpeedDialChild(
                child: const Icon(Icons.add_a_photo),
                label: "Add Image from Camera",
                onTap: () {
                  // output = "";

                  // finaltext = "";
                  _imageformcamara();
                },
              ),
              SpeedDialChild(
                child: const Icon(Icons.add_photo_alternate_rounded),
                label: "Add Image from Gallery",
                onTap: () {
                  // output = "";

                  // finaltext = "";
                  _imageformgallery();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
