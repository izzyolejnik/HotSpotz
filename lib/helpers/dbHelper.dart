import 'package:mysql1/mysql1.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'dart:convert';

class DBHelper{

  static Future<void> addLocation(Map<String, dynamic> data) async{
    var url = 'http://kissmethruthephone.com/addLocation.php';
    http.Response response = await http.post(Uri.encodeFull(url), body: json.encode(data));

    if (response.statusCode == 200){
      var message = json.decode(response.body);

      if(message[0]['results'] != 'Successful Add'){
        print('Adding the Location did not work.');
      }
    }
  }



}