import 'package:flutter/foundation.dart';
import '../models/place.dart';
import 'dart:io';

class UserPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String pickedTitle, File pickedImage, String pickedReview,) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: pickedTitle,
      review: pickedReview,
      location: null,
    );
    _items.add(newPlace);
    notifyListeners();

    // NEED TO INSERT DATA INTO A PLACES TABLE IN DB

    // NEED A FETCH AND SET PLACES FUNCTION
    // VIDEOS 255 & 256 IN UDEMY. IMPLEMENT IN MYSQL

  }
}

