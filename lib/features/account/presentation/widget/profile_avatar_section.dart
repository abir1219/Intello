import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intello_new/core/constants/app_colors.dart';


class ProfileAvatarSection extends StatelessWidget {
  final VoidCallback onTap;
  final String? imagePath;

  const ProfileAvatarSection({
    super.key,
    required this.onTap,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Stack(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: AppColors.whiteColor,
                backgroundImage: imagePath != null &&
                    imagePath!.isNotEmpty
                    ? FileImage(File(imagePath!))
                    : null,
                child: imagePath == null ||
                    imagePath!.isEmpty
                    ? const Icon(Icons.person, size: 40)
                    : null,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: AppColors.CLOSE_COLOR,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.edit,
                    size: 14,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(width: 16),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Changer la photo de profil",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 4),
            Text(
              "Modifier vos informations personnelles.",
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 12,
              ),
            ),
          ],
        )
      ],
    );
  }
}
