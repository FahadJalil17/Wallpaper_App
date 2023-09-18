import 'package:flutter/material.dart';
import 'package:wallpaper_app/controller/api_operations.dart';
import 'package:wallpaper_app/views/widgets/category_block.dart';
import 'package:wallpaper_app/views/widgets/custom_appbar.dart';
import 'package:wallpaper_app/views/widgets/search_bar.dart';

import '../../model/photos_model.dart';
import 'full_screen.dart';

class CategoryScreen extends StatefulWidget {
  String catName;
  String catImgUrl;
  CategoryScreen({Key? key, required this.catName, required this.catImgUrl}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late List<PhotosModel> categoryResults;
  bool isLoading = true;

  getCatResWall() async{
    categoryResults = await ApiOperations.searchWallpapers(widget.catName);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCatResWall();
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
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.black,),
        ),
      ),
      body: isLoading ? Center(child: CircularProgressIndicator(),)
          : SingleChildScrollView(
        child: Column(
          children: [

            Stack(
              children: [
                Image.network(
                  // "https://images.pexels.com/photos/1574843/pexels-photo-1574843.jpeg?auto=compress&cs=tinysrgb&w=1200",
                  widget.catImgUrl,
                height: 150,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black38,
                ),

                Positioned(
                  left: MediaQuery.of(context).size.width / 2.5,
                  top: 40,
                  child: Column(
                    children: [
                      Text("Category", style: TextStyle(fontSize: 15,color: Colors.white, fontWeight: FontWeight.w600)),
                      Text(widget.catName, style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.w600),)
                    ],
                  ),
                )

              ],
            ),

            SizedBox(height: 20,),

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
                  itemCount: categoryResults.length,
                  itemBuilder: (context, index){
                    return GridTile(
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>
                              FullScreen(imgUrl: categoryResults[index].imgSrc)));
                        },
                        child: Hero(
                          tag: categoryResults[index].imgSrc,
                          child: Container(
                            height: 800,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.amberAccent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                // "https://images.pexels.com/photos/2291073/pexels-photo-2291073.jpeg?auto=compress&cs=tinysrgb&w=1200",
                                categoryResults[index].imgSrc,
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
            )

          ],
        ),
      ),
    );
  }
}

