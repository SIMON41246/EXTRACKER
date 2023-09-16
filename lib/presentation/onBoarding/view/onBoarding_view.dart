// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:expenses/presentation/common/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../app/app_preferences.dart';
import '../../../app/di.dart';
import '../../../app/routes.dart';
import '../../../models/slide_object.dart';
import '../../common/image_assets.dart';
import '../../common/values_manager.dart';
import '../view_model/onboarding_viewmodel.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  PageController _pageController = PageController();
  OnboardingViewModel _viewModel = OnboardingViewModel();
  final AppPrefrences _apprefrences = instance<AppPrefrences>();

  _bind() {
    _apprefrences.setOnBoardingViewScreenViewed();
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _viewModel.outputSlideViewObject,
      builder: (context, snapshot) => getContentWidget(snapshot.data),
    );
  }

  Widget getContentWidget(SliderViewObject? sliderViewObject) {
    if (sliderViewObject == null) {
      return Container();
    } else {
      return Scaffold(
        backgroundColor: color_manager.white,
        appBar: AppBar(
            elevation: 0,
            backgroundColor: color_manager.white,
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: color_manager.white,
                statusBarBrightness: Brightness.dark)),
        body: PageView.builder(
          itemCount: sliderViewObject.numberofslides,
          itemBuilder: (context, index) {
            return Onboarding_Page(sliderViewObject.slideObject);
          },
          onPageChanged: (index) {
            _viewModel.onPageChanged(index);
          },
          controller: _pageController,
        ),
        bottomSheet: Container(
          color: color_manager.white,
          height: AppSize.s100,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Get.offNamed(Routes.home);
                    ;
                  },
                  child: Text(
                    "skip",
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
              getbottomsheetwidget(sliderViewObject)
            ],
          ),
        ),
      );
    }
  }

  Widget getbottomsheetwidget(SliderViewObject sliderViewObject) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(66, 155, 140, 100),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // left widget
          Padding(
            padding: EdgeInsets.all(AppPaddingManager.p14),
            child: GestureDetector(
              child: SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.arrowleft),
              ),
              onTap: () {
                _pageController.animateToPage(_viewModel.goPrevious(),
                    duration: Duration(milliseconds: 250),
                    curve: Curves.bounceInOut);
              },
            ),
          ),

          Row(
            children: [
              for (int i = 0; i < sliderViewObject.numberofslides; i++)
                Padding(
                  padding: EdgeInsets.all(AppPaddingManager.p8),
                  child: getProperCircle(i, sliderViewObject.currentindex),
                )
            ],
          ),

          //right widget
          Padding(
            padding: EdgeInsets.all(AppPaddingManager.p14),
            child: GestureDetector(
              onTap: () {
                _pageController.animateToPage(_viewModel.goNext(),
                    duration: Duration(milliseconds: 250),
                    curve: Curves.bounceInOut);
              },
              child: SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.arrowright),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getProperCircle(int index, int _currentIndex) {
    if (index == _currentIndex) {
      return SvgPicture.asset(ImageAssets.indicatortrue);
    } else {
      return SvgPicture.asset(ImageAssets.indicatorfalse);
    }
  }
}

class Onboarding_Page extends StatelessWidget {
  SlideObject _slideObject;

  Onboarding_Page(this._slideObject, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: AppSize.s40,
        ),
        Padding(
          padding: const EdgeInsets.all(AppPaddingManager.p8),
          child: Text(
            _slideObject.title,
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
                fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPaddingManager.p8),
          child: Text(
            _slideObject.subtitile,
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(fontSize: 15, color: Colors.black),
          ),
        ),
        SizedBox(
          height: 80,
        ),
        Center(
            child: Image.asset(
          _slideObject.image,
          fit: BoxFit.contain,
          width: 400,
          height: 300,
        ))
      ],
    );
  }
}
