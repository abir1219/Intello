import 'package:flutter/material.dart';
import 'package:intello_new/core/constants/app_assets.dart';
import 'package:intello_new/core/constants/app_colors.dart';

import '../../../../core/audio/audio_player_service.dart';

class ListenButton extends StatelessWidget {
  final String listenString;
  final VoidCallback onTap;

  const ListenButton({super.key, required this.onTap,required this.listenString});

  @override
  Widget build(BuildContext context) {

    return ElevatedButton.icon(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF0F8F5A),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      icon: const Icon(Icons.music_note, color: Colors.white),
      label: Text(listenString, style: TextStyle(fontWeight: FontWeight.w700,color: AppColors.whiteColor)),
    );
  }
}
