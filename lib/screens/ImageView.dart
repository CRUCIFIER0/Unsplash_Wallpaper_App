import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class ImageView extends StatefulWidget {
  final dynamic pic;

  const ImageView({Key key, this.pic}) : super(key: key);
  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: Image.network(
              widget.pic,
              height:  MediaQuery.of(context).size.height,
              width:  MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),

          ),

        ],

      ),
    );

  }
}
