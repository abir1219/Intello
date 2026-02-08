import 'package:intello_new/core/constants/app_assets.dart';

import '../../domain/entities/onboarding_entity.dart';

class OnboardingModel extends OnboardingEntity {
  const OnboardingModel({
    required super.title,
    required super.description,
    required super.image,
  });
}
final onboardingData = [
  OnboardingModel(
    title: "Bienvenue sur Intello !",
    description:
    "Découvre et révise tes leçons avec des exercices et jeux éducatifs.",
    image: AppAssets.onboarding1,
  ),
  OnboardingModel(
    title: "Apprends à ton rythme",
    description: "Progresse facilement avec des contenus adaptés.",
    image: AppAssets.onboarding1,
  ),
];
