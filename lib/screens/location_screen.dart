import 'package:flutter/material.dart';
import 'package:geolocator_app/services/weather.dart';
import 'package:geolocator_app/utilities/constants.dart';

import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationweather});
  final locationweather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  int temprature;
  String weathericon;
  String cityname;
  String msg;
  @override
  void initState() {
    super.initState();
    updateUi(widget.locationweather);
  }

  void updateUi(dynamic weatherdata) {
    setState(() {
      if (weatherdata == null) {
        temprature = 0;
        weathericon = 'Error';
        msg = 'Unable to get weather data';
        cityname = '';
        return;
      }
      double temp = weatherdata['main']['temp'];
      temprature = temp.toInt();
      var condition = weatherdata['weather'][0]['id'];
      cityname = weatherdata['name'];
      msg = weatherModel.getMessage(temprature);
      weathericon = weatherModel.getWeatherIcon(condition);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherdata = await weatherModel.getcurrentlocation();
                      updateUi(weatherdata);
                      print('update ui running');
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var typedname = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      print(typedname);
                      if (typedname != null) {
                        var weatherda =
                          await  weatherModel.getcityweather(typedname);
                        updateUi(weatherda);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temprature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weathericon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$msg in $cityname',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
