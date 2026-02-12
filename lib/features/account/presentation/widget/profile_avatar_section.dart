import 'package:flutter/material.dart';
import 'package:intello_new/core/constants/app_colors.dart';

class ProfileAvatarSection extends StatelessWidget {
  const ProfileAvatarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 35,
              backgroundColor: Color(0xFFEAEAEA),
              child: Icon(Icons.person, size: 40, color: AppColors.greenColor),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration:  BoxDecoration(
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