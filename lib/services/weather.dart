import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

class WeatherModel {
  Future<dynamic> getCityWeatherData(String cityName) async {
    NetworkHelper networkHelper = await NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=7bba544d21031439d2242f529ed44f92&units=metric');
    dynamic decodedData = await networkHelper.getData();
    return decodedData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getLocation();

    NetworkHelper networkHelper = await NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=7bba544d21031439d2242f529ed44f92&units=metric');
    dynamic decodedData = await networkHelper.getData();
    return decodedData;
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
