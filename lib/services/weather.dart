import 'package:clima/utilities/constants.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

class WeatherModel {

  Future<dynamic> getLocationWeather() async {
    //print('getLocation() started');           // For debug only

    // Duration seconds = Duration(seconds: 5);
    // await Future.delayed(seconds, () {
    //   print('Do something (timeout $seconds sec)');
    // });

    Location location = Location();
    await location.getLocation();
    double latitude = location.latitude;
    double longitude = location.longitude;

    //print('Location: $latitude, $longitude');   // For debug only
    //print('getLocation() ended');             // For debug only

    //api.openweathermap.org/data/2.5/weather?lat=46.63&lon=32.61&appid=5e8752a808837d9b64aa7990b885a9f9
    var url = Uri.https('api.openweathermap.org', '/data/2.5/weather', {
      'lat': latitude.toString(),
      'lon': longitude.toString(),
      'units': 'metric',
      'appid': kApiKEY
    });

    NetworkingHelper netHelper = NetworkingHelper(url);
    var weatherData = await netHelper.getData();
    return weatherData;
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
