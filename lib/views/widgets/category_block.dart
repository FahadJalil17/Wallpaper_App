import 'package:flutter/material.dart';
import 'package:wallpaper_app/views/screens/category_screen.dart';

class CategoryBlock extends StatelessWidget {
  String categoryName;
  String categoryImgSrc;
  CategoryBlock({Key? key, required this.categoryName, required this.categoryImgSrc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryScreen(catName: categoryName, catImgUrl: categoryImgSrc)));
      },

      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 7),

        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                categoryImgSrc,
                // "https://images.pexels.com/photos/2036544/pexels-photo-2036544.jpeg?auto=compress&cs=tinysrgb&w=1200",
                height: 50,
                width: 100,
              fit: BoxFit.cover,
              ),
            ),

            // This container will be on image
            Container(
              height: 50,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(12),
              ),
            ),

            Positioned(
                left: 30,
                top: 15,
                child: Text(categoryName, style: TextStyle(color: Colors.white),))

          ],
        ),
      ),
    );
  }
}

