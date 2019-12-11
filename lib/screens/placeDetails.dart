import 'placesListScreen.dart';
import '../models/place.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<Place> fetchPlace(Map<String, dynamic> data) async {
  String url = 'http://kissmethruthephone.com/searchLocation.php';
  Map<String, String> headers = {"Content-type": "application/json"};

  Response response =
      await post(url, headers: headers, body: json.encode(data));

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

    final Map<String, dynamic> locationToShow = {
      "Verified": 1,
      "search": "${args.name}",
    };

    Future<Place> post = fetchPlace(locationToShow);
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
          address = snapshot.data.address;
          phone = snapshot.data.phone;
          review = snapshot.data.review;
          distance = snapshot.data.distance;

          return Scaffold(
              appBar: AppBar(title: Text('${name[0]}')),
              body: Column(children: <Widget>[
                ListTile(
                  leading: Icon(
                    Icons.directions,
                    color: Colors.redAccent,
                    size: 30.0,
                  ),
                  title: Text('${address[0]}'),
                ),
                Spacer(),
                ListTile(
                  leading: Icon(
                    Icons.phone,
                    color: Colors.green,
                    size: 30.0,
                  ),
                  title: Text('${phone[0]}'),
                ),
                Spacer(),
                ListTile(
                  leading: Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 30.0,
                  ),
                  title: Text('${review[0]} / 5 stars'),
                ),
                Spacer(),
                ListTile(
                  leading: Icon(
                    Icons.directions_bike,
                    color: Colors.black,
                    size: 30.0,
                  ),
                  title: Text('${distance[0]} miles from UCF'),
                ),
                Spacer(flex: 7),
              ]));
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
