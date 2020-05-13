import 'package:flutter/material.dart';
import 'package:myturkeyproperty/services/properties.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myturkeyproperty/pages/single_page.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List data;
  List extractedData;
  bool isLoading = true;
  bool isContainingResult = false;
  void getProperties() async {
    Properties instance = Properties();
    await instance.getData();
    setState(() {
      data = instance.myData;
      extractedData = data;
      isLoading = false;
      print(data[0]);
      extractedData.length > 0
          ? isContainingResult = true
          : isContainingResult = false;
    });
  }

  void searchProperties(query) async {
    if (query['query']['search_type'] == 'price') {
      if (query['query']['keyword'] == 'all') {
        setState(() {
          extractedData = data;
        });
      } else {
        setState(() {
          extractedData = data
              .where((element) =>
                  int.parse(element['acf'][query['query']['search_type']]) >=
                  int.parse(query['query']['keyword']))
              .toList();
        });
      }
    } else if (query['query']['keyword'] == 'all') {
      setState(() {
        extractedData = data;
      });
    } else {
      setState(() {
        extractedData = data
            .where((element) =>
                element['acf'][query['query']['search_type']] ==
                query['query']['keyword'])
            .toList();
      });
    }
    if (extractedData.length > 0) {
      setState(() {
        isContainingResult = true;
      });
    } else {
      setState(() {
        isContainingResult = false;
      });
    }
  }

  void submitSearch() async {}

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
                                  fontFamily: 'Montserrat',
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
                                  searchProperties({
                                    'query': {
                                      'keyword': query,
                                      'search_type': 'location'
                                    }
                                  });
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
                                  fontFamily: 'Montserrat',
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
                                  searchProperties({
                                    'query': {
                                      'keyword': query,
                                      'search_type': 'type'
                                    }
                                  });
                                },
                              ),
                            ]),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Max Price',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                              new DropdownButton<String>(
                                items: <String>[
                                  '10000',
                                  '20000',
                                  '30000',
                                  '40000',
                                ].map((String value) {
                                  return new DropdownMenuItem<String>(
                                    value: value,
                                    child: new Text(value),
                                  );
                                }).toList(),
                                onChanged: (query) {
                                  searchProperties({
                                    'query': {
                                      'keyword': query,
                                      'search_type': 'price'
                                    }
                                  });
                                },
                              ),
                            ]),
                      ],
                    ),
                  ),
                ),
                isContainingResult
                    ? Expanded(
                        child: ListView(
                            children: extractedData
                                .map(
                                  (single) => InkWell(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SinglePage(
                                          propertyData: {
                                            'title': single['title']
                                                ['rendered'],
                                            'id': single['id'],
                                          },
                                          imgList: [
                                            single['acf']['image_one'],
                                            single['acf']['image_two'],
                                            single['acf']['image_three'],
                                          ],
                                        ),
                                      ),
                                    ),
                                    child: Item(
                                        single['title']['rendered'],
                                        single['acf']['price'],
                                        single['acf']['image_one'],
                                        single['acf']['base_currency'],
                                        single['acf']['bedrooms'],
                                        single['acf']['bathrooms'],
                                        single['acf']['size'],
                                        single['acf']['type'],
                                        single['acf']['location'],
                                        single['id'], [
                                      single['acf']['image_one'],
                                      single['acf']['image_two'],
                                      single['acf']['image_three'],
                                    ]),
                                  ),
                                )
                                .toList()),
                      )
                    : Text('No Results'),
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
  final String location;
  final int itemID;
  final List images;
  const Item(
      this.title,
      this.price,
      this.imageurl,
      this.baseCurrency,
      this.bedrooms,
      this.bathrooms,
      this.size,
      this.type,
      this.location,
      this.itemID,
      this.images);
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
                color: Colors.blueGrey[600],
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
            SizedBox(height: 10),
            Text(
              this.location,
              style: TextStyle(
                fontSize: 20,
                color: Colors.blueGrey[600],
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
            SizedBox(height: 10),
            Text(
              '${this.baseCurrency} ${this.price}',
              style: TextStyle(
                fontSize: 15,
                color: Colors.blueGrey[700],
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
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
                        color: Colors.blueGrey[600],
                      ),
                    ),
                    Text(
                      this.bathrooms,
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
                      '${this.size} ft sq',
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
                      this.type,
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
                      this.bedrooms,
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
            ]),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
