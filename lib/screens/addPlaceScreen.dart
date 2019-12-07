import 'package:flutter/material.dart';

class AddPlaceScreen extends StatefulWidget {

  static const routeName = '/ add-place';

  @override 
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
<<<<<<< Updated upstream
=======
  final _titleController = TextEditingController();

  _selectImage<File>
  
>>>>>>> Stashed changes
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a New Place!"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children:<Widget>[
        Text('User Inputs..'),
        RaisedButton.icon(
          icon: Icon(Icons.add), 
          label: Text('Add Place'),
          onPressed: () {},
          elevation: 0,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          color: Theme.of(context).accentColor,
           // accent color is defined in main 
          )
      ],),
    );
  }
}