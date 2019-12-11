import 'package:flutter/material.dart';
import '../widgets/image_input.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import '../providers/userPlaces.dart';
import '../widgets/locationInput.dart';
import '../models/place.dart';

class AddPlaceScreen extends StatefulWidget {

  static const routeName = '/add-place';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {

  final _nameController = TextEditingController();
  final _reviewController = TextEditingController();
  final _addressController = TextEditingController();
  final _numberController = TextEditingController();


  File _pickedImage;
  PlaceLocation _pickedLocation;

  void _selectPlace(double lat, double lng){
    _pickedLocation = PlaceLocation(latitude: lat, longitude: lng);
  }
  void _selectImage(File pickedImage){
    _pickedImage = pickedImage;
  }

  void _savePlace() {
    // Doesn't let user save place if title is empty
    if(_nameController.text.isEmpty){
      return;
    }

    if (_addressController.text.isEmpty){
      _addressController.text = "";
    }

    if (_numberController.text.isEmpty){
      _numberController.text = "";
    }

    if (_reviewController.text.isEmpty){
      _reviewController.text = "";
    }

    Provider.of<UserPlaces>(context, listen: false)
        .addPlace(_nameController.text, _addressController.text, _numberController.text, _reviewController.text, _pickedImage, _pickedLocation);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a Hot Spot!"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children:<Widget>[
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: 'Name of Spot (Required)'),
                  controller: _nameController,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Address'),
                  controller: _addressController,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Phone Number'),
                  controller: _numberController,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Review (1-5)'),
                  controller: _reviewController,
                ),
                SizedBox(height: 10,),
                ImageInput(_selectImage),
                LocationInput(_selectPlace),
              ],
            ),
           ),
          ),
        ),
        RaisedButton.icon(
          icon: Icon(Icons.add),
          label: Text('Add Place'),
          onPressed: _savePlace,
          elevation: 0,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          color: Theme.of(context).accentColor,
           // accent color is defined in main
          )
      ],),
    );
  }
}