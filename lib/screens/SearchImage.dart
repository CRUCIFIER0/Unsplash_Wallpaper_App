import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/ImageView.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchImage extends StatefulWidget {
  @override
  _SearchImageState createState() => _SearchImageState();
}

class _SearchImageState extends State<SearchImage> {


  String _search= "trending";
  List data;
  Future<String> getjsondata() async {
    try{
      var response= await http.get("https://api.unsplash.com/search/photos?per_page=50&client_id=jbqkmGB5x9HUksVnPrv1GyywW3byYdOkAgLdxmgHTFM&query=$_search&orientation=portrait");
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

  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff040204),
      body: Container(
        padding: EdgeInsets.only(left: 16,right: 16),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 40, right: 8, left: 8),
              //color: Colors.grey,
              height: 48,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xff575757),
                  border: Border.all(
                    color: Color(0xff575757),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20),
                  ),
              ),
              child: Row(
                children: [
                  IconButton(icon: Icon(EvaIcons.search,color: Colors.white,), onPressed: null),
                  SizedBox(width: 7,),
                  Expanded(
                    child: TextField(
                      controller: myController,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                      decoration: InputDecoration(
                          hintText: 'Search for an image',
                          hintStyle: TextStyle(fontSize: 15.0, color: Colors.white),
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        suffixIcon: IconButton(
                          onPressed: () {
                            myController.clear();
                          },
                          icon: Icon(
                            Icons.clear,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onSubmitted: (value){
                          setState(() {
                            _search= value;
                            getjsondata();
                          });
                      },
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 8,right: 8),
              child: Divider(color: Colors.white,thickness: 0.15,),
            ),
            SizedBox(height: 0,),

            _search ==null || _search.isEmpty?
                Expanded(child: Text("search")):
              Container(
              child: Expanded(
                  child: GridView.builder(
                    itemCount:data.length,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0,
                      childAspectRatio: 0.7
                    ),
                    itemBuilder: (BuildContext context, int index){
                      return InkWell(
                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ImageView(id: data[index]["id"],pic: data[index]["urls"]["regular"])),);},
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: Image.network(
                              data[index]['urls']['small'],
                              height: 3320.0,
                              width: 200.0,
                              fit: BoxFit.cover,
                            ),

                          ),
                        ),
                      );
                    },
                  ),
                ),
            ),

          ],
        ),
      ),
    );
  }
}
