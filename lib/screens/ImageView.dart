import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_app/screens/FullResImage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';

class ImageView extends StatefulWidget {
  final dynamic id,pic;

  const ImageView({Key key, this.pic, this.id}) : super(key: key);
  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {

  List info;
  var description,user_profilepic,username,usercollections,userphotos,downloads,views,height, width;
  var make, model, exposure, aperture, focal, iso;
  Future<String> getjsondataofimage() async {
    try{
      var response= await http.get("https://api.unsplash.com/photos/"+widget.id.toString()+"/?client_id=jbqkmGB5x9HUksVnPrv1GyywW3byYdOkAgLdxmgHTFM");
      setState(() {
        var converted = json.decode(response.body);
        print('${converted.runtimeType}: $converted');
        description = converted['alt_description'];
        height=converted['height'];
        width=converted['width'];
        user_profilepic =converted['user']['profile_image']['medium'];
        username = converted['user']['username'];
        userphotos=converted['user']['total_photos'];
        usercollections=converted['user']['total_collections'];
        downloads=converted['downloads'];
        views=converted['views'];
        make=converted['exif']['make'];
        model=converted['exif']['model'];
        exposure=converted['exif']['exposure_time'];
        aperture=converted['exif']['aperture'];
        focal=converted['exif']['focal_length'];
        iso=converted['exif']['iso'];


        info=converted["results"];
      });
    }
    catch(e){}
    return "success";
  }
  void initState() {
    super.initState();
    this.getjsondataofimage();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => FullResImage(
                  id: widget.id,
                )),);
              },
              child: Container(
                child: Image.network(
                  widget.pic,
                  height:  MediaQuery.of(context).size.height,
                  width:  MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),

              ),
            ),
            Container(
              width: double.infinity,

              margin: EdgeInsets.only(top:640),
              padding: EdgeInsets.only(left: 16,right: 16,top:20),
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
              child: Column(
                children: [

                  Row(
                    children: [
                      CircleAvatar(radius: 20,backgroundImage: NetworkImage(user_profilepic) ,),
                      SizedBox(width: 20,),
                      Container(child: Column(
                        children: [
                          new  Text(username, style: GoogleFonts.oxygen(textStyle: TextStyle(color: Colors.white, letterSpacing: .5,fontWeight: FontWeight.w700,fontSize: 18),),),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Icon(EvaIcons.imageOutline, size: 16,color: Colors.white, ),
                              Text(userphotos.toString(), style: TextStyle(color: Colors.white)),
                              SizedBox(width:25,),
                              Icon(EvaIcons.bookOutline, size: 16,color: Colors.white, ),
                              Text(usercollections.toString(), style: TextStyle(color: Colors.white)),
                            ],
                          ),

                        ],
                      )),
                      Spacer(),
                      LikeButton(
                        size: 24,
                        circleColor:
                        CircleColor(start:  Color(0xff303aff), end:  Color(0xff303aff)),
                        bubblesColor: BubblesColor(
                          dotPrimaryColor: Color(0xff33b5e5),
                          dotSecondaryColor:  Color(0xff303aff),
                        ),
                        likeBuilder: (bool isLiked) {
                          return Icon(
                            EvaIcons.heart,
                            color: isLiked ?  Color(0xff303aff) : Colors.grey,
                            size: 24,
                          );
                        },
                      ),
                      SizedBox(width: 40,)
                    ],
                  ),
                  SizedBox(height: 20,),
                  new Text(description,style: TextStyle(color: Colors.white),),
                  SizedBox(height: 15,),
                  Divider(color: Colors.white,thickness: 0.20,),
                  Align(alignment:Alignment.centerLeft,child: new  Text("More info:", style: GoogleFonts.oxygen(textStyle: TextStyle(color: Colors.white, letterSpacing: .5,fontWeight: FontWeight.w700,fontSize: 16),),)),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width/2-16,
                        child: Row(
                          children: [
                            Icon(EvaIcons.cameraOutline, size: 20,color: Colors.white, ),
                            SizedBox(width: 8,),
                            Container(
                              child: Column(
                                children: [
                                  Align(alignment: Alignment.centerLeft,child: new  Text("Camera", style: GoogleFonts.oxygen(textStyle: TextStyle(color: Colors.white, letterSpacing: .5,fontWeight: FontWeight.w600,fontSize: 15),),)),
                                  SizedBox(height: 5,),
                                  new Text(make,style: TextStyle(color: Colors.white, fontSize: 12),),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      Icon(EvaIcons.camera, size: 20,color: Colors.white, ),
                      SizedBox(width: 8,),
                      Container(
                        child: Column(
                          children: [
                            Align(alignment: Alignment.centerLeft,child: new  Text("Model", style: GoogleFonts.oxygen(textStyle: TextStyle(color: Colors.white, letterSpacing: .5,fontWeight: FontWeight.w600,fontSize: 15),),)),
                            SizedBox(height: 5,),
                            new Text(model,style: TextStyle(color: Colors.white, fontSize: 12),),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width/2-16,
                        child: Row(
                          children: [
                            Icon(Icons.lens_outlined, size: 20,color: Colors.white, ),
                            SizedBox(width: 8,),
                            Container(
                              child: Column(
                                children: [
                                  Align(alignment: Alignment.centerLeft,child: new  Text("Focal Length", style: GoogleFonts.oxygen(textStyle: TextStyle(color: Colors.white, letterSpacing: .5,fontWeight: FontWeight.w600,fontSize: 15),),)),
                                  SizedBox(height: 5,),
                                  new Text(focal,style: TextStyle(color: Colors.white, fontSize: 12),),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      Icon(Icons.shutter_speed, size: 20,color: Colors.white, ),
                      SizedBox(width: 8,),
                      Container(
                        child: Column(
                          children: [
                            Align(alignment: Alignment.centerLeft,child: new  Text("Shutter Speed", style: GoogleFonts.oxygen(textStyle: TextStyle(color: Colors.white, letterSpacing: .5,fontWeight: FontWeight.w600,fontSize: 15),),)),
                            SizedBox(height: 5,),
                            new Text(aperture,style: TextStyle(color: Colors.white, fontSize: 12),),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width/2-16,
                        child: Row(
                          children: [
                            Icon(Icons.iso_outlined, size: 20,color: Colors.white, ),
                            SizedBox(width: 8,),
                            Container(
                              child: Column(
                                children: [
                                  Align(alignment: Alignment.centerLeft,child: new  Text("ISO", style: GoogleFonts.oxygen(textStyle: TextStyle(color: Colors.white, letterSpacing: .5,fontWeight: FontWeight.w600,fontSize: 15),),)),
                                  SizedBox(height: 5,),
                                  new Text(focal,style: TextStyle(color: Colors.white, fontSize: 12),),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      Icon(Icons.format_size, size: 20,color: Colors.white, ),
                      SizedBox(width: 8,),
                      Container(
                        child: Column(
                          children: [
                            Align(alignment: Alignment.centerLeft,child: new  Text("Dimensions", style: GoogleFonts.oxygen(textStyle: TextStyle(color: Colors.white, letterSpacing: .5,fontWeight: FontWeight.w600,fontSize: 15),),)),
                            SizedBox(height: 5,),
                            new Text(height.toString()+"*"+width.toString(),style: TextStyle(color: Colors.white, fontSize: 12),),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20,)



                ],
              ),

            )

          ],

        ),
      ),
    );

  }
}
