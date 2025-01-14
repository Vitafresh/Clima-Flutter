import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String temperature;
  String strWeatherIcon;
  String strWeatherMessage;
  String cityName;
  WeatherModel weather = WeatherModel();

  @override
  void initState() {
    super.initState();
    print('LocationScreen:');
    var weatherData = widget.locationWeather;
    updateUI(weatherData);
  }

  void updateUI(dynamic weatherData) {
    //temp = weatherData['main']['temp'] + kKelvin;
    print(weatherData);
    setState(() {
      double temp = weatherData['main']['temp'];
      temperature = temp.toStringAsFixed(0);
      print('temp=' + temp.toStringAsFixed(0) + '°C');

      int condition = weatherData['weather'][0]['id'];
      strWeatherIcon = weather.getWeatherIcon(condition);
      print('weatherId=$condition');

      strWeatherMessage = weather.getMessage(temp.toInt());

      cityName = weatherData['name'];
      print('name=$cityName');
    });
  }

  @override
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
                      var weatherData = await weather.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var typedCity = await Navigator.push(context,
                          MaterialPageRoute(builder: (context){
                            return CityScreen();
                          }));
                      if(typedCity != null){
                        cityName=typedCity;
                        var weatherData = await weather.getCityWeather(cityName);
                        updateUI(weatherData);
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
                      temperature + '°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      strWeatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  //"It's 🍦 time in San Francisco!",
                  '$strWeatherMessage in $cityName',
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
