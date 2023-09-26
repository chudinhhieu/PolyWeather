import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherApi {
  static Future<Map<String, dynamic>> fetchWeatherData() async {
    final response = await http.get(
      Uri.parse('https://open-weather13.p.rapidapi.com/city/new%20york'),
        headers: {
          'X-RapidAPI-Key': 'a3c3768a83msh0d40f6de0ee49d4p12552fjsn4061d1039af8',
          'X-RapidAPI-Host': 'open-weather13.p.rapidapi.com'
        }
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
