import 'dart:convert';

import './addPlaceScreen.dart';
import '../models/place.dart';

import 'package:http/http.dart';
import 'package:flutter/material.dart';

Future<Place> fetchPost() async {
  String url = 'http://kissmethruthephone.com/locations.php';
  Map<String, String> headers = {"Content-type": "application/json"};
  String jsonString = '{"Verified":1}';

  Response response = await post(url, headers: headers, body: jsonString);

  // If the call to the server was successful, parse the JSON.
  return Place.fromJson(json.decode(response.body));
}

Future<Place> fetchCategory(String category) async {
  String url = 'http://kissmethruthephone.com/sort.php';
  Map<String, String> headers = {"Content-type": "application/json"};
  String jsonString = '{"Verified":1,"Category":' + category + '}';

  Response response = await post(url, headers: headers, body: jsonString);

  // If the call to the server was successful, parse the JSON.
  return Place.fromJson(json.decode(response.body));
}

class PassName {
  final String name;

  PassName(this.name);
}

class PlacesListScreen extends StatefulWidget {
  // don't know what this does but without it
  // it loads forever
  // api key?
  PlacesListScreen({Key key}) : super(key: key);

  @override
  _PlacesListScreenState createState() => _PlacesListScreenState();
}

// where api needs to happen
class _PlacesListScreenState extends State<PlacesListScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<Place> post;
  List<dynamic> names;
  List<dynamic> addresses;
  List<dynamic> phones;
  List<dynamic> reviews;
  List<dynamic> distances;
  List<dynamic> categories;
  List<dynamic> ids;

  @override
  void initState() {
    super.initState();
    post = fetchPost();
  }

  FutureBuilder generateList() {
    ListView lv;

    // Make the page display the list.
    FutureBuilder fb = FutureBuilder<Place>(
      future: post,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // names = the list of names
          names = snapshot.data.name;
          // build the list
          lv = ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: names.length,
            itemBuilder: (context, index) {
              return FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/details-place',
                      arguments: PassName(names[index]));
                },
                child: new Text('${names[index]}',
                    style: TextStyle(fontSize: 16.0)),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          );
          // return the list
          return lv;
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner.
        return CircularProgressIndicator();
      },
    );
    return fb;
  }

  @override
  Widget build(BuildContext context) {
    Widget child = Container();

    switch (_selectedIndex) {
      case 0:
        post = fetchPost();
        child = generateList();
        break;

      case 1:
        post = fetchCategory("1");
        child = generateList();
        break;

      case 2:
        post = fetchCategory("2");
        child = generateList();
        break;

      case 3:
        post = fetchCategory("3");
        child = generateList();
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hot Spotz',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27.0),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_box),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),

      // changes the page
      body: SizedBox.expand(child: child),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('All Spotz'),
            backgroundColor: Colors.amberAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_dining),
            title: Text('Food'),
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: Text('Entertainment'),
            backgroundColor: Colors.deepPurpleAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shop),
            title: Text('Shopping'),
            backgroundColor: Colors.deepOrangeAccent,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
