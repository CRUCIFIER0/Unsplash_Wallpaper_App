import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff303aff),
      body: Column(
        children: [

          Container(
            margin: EdgeInsets.only(top: 90),
            height: MediaQuery.of(context).size.height-90,
            //color: Colors.black,
            decoration: BoxDecoration(
                color: Color(0xff040204),
                border: Border.all(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                ) // use instead of BorderRadius.all(Radius.circular(20))
            ),

          ),
        ],
      )


    );
  }
}
