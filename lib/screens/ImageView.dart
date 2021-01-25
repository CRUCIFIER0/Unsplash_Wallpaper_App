import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_app/screens/FullResImage.dart';

class ImageView extends StatefulWidget {
  final dynamic id,pic,likes,desc,profilepic,make,model;

  const ImageView({Key key, this.pic, this.desc, this.profilepic, this.likes, this.make, this.model, this.id}) : super(key: key);
  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {

  List info;
  Future<String> getjsondataofimage() async {
    try{
      var response= await http.get("https://api.unsplash.com/photos/"+widget.id.toString()+"/?client_id=jbqkmGB5x9HUksVnPrv1GyywW3byYdOkAgLdxmgHTFM");
      if(response.statusCode==200){
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
      }
      else{print("MOOOOO");}
      setState(() {
        var converted = json.decode(response.body);
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
              height: 400,
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
              child: Column(
                children: [

                  //new Text("dfdf",style: TextStyle(color: Colors.white),),
                  //new Text(info["alt_description"],style: TextStyle(color: Colors.white),),
                  // new Text(widget.make,style: TextStyle(color: Colors.white),),
                  // new Text(widget.model,style: TextStyle(color: Colors.white),)


                ],
              ),

            )

          ],

        ),
      ),
    );

  }
}
