import 'dart:io';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../models/place.dart';

class UserPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place findById(int Id) {
    return _items.firstWhere((place) => place.id == Id);
  }

  Future<void> addPlace(
    String pickedName,
    String pickedAddress,
    String pickedNumber,
    String pickedReview,
    File pickedImage,
    PlaceLocation pickedLocation,
  ) async {
//    final address = await LocationHelper.getPlaceAddress(
//        pickedLocation.latitude, pickedLocation.longitude);
//    final updatedLocation = PlaceLocation(
//      latitude: pickedLocation.latitude,
//      longitude: pickedLocation.longitude,
//      address: address,
//    );

    String sendAddress = pickedAddress;

//    if (pickedAddress != ""){
//      String sendAddress = pickedAddress;
//    }
//    else{
//      String sendAddress = updatedLocation.address;
//    }

    final Map<String, dynamic> locationData = {
      "Name": pickedName,
      "Address": sendAddress,
      "Phone": pickedNumber,
      "Review": pickedReview,
    };
    addLocation(locationData);
  }

  Future<void> addLocation(Map<String, dynamic> data) async {
    String url = 'http://kissmethruthephone.com/addLocation.php';
    Map<String, String> headers = {"Content-type": "application/json"};

    Response response =
        await post(url, headers: headers, body: json.encode(data));
  }
}
