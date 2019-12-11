import 'placesListScreen.dart';
import '../models/place.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<Place> fetchPlace(PassName args) async {
  String url = 'http://kissmethruthephone.com/searchLocation.php';
  Map<String, String> headers = {"Content-type": "application/json"};
  String jsonString = '{"Verified":1,"search":' + args.name + '}';
  print(args.name);

  Response response =
      await post(url, headers: headers, body: jsonString);

  // If the call to the server was successful, parse the JSON.
  return Place.fromJson(json.decode(response.body));
}

class PlaceDetails extends StatefulWidget {
  static const routeName = '/details-place';

  @override
  _PlaceDetails createState() => _PlaceDetails();
}

class _PlaceDetails extends State<PlaceDetails> {
  static const routeName = '/details-place';

  @override
  Widget build(BuildContext context) {
    final PassName args = ModalRoute.of(context).settings.arguments;

    print(args.name);

//    final Map<String, dynamic> locationToShow = {
//      "Verified": 1,
//      "Name": args.name,
//    };

    Future<Place> post = fetchPlace(args);
    print('outside of post');
    List<dynamic> name;
    List<dynamic> address;
    List<dynamic> phone;
    List<dynamic> review;
    List<dynamic> distance;

    return FutureBuilder<Place>(
      future: post,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          name = snapshot.data.name;
          print('h');
          address = snapshot.data.address;
          print('he');
          phone = snapshot.data.phone;
          print('hel');
          review = snapshot.data.review;
          print('hell');
          distance = snapshot.data.distance;
          print('hello');
          print('${address[0]}');
          print('${phone[0]}');
          print('${review[0]}');
          print('${distance[0]}');
          print('${name[0]}');

          return Scaffold(
              appBar: AppBar(title: Text('${name[0]}')),
              body: Column(children: <Widget>[
                ListTile(
                  leading: Icon(Icons.directions),
                  title: Text('${address[0]}'),
                ),
                ListTile(
                  leading: Icon(Icons.phone),
                  title: Text('${phone[0]}'),
                ),
                ListTile(
                  leading: Icon(Icons.star),
                  title: Text('${review[0]}'),
                ),
                ListTile(
                  leading: Icon(Icons.directions_bike),
                  title: Text('${distance[0]}'),
                ),
              ]
              )
          );

//          return ListView(children: <Widget>[
//            ListTile(
//              leading: Icon(Icons.directions),
//              title: Text('${address[0]}'),
//            ),
//            ListTile(
//              leading: Icon(Icons.phone),
//              title: Text('${phone[0]}'),
//            ),
//            ListTile(
//              leading: Icon(Icons.star),
//              title: Text('${review[0]}'),
//            ),
//            ListTile(
//              leading: Icon(Icons.directions_bike),
//              title: Text('${distance[0]}'),
//            ),
//          ]
//        );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
