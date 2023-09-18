import 'package:flutter/material.dart';
import 'package:wallpaper_app/controller/api_operations.dart';
import 'package:wallpaper_app/model/photos_model.dart';
import 'package:wallpaper_app/views/widgets/custom_appbar.dart';
import 'package:wallpaper_app/views/widgets/search_bar.dart';

import 'full_screen.dart';

class SearchScreen extends StatefulWidget {
  String query;
  SearchScreen({Key? key, required this.query}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late List<PhotosModel> searchResults;
  bool isLoading = true;

  getSearchResults() async{
    // when variable are in constructor and it is data member of that screen then to get that we have to write widget. and variable name
    searchResults = await ApiOperations.searchWallpapers(widget.query);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSearchResults();
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
          :SingleChildScrollView(
        child: Column(
          children: [

            Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: SearchBar()
            ),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              height: MediaQuery.of(context).size.height,
              child: GridView.builder(
                  physics: BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 400,  // for height
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 14
                  ),
                  itemCount: searchResults.length,
                  itemBuilder: (context, index){
                    return GridTile(
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>
                              FullScreen(imgUrl: searchResults[index].imgSrc)));
                        },
                        child: Hero(
                          tag: searchResults[index].imgSrc,
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
                                searchResults[index].imgSrc,
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
            )

          ],
        ),
      ),
    );
  }
}

