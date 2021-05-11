import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';

import 'package:clima/screens/location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  void getLocationAndWeatherData() async {
    // WeatherModel weatherModel = WeatherModel();
    //var weatherData = weatherModel.getLocationWeather();
    var weatherData = await WeatherModel().getLocationWeather();

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return LocationScreen(
          locationWeather: weatherData,
        );
      }),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationAndWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SpinKitFadingCircle(color: Colors.white, size: 150.0),
            RaisedButton(
              onPressed: () {
                //Get the current location
                getLocationAndWeatherData();
                // print('Get Location and weather data...'); // For debug only
              },
              child: Text('Get Location'),
            ),
          ],
        ),
      ),
    );
  }
}
