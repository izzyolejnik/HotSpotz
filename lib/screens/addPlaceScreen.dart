import 'package:flutter/material.dart';
import '../widgets/image_input.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import '../providers/userPlaces.dart';
import '../widgets/locationInput.dart';

class AddPlaceScreen extends StatefulWidget {

  static const routeName = '/ add-place';

  @override 
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {

  final _titleController = TextEditingController();
  final _reviewController = TextEditingController();

  File _pickedImage;

  void _selectImage(File pickedImage){
    _pickedImage = pickedImage;
  }

  void _savePlace() {
    // Doesn't let user save place if title is empty or if no picture
    // Can change, add button or error message as well
    if(_titleController.text.isEmpty || _pickedImage == null){
      return;
    }

    Provider.of<UserPlaces>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage, _reviewController.text,);
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
                  decoration: InputDecoration(labelText: 'Title'),
                  controller: _titleController,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Review'),
                  controller: _reviewController,
                ),
                SizedBox(height: 10,),
                ImageInput(_selectImage),
                LocationInput(),
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