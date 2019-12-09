import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/userPlaces.dart';
import './addPlaceScreen.dart';
import './placesDetailScreen.dart';

class PlacesListScreen extends StatelessWidget {
  @override
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
          child: const Text('No Hot Spotz just yet!'),
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
    );
  }
}