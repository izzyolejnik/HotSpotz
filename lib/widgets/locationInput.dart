import 'package:flutter/material.dart';
import 'package:location/location.dart';
import '../helpers/locationHelper.dart';
import '../screens/map_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;

  LocationInput(this.onSelectPlace);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput>{
  String _previewImageUrl;

  void _showPreview(double lat, double lng){
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
      latitude: lat,
      longitude: lng,
    );
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });

  }
  Future<void> _getCurrentUserLocation() async {
   try {
     final locData = await Location().getLocation();
     _showPreview((locData.latitude), locData.longitude);
     widget.onSelectPlace(locData.latitude, locData.longitude);
   } catch(error) {
     return;
   }
  }
  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(
        MaterialPageRoute(
            fullscreenDialog: true,
            builder: (ctx) => MapScreen(
              isSelecting: true,
            ),
        ),
    );
    if(selectedLocation == null){
      return;
    }
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context){
    return Column(
      children: <Widget>[
        Container(
            height: 170,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
            ),
            child: _previewImageUrl == null
                ? Text(
                    'Look on the map',
                    textAlign:  TextAlign.center,
                  )
                : Image.network(
                    _previewImageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton.icon(
              icon: Icon(
                Icons.location_on,
              ),
             label: Text('See Current Location',),
             textColor: Colors.black,
             onPressed: _getCurrentUserLocation,
            ),
            FlatButton.icon(
              icon: Icon(
                Icons.map,
              ),
              label: Text('Click to view Map',),
              textColor: Colors.black,
              onPressed: _selectOnMap,
         ),
        ],
       ),
      ],
     );
  }
}
