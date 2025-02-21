import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gal/gal.dart';
import 'package:twitter/views/users/widgets/custom_button.dart';
import 'package:twitter/utils.dart';

class PhotoPreviewScreen extends ConsumerStatefulWidget {
  final XFile photo;
  final bool isPicked;

  const PhotoPreviewScreen({
    super.key,
    required this.photo,
    required this.isPicked,
  });

  @override
  PhotoPreviewScreenState createState() => PhotoPreviewScreenState();
}

class PhotoPreviewScreenState extends ConsumerState<PhotoPreviewScreen> {
  bool _savedPhoto = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _saveToGallery() async {
    if (_savedPhoto) return;

    String newFilePath = widget.photo.path;

    await Gal.putImage(newFilePath);

    _savedPhoto = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(ref);
    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        title: const Text('Preview photo'),
        actions: [
          if (!widget.isPicked)
            IconButton(
              onPressed: _saveToGallery,
              icon: FaIcon(
                _savedPhoto
                    ? FontAwesomeIcons.check
                    : FontAwesomeIcons.download,
              ),
            )
        ],
      ),
      body: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Image.file(
            File(widget.photo.path),
          ),
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: isDark ? Colors.black : Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => {
                Navigator.of(context).pop(),
                Navigator.of(context).pop(widget.photo),
              },
              child: CustomButton(text: "Use Photo"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: CustomButton(text: "Retake"),
            ),
          ],
        ),
      ),
    );
  }
}
