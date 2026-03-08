import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intello_new/core/constants/app_assets.dart';

import '../../../../core/audio/audio_player_service.dart';
import '../domain/entities/category_entity.dart';

class CategoryCard extends StatefulWidget {
  final CategoryEntity category;

  const CategoryCard({super.key, required this.category});

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
   late final audioService;

  @override
  void initState() {
    audioService = AudioPlayerService();
    super.initState();
  }

  @override
  void dispose() {
    audioService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

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
                  widget.category.image,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 16),

              /// 🔹 Title
              Text(
                widget.category.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 6),

              /// 🔹 Listen Action
              GestureDetector(
                onTap: () async{
                  if (audioService.isPlaying) {
                    await audioService.stop();
                  }else {
                    audioService.playAsset(widget.category.audio);
                  }
                },
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
            onTap: () async{
              if (audioService.isPlaying) {
                await audioService.stop();
              }
              audioService.playAsset(widget.category.audio);
            },
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