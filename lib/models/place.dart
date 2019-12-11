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
  final String number;
  final String review;
  final PlaceLocation location;
  final File image;
  String jsonBody;

  Place({
    this.name,
    this.address,
    this.number,
    this.review,
    this.location,
    this.image,
    this.jsonBody,
  });


  factory Place.fromJson(String json) {
    return Place(
      jsonBody: json,
    );
  }
}