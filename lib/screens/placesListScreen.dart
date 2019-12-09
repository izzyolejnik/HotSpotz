import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/userPlaces.dart';
import './addPlaceScreen.dart';
import './placesDetailScreen.dart';
import 'dart:io';

class PlacesListScreen extends StatefulWidget {
  @override
  _PlacesListScreenState createState() => _PlacesListScreenState();
}
class _PlacesListScreenState extends State<PlacesListScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(
      fontSize: 30, fontWeight: FontWeight.bold);
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
      body: Consumer<UserPlaces>(
        child: Center(
          //child: const Text('No Hot Spotz just yet!'),
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        builder: (ctx, userPlaces, ch) => userPlaces.items.length <= 0
            ? ch
            : ListView.builder(
                itemCount: userPlaces.items.length,
                itemBuilder: (ctx, i) => ListTile(
                  leading: CircleAvatar(
                    backgroundImage: FileImage(
                        userPlaces.items[i].image
                    ),
                  ),
                  title: Text(userPlaces.items[i].title),
                  subtitle: Text(userPlaces.items[i].location.address),
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      PlacesDetailScreen.routeName, arguments: userPlaces.items[i].id,
                    );
                  }
                ),
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