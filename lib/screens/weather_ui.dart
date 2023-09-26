import 'package:flutter/material.dart';
import '../api/weather_api.dart';

class WeatherUI extends StatefulWidget {
  const WeatherUI({super.key});

  @override
  _WeatherUIState createState() => _WeatherUIState();
}

class _WeatherUIState extends State<WeatherUI> {
  late Future<Map<String, dynamic>> weatherData;

  @override
  void initState() {
    super.initState();
    weatherData = WeatherApi.fetchWeatherData();
  }

  // Widget hiển thị thông tin thời tiết
  Widget _buildWeatherInfo(Map<String, dynamic> weatherData) {
    final location = weatherData['location'];
    final current = weatherData['current'];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Thời tiết tại ${location['name']}, ${location['country']}',
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(height: 20),
        Text(
          'Nhiệt độ: ${current['temp_c']}°C',
          style: TextStyle(fontSize: 24),
        ),
        Text(
          'Tình trạng: ${current['condition']['text']}',
          style: TextStyle(fontSize: 18),
        ),
        Image.network(
          'https:${current['condition']['icon']}',
          width: 100,
          height: 100,
        ),
        Text(
          'Độ ẩm: ${current['humidity']}%',
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Center(
        child: FutureBuilder<Map<String, dynamic>>(
          future: weatherData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final weatherData = snapshot.data!;
              return _buildWeatherInfo(weatherData);
            }
          },
        ),
      ),
    );
  }
}
