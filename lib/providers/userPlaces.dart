import 'package:flutter/foundation.dart';
import '../models/place.dart';
import 'dart:io';
import '../helpers/locationHelper.dart';

class UserPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }
  Place findById(String id){
    return _items.firstWhere((place) => place.id == id);
  }
  Future<void> addPlace(
     String pickedTitle,
     File pickedImage,
     String pickedReview,
     PlaceLocation pickedLocation,
   ) async{
     final address = await LocationHelper.getPlaceAddress(
       pickedLocation.latitude, pickedLocation.longitude);
     final updatedLocation = PlaceLocation(
         latitude: pickedLocation.latitude,
         longitude: pickedLocation.longitude,
         address: address,
     );
     final newPlace = Place(
       id: DateTime.now().toString(),
       image: pickedImage,
       title: pickedTitle,
       review: pickedReview,
       location: updatedLocation,
     );
     _items.add(newPlace);
     notifyListeners();
// NEED TO INSERT DATA INTO A PLACES TABLE IN DB

// NEED A FETCH AND SET PLACES FUNCTION
// VIDEOS 255 & 256 IN UDEMY. IMPLEMENT IN MYSQL



  }
}

