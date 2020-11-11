import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator_app/screens/location_screen.dart';
import 'package:geolocator_app/services/weather.dart';


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  double lattitude;
  double longitude;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getlocation();
  }
  void getlocation() async{

     WeatherModel weatherModel = WeatherModel();
     var weatherdata = await weatherModel.getcurrentlocation();
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return LocationScreen(locationweather: weatherdata,);
    }));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
