import 'package:flutter/material.dart';

class FullResImage extends StatefulWidget {

  final dynamic id;

  const FullResImage({Key key, this.id}) : super(key: key);
  @override
  _FullResImageState createState() => _FullResImageState();
}

class _FullResImageState extends State<FullResImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(child: Image.network("https://source.unsplash.com/"+widget.id.toString())),
    );
  }
}
