import 'package:flutter/material.dart';
import 'package:wallpaper_app/controller/api_operations.dart';
import 'package:wallpaper_app/model/category_model.dart';
import 'package:wallpaper_app/views/screens/full_screen.dart';
import 'package:wallpaper_app/views/widgets/category_block.dart';
import 'package:wallpaper_app/views/widgets/custom_appbar.dart';
import 'package:wallpaper_app/views/widgets/search_bar.dart';

import '../../model/photos_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<PhotosModel> trendingWallList;
  late List<CategoryModel> catModelList;
  bool isLoading = true;

  GetTrendingWallpapers() async{
    trendingWallList = await ApiOperations.getTrendingWallpaper();
    setState(() {
      isLoading = false;
    });
  }

  GetCategoryDetails() async{
    catModelList = await ApiOperations.getCategoriesList();
    setState(() {
      catModelList = catModelList;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetTrendingWallpapers();
    GetCategoryDetails();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: CustomAppBar(word1: 'Wall', word2: 'Wonders',),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body:isLoading ?
      Center(child: CircularProgressIndicator(),)
          : SafeArea(
            child: SingleChildScrollView(
        child: Column(
            children: [

              Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: SearchBar(),
              ),

              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                      itemCount: catModelList.length,
                      itemBuilder: (context, index){
                    return CategoryBlock(
                      categoryName: catModelList[index].catName, categoryImgSrc: catModelList[index].catImgUrl,);
                  }),
                ),
              ),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                height: MediaQuery.of(context).size.height,
                child: GridView.builder(
                  physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 400,  // for height
                  crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 14
                ),
                    itemCount: trendingWallList.length,
                    itemBuilder: (context, index){
                  return GridTile(
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => FullScreen(imgUrl: trendingWallList[index].imgSrc)));
                      },
                      child: Hero(
                        // tag => which thing to monitor that if it would be in next screen it should be animate
                        tag: trendingWallList[index].imgSrc,
                        child: Container(
                          height: 700,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.amberAccent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              trendingWallList[index].imgSrc,
                              // "https://images.pexels.com/photos/2291073/pexels-photo-2291073.jpeg?auto=compress&cs=tinysrgb&w=1200",
                            fit: BoxFit.cover,
                              height: 800,
                              width: 50,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),

            ],
        ),
      ),
          ),
    );
  }
}

