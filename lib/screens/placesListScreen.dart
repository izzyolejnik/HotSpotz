import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/userPlaces.dart';
import './addPlaceScreen.dart';
import './placesDetailScreen.dart';
import 'package:http/http.dart';

Future<Post> fetchPost() async {
  String url = 'http://kissmethruthephone.com/sort.php';
  Map<String, String> headers = {"Content-type": "application/json"};
  String jsonString =
      '{"Verified":1, "Category":1}';

  Response response = await post(url, headers: headers, body: jsonString);

  // If the call to the server was successful, parse the JSON.
  return Post.fromJson(response.body);
}

class Post {
  final String jsonBody;

  Post({this.jsonBody});

  // factory Post.fromJson(Map<String, dynamic> json) {
  //   return Post(
  //     userId: json['userId'],
  //     id: json['id'],
  //     title: json['Name'],
  //     body: json['body'],
  //   );
  // }

  factory Post.fromJson(String json) {
    return Post(
      jsonBody: json,
    );
  }
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
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Hot Spotz',
      style: optionStyle,
    ),
    Text(
      'Food',
      style: optionStyle,
    ),
    Text(
      'Entertainment',
      style: optionStyle,
    ),
    Text(
      'Shopping',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<Post> post;

  @override
  void initState() {
    super.initState();
    post = fetchPost();
  }

  Widget build(BuildContext context) {
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

      // CONSUMER IS REPLACED WITH FUTURE BUILDER WIDGET IN UDEMY
      // FUTURE BUILDER WIDGET CALLS SET AND GET FUNCTION TO HAVE APP DISPLAY
      // LOCATIONS FROM THE DATABASE UPON OPENING --- WILL NEED TO IMPLEMENTED WITH MYSQL

      // body: Consumer<UserPlaces>(
      //   child: Center(
      //     //child: const Text('No Hot Spotz just yet!'),
      //     child: _widgetOptions.elementAt(_selectedIndex),
      //   ),
      //   builder: (ctx, userPlaces, ch) => userPlaces.items.length <= 0
      //       ? ch
      //       : ListView.builder(
      //           itemCount: userPlaces.items.length,
      //           itemBuilder: (ctx, i) => ListTile(
      //             leading: CircleAvatar(
      //               backgroundImage: FileImage(
      //                   userPlaces.items[i].image
      //               ),
      //             ),
      //             title: Text(userPlaces.items[i].name),
      //             subtitle: Text(userPlaces.items[i].location.address),
      //             onTap: () {
      //               Navigator.of(context).pushNamed(
      //                 PlacesDetailScreen.routeName, arguments: userPlaces.items[i].name,
      //               );
      //             }
      //           ),
      //         ),
      // ),

      body: Center(
        child: FutureBuilder<Post>(
          future: post,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data.jsonBody);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),

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
