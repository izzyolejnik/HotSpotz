import 'package:flutter/material.dart';

import './addPlaceScreen.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HOT SPOTZ'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_box), 
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName); 
            },
          ),
        ],
      ),
      body: Center(child: CircularProgressIndicator())
    );
  }
}