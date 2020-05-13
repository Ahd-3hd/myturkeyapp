import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SinglePage extends StatelessWidget {
  final Map propertyData;
  final List<String> imgList;
  SinglePage({Key key, @required this.propertyData, @required this.imgList})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.propertyData['id'].toString()),
      ),
      body: CarouselSlider(
        options:
            CarouselOptions(height: MediaQuery.of(context).size.height / 2),
        items: imgList.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(5.0),
                decoration: BoxDecoration(color: Colors.amber),
                child: FittedBox(
                  child: Image.network(i),
                  fit: BoxFit.cover,
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
