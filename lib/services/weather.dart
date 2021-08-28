import 'package:clima_weather_detector/services/location.dart';
import 'package:clima_weather_detector/services/networking.dart';

const String kApiKey = 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
const String kOpenWeatherURL =
    'https://api.openweathermap.org/data/2.5/weather';

const String kSunny = 'images/bernina_sunny.png';
const String kThunder = 'images/bernina_thunder.png';
const String kShowers = 'images/bernina_showers.png';
const String kScattered = 'images/bernina_scatteredClouds.png';
const String kOvercast = 'images/bernina_overcast.png';
const String kPlaceholder = 'images/bernina_weather_placeholder.png';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    Networker networker = Networker(
        url: '$kOpenWeatherURL?q=$cityName&appId=$kApiKey&units=imperial');

    return await networker.getData();
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    Networker networker = Networker(
        url:
            '$kOpenWeatherURL?lat=${location.latitude}&lon=${location.longitude}&appId=$kApiKey&units=imperial');

    return await networker.getData();
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

  String getBackground(int condition) {
    if (condition < 300) {
      return kThunder;
    } else if (condition < 600) {
      return kShowers;
    } else if (condition < 700) {
      return kPlaceholder;
    } else if (condition < 800) {
      return kOvercast;
    } else if (condition == 800) {
      return kSunny;
    } else if (condition <= 804) {
      return kScattered;
    } else {
      return kPlaceholder;
    }
  }

  String getMessage(int temp) {
    if (temp > 90) {
      return 'It\'s 🍦 time';
    } else if (temp >= 70) {
      return 'Time for shorts and 👕';
    } else if (temp < 50) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
