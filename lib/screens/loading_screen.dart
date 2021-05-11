import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/screens/location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  void getLocationAndWeatherData() async {
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
