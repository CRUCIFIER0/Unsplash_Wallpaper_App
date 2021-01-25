import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class RandomImage extends StatefulWidget {
  
  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<RandomImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              child: Image.network("https://source.unsplash.com/daily",height:  MediaQuery.of(context).size.height,
                width:  MediaQuery.of(context).size.width,
                fit: BoxFit.cover,)

            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top:650),
              padding: EdgeInsets.only(left: 16,right: 16,top:10),
              decoration: BoxDecoration(
                  color: Color(0xff040204),
                  border: Border.all(
                    color: Colors.transparent,
                  ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18),
                      topRight: Radius.circular(18)
                  ) // use instead of BorderRadius.all(Radius.circular(20))
              ),


            )

          ],

        ),
      ),
    );

  }
}
