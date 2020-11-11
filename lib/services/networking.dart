import 'package:geolocator_app/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper{
  final String url;

  NetworkHelper(this.url);
  Future getdata() async{
    http.Response response = await http.get(url);
    if(response.statusCode == 200){
      String data = response.body;
      return jsonDecode(data);

    }else
      print(response.statusCode);
  }
}