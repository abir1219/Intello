import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intello_new/core/constants/app_assets.dart';

import '../../../../core/audio/audio_player_service.dart';
import '../domain/entities/category_entity.dart';

class CategoryCard extends StatelessWidget {
  final CategoryEntity category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final audioService = AudioPlayerService();

    return Stack(
      clipBehavior: Clip.none,
      children: [
        /// 🔹 Main Card
        Container(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// 🔹 Category Illustration (PNG)
              SizedBox(
                height: 110,
                child: Image.asset(
                  category.image,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 16),

              /// 🔹 Title
              Text(
                category.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 6),

              /// 🔹 Listen Action
              GestureDetector(
                onTap: () => audioService.playAsset(category.audio),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Écouter",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 6),
                    Icon(Icons.volume_up, size: 18, color: Colors.blue),
                  ],
                ),
              ),
            ],
          ),
        ),

        /// 🔹 Play Button (INSIDE bottom-right corner)
        Positioned(
          bottom: -18,
          right: -18,
          child: GestureDetector(
            onTap: () => audioService.playAsset(category.audio),
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SvgPicture.asset(AppAssets.playButton),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/*class CategoryCard extends StatelessWidget {
  final CategoryEntity category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final audioService = AudioPlayerService();

    return Stack(
      children: [
        /// 🔹 Main Card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// 🔹 Image
              SizedBox(
                height: 90,
                child: SizedBox(child: SvgPicture.asset(category.image)),
                */ /*Image.asset(
                  category.image,
                  fit: BoxFit.contain,
                ),*/ /*
              ),

              const SizedBox(height: 12),

              /// 🔹 Title
              Text(
                category.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 6),

              /// 🔹 Listen Action
              InkWell(
                onTap: () => audioService.playAsset(category.audio),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Écouter",
                      style: TextStyle(color: Colors.blue, fontSize: 14),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.volume_up, size: 18, color: Colors.blue),
                  ],
                ),
              ),
            ],
          ),
        ),

        /// 🔹 Play Button (Bottom Right)
        Positioned(
          bottom: -5,
          right: -20,
          child: GestureDetector(
            onTap: () {
              // optional: same action or navigation
              audioService.playAsset(category.audio);
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SvgPicture.asset(
                  AppAssets.playButton,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}*/
