import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intello_new/core/constants/app_assets.dart';

import '../../../../core/audio/audio_player_service.dart';
import '../domain/entities/category_entity.dart';

class CategoryCard extends StatelessWidget {
  final CategoryEntity category;

  const CategoryCard({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final audioService = AudioPlayerService();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Image.asset(category.image, height: 90),
          SizedBox(
            child: SvgPicture.asset(AppAssets.logo),
          ),
          const SizedBox(height: 12),

          Text(
            category.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 6),

          InkWell(
            onTap: () => audioService.playAsset(category.audio),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Écouter",
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
                SizedBox(width: 4),
                Icon(Icons.volume_up, size: 18, color: Colors.blue),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
