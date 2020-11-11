import 'package:geolocator_app/services/location.dart';
import 'package:geolocator_app/services/networking.dart';

const apikey = '6d6c9eaadb882a78d8591525c31b2e4e';

class WeatherModel {


  Future<dynamic> getcityweather(String cityname) async{
   // var url = 'api.openweathermap.org/data/2.5/weather?q=$cityname&appid=$apikey&units=metric';
    NetworkHelper networkHelper = NetworkHelper('http://api.openweathermap.org/data/2.5/weather?q=london&appid=6d6c9eaadb882a78d8591525c31b2e4e');
    var weatherdata = await networkHelper.getdata();
    return weatherdata;
  }


  Future<dynamic> getcurrentlocation() async {
    Location location = Location();
    await location.getcurentlocation();
    var longitude = location.longitude;
    var lattitude = location.latitude;
    NetworkHelper networkHelper = NetworkHelper(
        'http://api.openweathermap.org/data/2.5/weather?lat=$lattitude&lon=$longitude&appid=$apikey&units=metric');
    var weatherdata = await networkHelper.getdata();
    return weatherdata;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
