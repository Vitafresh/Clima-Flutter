import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/location.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude;
  double longitude;

  void getLocation() async {
    //print('getLocation() started');
    Location location = Location();
    await location.getLocation();
    latitude = location.latitude;
    longitude = location.longitude;
    print('Location: $latitude, $longitude');
    getData();
    //print('getLocation() ended');
  }

  void getData() async {
    //api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=5e8752a808837d9b64aa7990b885a9f9
    //https://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=5e8752a808837d9b64aa7990b885a9f9

    // var response = await http.get(
    //     Uri.encodeFull("https://jsonplaceholder.typicode.com/posts"),
    //     headers: {"Accept": "application/json"});
    //{'lat': '46.6558', 'lon': '32.6178', 'appid': kApiKEY}); //Kherson

    var url = Uri.https('api.openweathermap.org', '/data/2.5/weather', {
      'lat': latitude.toString(),
      'lon': longitude.toString(),
      'appid': kApiKEY
    });

    print('url=$url');
    print('Creating Response...');

    http.Response response;
    try {
      response = await http.get(url);
    } catch (e) {
      print('Exception: ');
      print(e);
      return null;
    }

    if (response.statusCode == 200) {
      //Server responded normally
      var data = response.body;
      print(data);
      var decodedData = jsonDecode(data);

      double temp = decodedData['main']['temp'] + kKelvin;
      print('temp=$temp');

      int condition = decodedData['weather'][0]['id'];
      print('weatherId=$condition');

      String cityName = decodedData['name'];
      print('name=$cityName');
    } else {
      print('Response!=200');
      print(response.statusCode);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('Getting Location...');
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            //Get the current location
            //getLocation();
            getData();
            print('Get data...');
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
