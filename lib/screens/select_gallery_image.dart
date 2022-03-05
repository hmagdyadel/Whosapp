import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:whosapp/model/utility.dart';
import 'package:whosapp/screens/profile_details.dart';

class SelectGalleryImage extends StatefulWidget {
  const SelectGalleryImage({Key? key, this.path, required this.id})
      : super(key: key);
  final String? path;
  final String id;

  @override
  State<SelectGalleryImage> createState() => _SelectGalleryImageState();
}

class _SelectGalleryImageState extends State<SelectGalleryImage> {
  double transform = 0;
  File? image;

  @override
  void initState() {
    cropImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 130,
              child: Transform.rotate(
                angle: transform,
                child: image == null
                    ? Image.file(
                        File(widget.path!),
                        fit: BoxFit.contain,
                      )
                    : Image.file(
                        image!,
                        fit: BoxFit.contain,
                      ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel',
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                    IconButton(
                      onPressed: () async {
                        setState(() {
                          transform = transform + pi / 2;
                        });
                      },
                      icon: Icon(
                        Icons.rotate_90_degrees_ccw,
                        color: Colors.white,
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        try {
                          Utility.saveImageToPreferences(image!, transform);
                          if (widget.id == '1')
                            Navigator.pop(context);
                          else if (widget.id == '2') {
                            for (int i = 0; i < 2; i++) {
                              Navigator.pop(context);
                            }
                          } else if (widget.id == '3') {
                            for (int i = 0; i < 2; i++) {
                              Navigator.pop(context);
                            }
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => ProfileDetails()));
                          } else {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (builder) => ProfileDetails(),
                              ),
                            );
                          }
                        } catch (e) {
                          print('error');
                        }
                      },
                      child: Text(
                        'Done',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  cropImage() async {
    File? croppedFile = await ImageCropper.cropImage(
      sourcePath: widget.path!,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9,
      ],
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: 'Crop',
        toolbarColor:  const Color(0xFF075E54),
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
      ),
    );
    if (croppedFile != null) {
      setState(() {
        image = croppedFile;
      });
    }
  }
}
