import 'package:clima/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkingHelper {
  NetworkingHelper(this.url);

  var url;

  Future getData() async {
    //api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=5e8752a808837d9b64aa7990b885a9f9
    //https://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=5e8752a808837d9b64aa7990b885a9f9

    // Another example from https://ayusch.com/how-to-make-an-api-call-in-flutter-rest-api/
    // https://github.com/Ayusch/flutter-api-calls
    // var response = await http.get(
    //     Uri.encodeFull("https://jsonplaceholder.typicode.com/posts"),
    //     headers: {"Accept": "application/json"});

    // Kherson Latitude: 46.65, Longitude: 32.61

    // var url = Uri.https('api.openweathermap.org', '/data/2.5/weather', {
    //   'lat': latitude.toString(),
    //   'lon': longitude.toString(),
    //   'appid': kApiKEY
    // });

    // print('url=$url');  //For debug only

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
      //print(data);  // For debug only
      return jsonDecode(data);
    } else {
      print('Response code != 200');
      print('Responce code: ' + response.statusCode.toString());
      return null;
    }
  } // getData()
}
