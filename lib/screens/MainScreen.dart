import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_app/screens/SearchImage.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;




class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}




class _MainScreenState extends State<MainScreen> {
  String _search= "abstract";
  List data;
  Future<String> getjsondata() async {
    try{
      var response= await http.get("https://api.unsplash.com/search/photos?per_page=30&client_id=jbqkmGB5x9HUksVnPrv1GyywW3byYdOkAgLdxmgHTFM&query=${_search}&orientation=portrait");
      setState(() {
        var converted = json.decode(response.body);
        data=converted["results"];
      });
    }
    catch(e){}
    return "success";
  }

  @override
  void initState() {
    super.initState();
    this.getjsondata();
  }
  final List<int> numbers = [1, 2, 3, 5, 8, 13, 21, 34, 55];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff0410ff),
        body: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 70,left: 24,right: 24),
              child: new Row(
                children: <Widget>[
                  CircleAvatar(radius: 20,backgroundImage: NetworkImage("https://www.woolha.com/media/2020/03/flutter-circleavatar-minradius-maxradius.jpg") ,),
                  SizedBox(width: 15,),
                  Text('Anonymous', style: GoogleFonts.kanit(textStyle: TextStyle(color: Colors.white, letterSpacing: .5,fontWeight: FontWeight.w600,fontSize: 24),),),
                  IconButton(icon: Icon(EvaIcons.moreVerticalOutline,color: Colors.white,),),
                  Spacer(),
                  IconButton(onPressed:
                  (){Navigator.push(context, MaterialPageRoute(builder: (context) => SearchImage()),);},
                    icon: Icon(EvaIcons.search,color: Colors.white,),)
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 45),
              child: Container(
                padding: EdgeInsets.only(left: 24),
                decoration: BoxDecoration(
                    color: Color(0xff040204),
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ) // use instead of BorderRadius.all(Radius.circular(20))
                ),
                height: MediaQuery.of(context).size.height-163,
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(height: 25,),
                    new SizedBox(width: double.infinity, child: new  Text('Hello, \nBrooklyn', style: GoogleFonts.kanit(textStyle: TextStyle(color: Colors.white, letterSpacing: .5,fontWeight: FontWeight.w800,fontSize: 35),),)),
                    SizedBox(height: 30,),
                    Container(

                      height: 300,
                      width: double.infinity,
                      child: SizedBox(
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 30,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(18),
                                    child: Image.network(
                                      data[index]['urls']['small'],
                                      height: 3320.0,
                                      width: 200.0,
                                      fit: BoxFit.cover,
                                    ),

                                  ),
                                  SizedBox(width: 15,)
                                ],
                              );
                            }
                          ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    FlatButton(
                      padding: EdgeInsets.only(left: 40,right: 40,top: 10,bottom: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: BorderSide(color: Colors.white54)
                        ),
                        child: new Text("Load all",style: GoogleFonts.sourceSansPro(textStyle: TextStyle(color: Colors.white, letterSpacing: .5,fontWeight: FontWeight.w300,fontSize: 16),)),onPressed: null
                    )
                  ],
                ),
              ),
            ),
          ],
        )
    );
  }
}
