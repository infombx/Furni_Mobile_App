import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePicture extends StatelessWidget {
  final String? imagePath; // local
  final String? imageUrl; // network
  final Function(String)? onImageSelected;

  const ProfilePicture({
    super.key,
    this.imagePath,
    this.imageUrl,
    this.onImageSelected,
  });

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery, // or camera
      imageQuality: 80,
    );

    if (pickedFile == null) return;

    onImageSelected?.call(pickedFile.path);
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider imageProvider;

    if (imagePath != null) {
      imageProvider = FileImage(File(imagePath!));
    } else if (imageUrl != null) {
      imageProvider = NetworkImage(imageUrl!);
    } else {
      imageProvider = const AssetImage('assets/images/profile_picture.jpg');
    }

    return Stack(
      children: [
        CircleAvatar(radius: 70, backgroundImage: imageProvider),
        Positioned(
          bottom: -3,
          right: -8,
          child: IconButton(
            onPressed: () => _pickImage(context),
            icon: SvgPicture.asset(
              'assets/images/camera_icon.svg',
              width: 35,
              height: 35,
            ),
          ),
        ),
      ],
    );
  }
}
