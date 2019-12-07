import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/userPlaces.dart';
import './addPlaceScreen.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Hot Spotz'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_box), 
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName); 
            },
          ),
        ],
      ),
      body: Consumer<UserPlaces>(
        child: Center(
          child: const Text('No Hot Spotz just yet! Add now!'),
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
                  onTap: () {
                    // Go to detail page ...
                  }
                ),
              ),
      ),
    );
  }
}