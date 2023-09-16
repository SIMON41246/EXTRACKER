import 'dart:async';

import '../../../models/slide_object.dart';
import '../../common/app_strings.dart';
import '../../common/base_view_model.dart';
import '../../common/image_assets.dart';


class OnboardingViewModel extends BaseViewModel
    implements OnboardingViewModelInputs, OnboardingViewModelOutputs {
  // Declare Stream Controller
  StreamController _streamController = StreamController<SliderViewObject>();
  late final List<SlideObject> _list;
  int _currentIndex = 0;

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list = _getSlideObject();
    postDataToview();
  }

  @override
  int goNext() {
    int nextindex = ++_currentIndex;
    if (nextindex == _list.length) {
      nextindex = 0;
    }
    return nextindex;
  }

  @override
  int goPrevious() {
    int previousindex = --_currentIndex;
    if (previousindex == -1) {
      previousindex = _list.length - 1;
    }
    return previousindex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    postDataToview();
  }

  @override
  Sink get inputslideViewObject => _streamController.sink;

  @override
  Stream<SliderViewObject> get outputSlideViewObject =>
      _streamController.stream.map((event) => event);

  void postDataToview() {
    inputslideViewObject.add(
        SliderViewObject(_list[_currentIndex], _currentIndex, _list.length));
  }

  // Onboarding page
  List<SlideObject> _getSlideObject() => [
        SlideObject(
            AppStrings.onboardingTitle,
            AppStrings.onboardingsubtitle,
            ImageAssets.Onboardinglogo1),
        SlideObject(
            AppStrings.onboardingTitle2,
            AppStrings.onboardingsubtitle2,
            ImageAssets.Onboardinglogo2),
        SlideObject(
            AppStrings.onboardingTitle3,
            AppStrings.onboardingsubtitle3,
            ImageAssets.Onboardinglogo3),
        SlideObject(
            AppStrings.onboardingTitle4,
            AppStrings.onboardingsubtitle4,
            ImageAssets.Onboardinglogo4)
      ];
}

abstract class OnboardingViewModelInputs {
  // Orders taked from view
  int goNext(); // Go to next page in vieW

  int goPrevious(); // Go to previous page

  void onPageChanged(int index); // Change page

  // InputStream put data in sink
  Sink get inputslideViewObject;
}

abstract class OnboardingViewModelOutputs {
  // OutputStream get data from streamcontroller
  Stream<SliderViewObject> get outputSlideViewObject;
}
