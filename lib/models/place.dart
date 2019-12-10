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

  Place({
    @required this.name,
    @required this.address,
    this.number,
    this.review,
    this.location,
    this.image,
  });
}