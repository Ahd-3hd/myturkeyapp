import 'package:flutter/material.dart';
import 'package:http/http.dart';

class RequestInfo extends StatefulWidget {
  final String propertyName;

  RequestInfo({Key key, @required this.propertyName}) : super(key: key);

  @override
  _RequestInfoState createState() => _RequestInfoState();
}

class _RequestInfoState extends State<RequestInfo> {
  String username;
  String userphone;
  String useremail;
  String usermsg;
  Future<void> handleComment() async {
    Response response = await post(
        'https://www.myturkeyproperty.com/wp-json/contact-form-7/v1/contact-forms/516/feedback',
        body: {
          'testrestname': username,
          'testrestphone': userphone,
          'testrestemail': useremail,
          'testrestmsg': usermsg,
          'propertytitle': this.widget.propertyName
        });
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.propertyName),
      ),
      body: Form(
          child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.person),
              hintText: 'Enter your first and last name',
              labelText: 'Name',
            ),
            onChanged: (_) {
              setState(() {
                username = _;
              });
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.phone),
              hintText: 'Enter a phone number',
              labelText: 'Phone',
            ),
            keyboardType: TextInputType.phone,
            onChanged: (_) {
              setState(() {
                userphone = _;
              });
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.email),
              hintText: 'Enter a email address',
              labelText: 'Email',
            ),
            keyboardType: TextInputType.emailAddress,
            onChanged: (_) {
              setState(() {
                useremail = _;
              });
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.message),
              hintText: 'Enter a message',
              labelText: 'Message',
            ),
            keyboardType: TextInputType.emailAddress,
            onChanged: (_) {
              setState(() {
                usermsg = _;
              });
            },
          ),
          Container(
              padding: const EdgeInsets.only(left: 40.0, top: 20.0),
              child: new RaisedButton(
                child: const Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  handleComment();
                  await new Future.delayed(const Duration(seconds: 2));
                  Navigator.pop(
                    context,
                  );
                },
                color: Colors.blue,
              )),
        ],
      )),
    );
  }
}
