import 'package:flutter/material.dart';
import 'package:wallpaper_app/views/screens/search_screen.dart';

class SearchBar extends StatelessWidget {
  SearchBar({Key? key}) : super(key: key);

  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
        color: Color.fromARGB(66, 192, 192, 192),
        border: Border.all(color: Color.fromARGB(33, 12, 5, 5)),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search Wallpaper",
                focusedBorder : InputBorder.none,
                focusedErrorBorder : InputBorder.none,
                errorBorder : InputBorder.none,
                disabledBorder : InputBorder.none,
                enabledBorder : InputBorder.none,
                border : InputBorder.none,
              ),
              onSubmitted: (value){
                Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(query: _searchController.text)));
              },
            ),
          ),
          
          InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(query: _searchController.text)));
              },
              child: Icon(Icons.search)),
        ],
      ),
    );
  }
}

