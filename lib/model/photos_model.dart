
class PhotosModel{
  String imgSrc;
  String phtographerName;

  PhotosModel({required this.imgSrc, required  this.phtographerName});
  // Api => Json
  // App => Map
  static PhotosModel fromApiToApp(Map<String, dynamic> photosMap){
    return PhotosModel(imgSrc: (photosMap["src"])["portrait"], phtographerName: photosMap["photographer"]);
  }

}
