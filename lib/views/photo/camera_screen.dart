import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:twitter/constants/gaps.dart';
import 'package:twitter/constants/sizes.dart';
import 'package:twitter/views/photo/photo_preview_screen.dart';
import 'package:twitter/utils.dart';

class CameraScreen extends ConsumerStatefulWidget {
  const CameraScreen({super.key});

  @override
  CameraScreenState createState() => CameraScreenState();
}

class CameraScreenState extends ConsumerState<CameraScreen>
    with WidgetsBindingObserver {
  bool _hasPermission = false;
  bool _isSelfieMode = false;
  bool _isCameraInitialized = false;

  late final bool _noCamera = kDebugMode && Platform.isIOS;

  late FlashMode _flashMode = FlashMode.off;
  CameraController? _cameraController;

  Future<void> initCamera() async {
    final cameras = await availableCameras();

    if (cameras.isEmpty) {
      return;
    }

    _cameraController = CameraController(
      cameras[_isSelfieMode ? 1 : 0],
      ResolutionPreset.ultraHigh,
      enableAudio: false,
    );

    await _cameraController!.initialize();

    if (mounted) {
      setState(() {
        _isCameraInitialized = true;
      });
    }

    await _cameraController!.takePicture();

    _flashMode = _cameraController!.value.flashMode;

    setState(() {});
  }

  Future<void> initPermissions() async {
    final cameraPermission = await Permission.camera.request();

    final cameraDenied =
        cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;

    if (!cameraDenied) {
      _hasPermission = true;
      await initCamera();
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    if (!_noCamera) {
      initPermissions();
    } else {
      setState(() {
        _hasPermission = true;
      });
    }
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_noCamera) return;
    if (!_hasPermission) return;
    if (!_isCameraInitialized) return;
    if (state == AppLifecycleState.inactive) {
      _cameraController?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      initCamera();
    }
  }

  Future<void> _toggleSelfieMode() async {
    _isSelfieMode = !_isSelfieMode;
    await initCamera();
    setState(() {});
  }

  Future<void> _setFlashMode(FlashMode newFlashMode) async {
    await _cameraController?.setFlashMode(newFlashMode);
    _flashMode = newFlashMode;
    setState(() {});
  }

  Future<void> _takePicture() async {
    final photo = await _cameraController!.takePicture();

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PhotoPreviewScreen(
          photo: photo,
          isPicked: false,
        ),
      ),
    );
  }

  Future<void> _onPickPhotoPressed() async {
    final photo = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (photo == null) return;
    if (!mounted) return;
    Navigator.pop(context, photo);
  }

  @override
  void dispose() {
    if (_isCameraInitialized) {
      _cameraController?.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = isDarkMode(ref);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 1,
      ),
      body: Container(
        width: size.width,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(
            Sizes.size36,
          )),
        ),
        child: !_hasPermission || !_isCameraInitialized
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Initializing...",
                    style:
                        TextStyle(color: Colors.white, fontSize: Sizes.size20),
                  ),
                  Gaps.v20,
                  CircularProgressIndicator.adaptive()
                ],
              )
            : SizedBox(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CameraPreview(_cameraController!),
                    Positioned(
                      top: Sizes.size16,
                      left: Sizes.size6,
                      child: Container(
                        alignment: Alignment.center,
                        child: IconButton(
                          color: Colors.white,
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const FaIcon(
                            FontAwesomeIcons.chevronLeft,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: Sizes.size44,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Sizes.size20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: IconButton(
                                color: _flashMode == FlashMode.off
                                    ? Colors.amber.shade200
                                    : Colors.white,
                                onPressed: () => _setFlashMode(FlashMode.off),
                                icon: const Icon(
                                  Icons.bolt,
                                  size: Sizes.size32,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: _takePicture,
                              child: SizedBox(
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Positioned(
                                      child: Container(
                                        width: 88,
                                        height: 88,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 4,
                                      left: 4,
                                      child: Container(
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            color: isDark
                                                ? Colors.white
                                                : Colors.black,
                                            width: 5,
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: IconButton(
                                color: Colors.white,
                                onPressed: _toggleSelfieMode,
                                icon: const FaIcon(
                                  FontAwesomeIcons.repeat,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            TextButton(
              onPressed: initCamera,
              child: Text(
                "Camera",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Sizes.size18,
                ),
              ),
            ),
            Expanded(
              child: TextButton(
                onPressed: _onPickPhotoPressed,
                child: Text(
                  "Library",
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: Sizes.size18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
