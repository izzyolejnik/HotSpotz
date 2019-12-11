import 'dart:io';

import 'package:flutter/foundation.dart';

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;

  const PlaceLocation({
    @required this.latitude,
    @required this.longitude,
    this.address,
  });
}
class Place {
  final String name;
  final String address;
  final String phone;
  final String review;
  final String distance;
  final String category;
  final String id;

  final PlaceLocation location;
  final File image;
  //String jsonBody;

  Place({
    this.name,
    this.address,
    this.phone,
    this.review,
    this.distance, 
    this.category,
    this.id,

    this.location,
    this.image,
    //this.jsonBody,
  });


  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      name: json['Name'],
      address: json['Address'],
      phone: json['Phone'],
      review: json['Review'],
      distance: json['Distance'],
      category: json['Category'],
      id: json['Id'],

      //jsonBody: json,
    );
  }
}