import 'dart:convert';

import './addPlaceScreen.dart';
import '../models/place.dart';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

Future<Place> fetchPost() async {
  String url = 'http://kissmethruthephone.com/locations.php';
  Map<String, String> headers = {"Content-type": "application/json"};
  String jsonString = '{"Verified":1}';

  Response response = await post(url, headers: headers, body: jsonString);

  print("hello");

  // If the call to the server was successful, parse the JSON.
  return Place.fromJson(json.decode(response.body));
}

Future<Place> fetchCategory(String category) async {
  String url = 'http://kissmethruthephone.com/sort.php';
  Map<String, String> headers = {"Content-type": "application/json"};
  String jsonString = '{"Verified":1,"Category":'+category + '}';

  Response response = await post(url, headers: headers, body: jsonString);

  print("hello");

  // If the call to the server was successful, parse the JSON.
  return Place.fromJson(json.decode(response.body));
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

  @override
  void initState() {
    super.initState();
    post = fetchPost();
    print("finished");
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
              lv = ListView.builder(
                itemCount: names.length,
                itemBuilder: (context, index) {
                  return FlatButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/place-detail');
                    },
                    child: new Text('${names[index]}'),
                  );
                 
                },
              );
              // return the list
              return lv;
            } 
            else if (snapshot.hasError) {
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
        title: Text('Hot Spotz'),
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
            title: Text('Spotz'),
            backgroundColor: Colors.amberAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_dining),
            title: Text('Food'),
            backgroundColor: Colors.amberAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: Text('Entertainment'),
            backgroundColor: Colors.amberAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shop),
            title: Text('Shopping'),
            backgroundColor: Colors.amberAccent,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
