
class CategoryModel{
  String catName;
  String catImgUrl;

  CategoryModel({required this.catName, required this.catImgUrl});

  static CategoryModel fromApi2App(Map<String, dynamic> categoryMap){
    return CategoryModel(catName: categoryMap["imgUrl"], catImgUrl: categoryMap["CategoryName"]);
  }

}