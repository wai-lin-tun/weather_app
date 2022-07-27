
import 'package:location/location.dart';
class Loading {
  double?latitude;
  double? longitude;
  Future initLocationService() async {
  var location = Location();

  if (!await location.serviceEnabled()) {
    if (!await location.requestService()) {
      return;
    }
  }

  var permission = await location.hasPermission();
  if (permission == PermissionStatus.denied) {
    permission = await location.requestPermission();
    if (permission != PermissionStatus.granted) {
      return;
    }
  }

  var loc = await location.getLocation();
   latitude = loc.latitude;
   longitude = loc.longitude;
  print("${loc.latitude} ${loc.longitude}");
}
}
class WeatherStatus {
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
