import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:whosapp/screens/camera_view.dart';
import 'package:whosapp/screens/select_gallery_image.dart';
import 'package:whosapp/screens/video_view.dart';

List<CameraDescription>? cameras;

class CameraScreen extends StatefulWidget {
  const CameraScreen(
      {Key? key, this.onImageSend, this.message, required this.id})
      : super(key: key);
  final Function? onImageSend;
  final String? message;
  final String id;

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _cameraController;
  Future<void>? cameraValue;
  bool isRecording = false;
  bool flash = false;
  bool isCameraFront = true;
  double transform = 0;

  @override
  void initState() {
    _cameraController = CameraController(cameras![0], ResolutionPreset.high);
    cameraValue = _cameraController!.initialize();
    super.initState();
  }

  @override
  void dispose() {
    _cameraController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
              future: cameraValue,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: CameraPreview(_cameraController!));
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          Positioned(
            bottom: 0.0,
            child: Container(
              color: Colors.black,
              padding: const EdgeInsets.only(top: 5, bottom: 15),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(
                          flash ? Icons.flash_on : Icons.flash_off,
                          color: Colors.white,
                          size: 26,
                        ),
                        onPressed: () {
                          setState(() {
                            flash = !flash;
                          });
                          flash
                              ? _cameraController!.setFlashMode(FlashMode.torch)
                              : _cameraController!.setFlashMode(FlashMode.off);
                        },
                      ),
                      GestureDetector(
                        onLongPress: widget.message != 'profile'
                            ? () async {
                                await _cameraController!.startVideoRecording();
                                setState(() {
                                  isRecording = true;
                                });
                              }
                            : () {},
                        onLongPressUp: widget.message != 'profile'
                            ? () async {
                                XFile video = await _cameraController!
                                    .stopVideoRecording();
                                setState(() {
                                  isRecording = false;
                                });

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (builder) => VideoView(
                                              path: video.path,
                                            )));
                              }
                            : () {},
                        onTap: () {
                          if (!isRecording) {
                            takePhoto(context);
                          }
                        },
                        child: isRecording
                            ? const Icon(
                                Icons.radio_button_on,
                                color: Colors.red,
                                size: 80,
                              )
                            : const Icon(
                                Icons.panorama_fish_eye,
                                color: Colors.white,
                                size: 75,
                              ),
                      ),
                      IconButton(
                        icon: Transform.rotate(
                          angle: transform,
                          child: const Icon(
                            Icons.flip_camera_ios,
                            color: Colors.white,
                            size: 26,
                          ),
                        ),
                        onPressed: () async {
                          setState(() {
                            transform = transform + pi;
                            isCameraFront = !isCameraFront;
                          });
                          int cameraPos = isCameraFront ? 0 : 1;
                          _cameraController = CameraController(
                              cameras![cameraPos], ResolutionPreset.high);
                          cameraValue = _cameraController!.initialize();
                        },
                      ),
                    ],
                  ),
                  widget.message != 'profile'
                      ? const SizedBox(height: 6)
                      : SizedBox(),
                  widget.message != 'profile'
                      ? const Text(
                          'Hold for video, tab for photo',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        )
                      : SizedBox(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void takePhoto(BuildContext context) async {
    XFile picture = await _cameraController!.takePicture();
    widget.message == 'profile'
        ? Navigator.push(
            context,
            MaterialPageRoute(
                builder: (builder) => SelectGalleryImage(
                      path: picture.path,
                      id: '2',
                    )))
        : Navigator.push(
            context,
            MaterialPageRoute(
                builder: (builder) => CameraViewPage(
                      path: picture.path,
                      onImageSend: widget.onImageSend,
                    )));
  }
}
