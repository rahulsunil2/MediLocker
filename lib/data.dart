class SliderModel {
  String imageAssetPath;
  String title;
  String desc;

  SliderModel({this.imageAssetPath, this.title, this.desc});

  void setImageAssetPath(String getImageAssetPath) {
    imageAssetPath = getImageAssetPath;
  }

  void setTitle(String getTitle) {
    title = getTitle;
  }

  void setDesc(String getDesc) {
    desc = getDesc;
  }

  String getImageAssetPath() {
    return imageAssetPath;
  }

  String getTitle() {
    return title;
  }

  String getDesc() {
    return desc;
  }
}

List<SliderModel> getSlides() {
  List<SliderModel> slides = new List<SliderModel>();
  SliderModel sliderModel = new SliderModel();

  //1
  sliderModel.setDesc("We hold your Medical Data for you");
  sliderModel.setTitle("Collect Data......");
  sliderModel.setImageAssetPath("images/Add files-bro.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //2
  sliderModel.setDesc(
      "Remote delivery of Healthcare Services like consultations, over the telecommunications infrastructure.");
  sliderModel.setTitle("Telemedicine..... ");
  sliderModel.setImageAssetPath("images/Online Doctor-bro.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //3
  sliderModel.setDesc(
      "We monitor and track Medical-related metrics and keep u alerted");
  sliderModel.setTitle("Health Tracker........");
  sliderModel.setImageAssetPath("images/Data-bro.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  return slides;
}
