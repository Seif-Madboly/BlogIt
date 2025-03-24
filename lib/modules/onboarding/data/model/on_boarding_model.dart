import 'package:news_app/core/utils/app_assets.dart';

class OnBoardingModel {
  final String title;
  final String image;
  final String description;

  OnBoardingModel({
    required this.title,
    required this.image,
    required this.description,
  });
}



final List<OnBoardingModel> onboarding = [
  OnBoardingModel(
    title: "Get the News You Need",
    description:
        "Stay informed anytime, anywhere with reliable news coverage right at your fingertips.",
    image: AppSvgAssets.onBoarding_1,
  ),
  OnBoardingModel(
    title: "Personalized for You",
    description:
        "Select your interests and get the stories that matter most to you.",
    image: AppSvgAssets.onBoarding_2,
  ),
  OnBoardingModel(
    title: "Never Miss a Story",
    description:
        "Get instant alerts for breaking news and updates, so you're always in the loop.",
    image: AppSvgAssets.onBoarding_3,
  ),
];
