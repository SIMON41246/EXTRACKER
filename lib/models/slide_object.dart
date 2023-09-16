class SlideObject {
  String title;
  String subtitile;
  String image;

  SlideObject(this.title, this.subtitile, this.image);
}

class SliderViewObject {
  SlideObject slideObject;
  int numberofslides;
  int currentindex;

  SliderViewObject(this.slideObject, this.currentindex, this.numberofslides);
}