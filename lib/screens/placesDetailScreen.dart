import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/userPlaces.dart';
import './map_screen.dart';

class PlacesDetailScreen extends StatelessWidget{
  static const routeName = '/place-detail';

  @override
  Widget build(BuildContext context){
    final name = ModalRoute.of(context).settings.arguments;
    final selectedPlace =
        Provider.of<UserPlaces>(context, listen: false).findById(name);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.name),
      ),
    body: Column(children: <Widget>[
      Container(
        height: 250,
        width: double.infinity,
        child: Image.file(
            selectedPlace.image,
            fit: BoxFit.cover,
            width: double.infinity,
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Text(
        selectedPlace.location.address,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
      ),
      SizedBox(
        height: 10,
      ),
      FlatButton(
        child: Text('View on Map'),
        textColor: Colors.black,
        onPressed: (){
          Navigator.of(context).push(
              MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (ctx) => MapScreen(
                    initialLocation: selectedPlace.location,
                    isSelecting: false, )
              ),
          );
        }
      )
    ])
    );
  }
}