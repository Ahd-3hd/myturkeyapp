import 'package:flutter/material.dart';
import 'package:myturkeyproperty/pages/home.dart';

void main() => runApp(MaterialApp(initialRoute: '/', routes: {
      '/': (context) => Home(),
    }));
