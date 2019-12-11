import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/placeDetails.dart';
import './providers/userPlaces.dart';
import './screens/placesListScreen.dart';
import './screens/addPlaceScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: UserPlaces(),
      child: MaterialApp(
          title: 'Hot Spotz',
          theme: ThemeData(
            primarySwatch: Colors.yellow,
            accentColor: Colors.amberAccent,
          ),
          home: PlacesListScreen(),
          routes: {
            AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
            PlaceDetails.routeName: (ctx) => PlaceDetails(),
          }),
    );
  }
}
