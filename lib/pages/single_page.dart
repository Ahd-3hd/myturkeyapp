import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myturkeyproperty/pages/request_info.dart';

class SinglePage extends StatelessWidget {
  final Map propertyData;
  final List<String> imgList;
  SinglePage({Key key, @required this.propertyData, @required this.imgList})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.propertyData['title']),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => (Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RequestInfo(
              propertyName: this.propertyData['title'],
            ),
          ),
        )),
        child: Icon(Icons.question_answer),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height / 2,
                  autoPlay: true,
                ),
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
            ]),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Price: ${this.propertyData['currency']} ',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.blue[900],
                        ),
                      ),
                      Text(
                        this.propertyData['price'],
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.blue[900],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Location: ${this.propertyData['location']} ',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.blue[900],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(
                              FontAwesomeIcons.hotTub,
                              size: 17,
                              color: Colors.blueGrey[600],
                            ),
                          ),
                          Text(
                            this.propertyData['bathrooms'],
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.blueGrey[700],
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(
                              FontAwesomeIcons.ruler,
                              size: 17,
                              color: Colors.blueGrey[600],
                            ),
                          ),
                          Text(
                            '${this.propertyData["size"].toString()} ft sq',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.blueGrey[700],
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(
                              FontAwesomeIcons.home,
                              size: 17,
                              color: Colors.blueGrey[600],
                            ),
                          ),
                          Text(
                            this.propertyData['type'],
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.blueGrey[700],
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(
                              FontAwesomeIcons.bed,
                              size: 17,
                              color: Colors.blueGrey[600],
                            ),
                          ),
                          Text(
                            this.propertyData['bedrooms'],
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.blueGrey[700],
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
