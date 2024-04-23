import 'package:get/get.dart';

import '../model/Intro_model.dart';

class IntroController extends GetxController {
  RxBool isLoading = true.obs;
  List<IntroModel> list = [];

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  void getData() {
    isLoading(true);

    IntroModel introModel = IntroModel();
    introModel.image = 'splash_1.png';
    introModel.title = 'Play Best Quiz';
    introModel.desc =
        'Lorem ipsum dolor sit amet, consectetur incididunt ut labore et dolore magna aliqua.';
    introModel.icon = 'splash_vector_1.png';
    list.add(introModel);

    introModel = IntroModel();
    introModel.image = 'splash_2.png';
    introModel.title = 'Use Your Brain';
    introModel.desc =
        'Lorem ipsum dolor sit amet, consectetur incididunt ut labore et dolore magna aliqua.';
    introModel.icon = 'splash_vector_2.png';
    list.add(introModel);

    introModel = IntroModel();
    introModel.image = 'splash_3.png';
    introModel.title = 'Newly Concept';
    introModel.desc =
        'Lorem ipsum dolor sit amet, consectetur incididunt ut labore et dolore magna aliqua.';
    introModel.icon = 'splash_vector_3.png';
    list.add(introModel);

    introModel = IntroModel();
    introModel.image = 'splash_4.png';
    introModel.title = 'Let\'s Play';
    introModel.desc =
        'Lorem ipsum dolor sit amet, consectetur incididunt ut labore et dolore magna aliqua.';
    introModel.icon = 'splash_vector_4.png';
    list.add(introModel);

    isLoading(false);
  }
}
