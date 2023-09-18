import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:open_file/open_file.dart';

class FullScreen extends StatefulWidget {
  String imgUrl;
   FullScreen({Key? key, required this.imgUrl}) : super(key: key);

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {

  Future<void> downloadWallpaper() async{
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Downloading Start...")));
    try{
      log("Image Url: ${widget.imgUrl}");
      await GallerySaver.saveImage(widget.imgUrl, albumName: 'Wallpapers').then((value){
        if(value != null && value){
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Downloaded Successfully")));
        }
      });

    }on PlatformException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error Occured $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(widget.imgUrl),
                fit: BoxFit.cover
            )
        ),
      ),

      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text("Cancel")),

          ElevatedButton(
            onPressed: () {
              downloadWallpaper();
            },
            child: Text("Download Wallpaper"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}


