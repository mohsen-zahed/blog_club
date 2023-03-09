class StoryModel {
  late int _id;
  late String _image;
  late String _iconFilePath;
  late String _name;
  StoryModel.initial();
  StoryModel.init({
    required int id,
    required String image,
    required String iconFilePath,
    required String name,
  }) {
    _id = id;
    _image = 'assets/img/stories/$image.jpg';
    _iconFilePath = 'assets/img/icons/$iconFilePath.png';
    _name = name;
  }
  int getId() => _id;
  String getImage() => _image;
  String getIconFilePath() => _iconFilePath;
  String getName() => _name;
}
