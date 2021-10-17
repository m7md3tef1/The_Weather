import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:the_weather/Model/Weather.dart';

class ApiHelper
{
  getWeatherData(cityname) async
  {
    int wid;
    List<WeatherModel> wList = [];
    var response = await http.get(Uri.parse(
        'https://www.metaweather.com/api/location/search/?query=$cityname'));
    var body = jsonDecode(response.body);
    print(body);
    wid = body[0]["woeid"];

    var response2 = await http
        .get(Uri.parse('https://www.metaweather.com/api/location/$wid'));
    var body2 = jsonDecode(response2.body);
    body2['consolidated_weather'].forEach((element) {
      WeatherModel w = WeatherModel(
        cityname: body[0]['title'],
        temp: element["the_temp"],
        icon: element["weather_state_abbr"],
        maxTemp: element["max_temp"],
        minTamp: element['min_temp'],
        date: element['application_date'],
      );
      wList.add(w);
    });
    return wList;
  }
  
locationDate() async{
Position p= await Geolocator().getCurrentPosition();
print(p.latitude);
print(p.longitude);
}
}
