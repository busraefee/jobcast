class OnboardModel {
  String lottieImage;
  String title;

  OnboardModel({
    required this.lottieImage,
    required this.title,
  });
}

List<OnboardModel> onboardList = [
  OnboardModel(
    lottieImage: 'assets/lottie/job.json',
    title: 'Para kazanmak mı istiyorsun?',
  ),
  OnboardModel(
    lottieImage: 'assets/lottie/clean2.json',
    title: 'Sana yakın işi bul!',
  ),
  OnboardModel(
    lottieImage: 'assets/lottie/dog.json',
    title: 'Kazanmaya başla!',
  )
];
