import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smartfarm_hackathon/ui/widgets/snackbar.dart';

import '../constant.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _cameraController;
  bool _isRearCameraSelected = true;
  bool _isTakingPicture = false;
  List<CameraDescription>? cameras;

  @override
  void dispose() {
    if (_cameraController != null) {
      if (_cameraController!.value.isInitialized) {
        _cameraController!.dispose().then((value) => null);
      }
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    availableCameras().then((value) {
      cameras = value;
      initCamera(cameras![0]);
    }).catchError((e) {
      debugPrint("error init camera: $e");
    });
  }

  void changeCamera() {
    try {
      setState(() => _isRearCameraSelected = !_isRearCameraSelected);
      initCamera(cameras![_isRearCameraSelected ? 0 : 1]);
    } catch (e) {
      showSnackBar(
        context,
        "Terjadi masalah dalam mengganti kamera",
      );
      debugPrint("camera swith error: $e");
    }
  }

  Future takePicture() async {
    if (!_cameraController!.value.isInitialized) {
      return null;
    }
    if (_cameraController!.value.isTakingPicture) {
      return null;
    }
    try {
      await _cameraController!.setFlashMode(FlashMode.off);
      XFile picture = await _cameraController!.takePicture();
      if (!mounted) return;

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => AddAttendanceSecondPage(
      //       picture: picture,
      //     ),
      //   ),
      // );
    } on CameraException catch (e) {
      debugPrint('Error occured while taking picture: $e');
      return null;
    }
  }

  Future initCamera(CameraDescription cameraDescription) async {
    _cameraController =
        CameraController(cameraDescription, ResolutionPreset.high);
    try {
      await _cameraController!.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      });
    } on CameraException catch (e) {
      debugPrint("camera error $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraController == null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: greenMainColor,
          title: const Text("Kamera"),
        ),
        body: SafeArea(
          child: Container(
            color: Colors.black,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: greenMainColor,
        title: const Text("Kamera"),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            (_cameraController!.value.isInitialized)
                ? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: CameraPreview(
                      _cameraController!,
                    ),
                  )
                : Container(
                    color: Colors.black,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(
                      borderRadius * 2,
                    ),
                  ),
                  color: Colors.black.withOpacity(0.5),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 30,
                        icon: const Icon(
                          Icons.loop,
                          color: Colors.white,
                        ),
                        onPressed: changeCamera,
                      ),
                    ),
                    Expanded(
                      child: _isTakingPicture
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : IconButton(
                              onPressed: () async {
                                setState(() {
                                  _isTakingPicture = true;
                                });
                                await takePicture();
                                setState(() {
                                  _isTakingPicture = false;
                                });
                              },
                              iconSize: 50,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              icon: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              ),
                            ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
