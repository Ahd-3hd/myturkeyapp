import 'package:flutter/material.dart';
import 'package:myturkeyproperty/services/properties.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List data;
  List extractedData;
  bool isLoading = true;

  void getProperties() async {
    Properties instance = Properties();
    await instance.getData();
    setState(() {
      data = instance.myData;
      extractedData = data;
      isLoading = false;
    });
  }

  void searchPropertiesLocation(query) async {
    if (query == 'all') {
      setState(() {
        extractedData = data;
      });
    } else {
      setState(() {
        extractedData = data
            .where((element) => element['acf']['location'] == query)
            .toList();
      });
    }
  }

  void searchPropertiesType(query) async {
    if (query == 'all') {
      extractedData = data;
    } else {
      setState(() {
        extractedData =
            data.where((element) => element['acf']['type'] == query).toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getProperties();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Turkey Property'),
      ),
      body: isLoading
          ? Text('Loading')
          : Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Location',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              new DropdownButton<String>(
                                items: <String>[
                                  'all',
                                  'Antalia',
                                  'Bursa',
                                  'Fethiye',
                                  'Istanbul'
                                ].map((String value) {
                                  return new DropdownMenuItem<String>(
                                    value: value,
                                    child: new Text(value),
                                  );
                                }).toList(),
                                onChanged: (query) {
                                  searchPropertiesLocation(query);
                                },
                              ),
                            ]),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Type',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              new DropdownButton<String>(
                                items: <String>[
                                  'all',
                                  'Apartment',
                                  'Penthouse',
                                  'Villa',
                                ].map((String value) {
                                  return new DropdownMenuItem<String>(
                                    value: value,
                                    child: new Text(value),
                                  );
                                }).toList(),
                                onChanged: (query) {
                                  searchPropertiesType(query);
                                },
                              ),
                            ]),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                      children: extractedData
                          .map(
                            (single) => Item(
                              single['title']['rendered'],
                              single['acf']['price'],
                              single['acf']['image_one'],
                              single['acf']['base_currency'],
                              single['acf']['bedrooms'],
                              single['acf']['bathrooms'],
                              single['acf']['size'],
                              single['acf']['type'],
                            ),
                          )
                          .toList()),
                ),
              ],
            ),
    );
  }
}

class Item extends StatelessWidget {
  final String title;
  final String price;
  final String imageurl;
  final String baseCurrency;
  final String bedrooms;
  final String bathrooms;
  final String size;
  final String type;
  const Item(this.title, this.price, this.imageurl, this.baseCurrency,
      this.bedrooms, this.bathrooms, this.size, this.type);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.network(
              this.imageurl,
            ),
            SizedBox(height: 10),
            Text(
              this.title,
              style: TextStyle(
                fontSize: 20,
                color: Colors.blueGrey[900],
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '${this.baseCurrency} ${this.price}',
              style: TextStyle(
                fontSize: 15,
                color: Colors.blueGrey[900],
              ),
            ),
            SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
                      ),
                    ),
                    Text(this.bathrooms),
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
                      ),
                    ),
                    Text('${this.size} ft sq'),
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
                      ),
                    ),
                    Text(this.type),
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
                      ),
                    ),
                    Text(this.bedrooms),
                  ],
                ),
              ),
            ]),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
