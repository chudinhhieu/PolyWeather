import 'package:flutter/material.dart';
import 'package:polyweather/units/convert.dart';
import '../api/weather_api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<Map<String, dynamic>> weatherData;

  @override
  void initState() {
    super.initState();
    weatherData = WeatherApi.fetchWeatherData();
  }

  Widget _buildWeatherInfo(Map<String, dynamic> weatherData) {
    final main = weatherData['main'];
    final weather = weatherData['weather'][0];

    return Scaffold(
      backgroundColor: Colors.white,
      endDrawer: const Drawer(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.arrow_back,
                    size: 26,
                  ),
                  Icon(
                    Icons.search,
                    size: 26,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text(
          '14:56',
          style: TextStyle(fontWeight: FontWeight.w300, fontSize: 22),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(
              width: 380,
              height: 380,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/weather/cloudy.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                RichText(
                    text: TextSpan(
                        text:
                            Convert().fahrenheitToCelsius(main['temp']),
                        style: const TextStyle(
                            fontSize: 70,
                            fontWeight: FontWeight.w100,
                            color: Colors.black45),
                      children: const <TextSpan>[
                        TextSpan(
                          text:'°C',
                          style: TextStyle(
                            fontSize: 35,
                            color: Colors.black54,
                          ),
                        ),
                      ],)),
                const SizedBox(width: 12),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                      '${Convert().fahrenheitToCelsius(main['temp_max'])}°',
                      style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w100,
                          color: Colors.black45)),
                ),
                const Text('/',
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w100,
                        color: Colors.black45)),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                      '${Convert().fahrenheitToCelsius(main['temp_min'])}°',
                      style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w100,
                          color: Colors.black45)),
                ),
              ],
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'SEPTEMBER 7TH, 16TH',
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 13,
                    fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(height: 7),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                weatherData['name'],
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 7),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                Convert().capitalizeFirstLetter(weather['description']),
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
            ),

            const SizedBox(height: 10),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Details',
                style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 25),
            Column(
              children: [
                Row(
                  children: [
                    DetailsWeather(
                        urlImage: 'assets/icons/temperature.png',
                        name: 'Feels like',
                        values: Convert().fahrenheitToCelsius(main['feels_like']),
                        unit: '°C'),
                    const SizedBox(width: 15),
                    DetailsWeather(
                        urlImage: 'assets/icons/humidity.png',
                        name: 'Humidity',
                        values: main['humidity'].toString(),
                        unit: '%'),
                    const SizedBox(width: 15),
                    DetailsWeather(
                        urlImage: 'assets/icons/ultraviolet.png',
                        name: 'Chỉ Số UV',
                        values: '2'),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    DetailsWeather(
                        urlImage: 'assets/icons/view.png',
                        name: 'Visibility ',
                        values: (weatherData['visibility']/1000).toInt().toString(),
                        unit: 'km'),
                    const SizedBox(width: 15),
                    Center(
                      child: DetailsWeather(
                          urlImage: 'assets/icons/wind.png',
                          name: 'Wind speed',
                          values: weatherData['wind']['speed'].toString(),
                          unit: 'km/s'),
                    ),
                    const SizedBox(width: 15),
                    DetailsWeather(
                        urlImage: 'assets/icons/pressure.png',
                        name: 'Pressure',
                        values: main['pressure'].toString()),
                  ],
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<Map<String, dynamic>>(
        future: weatherData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final weatherData = snapshot.data!;
            return _buildWeatherInfo(weatherData);
          }
        },
      ),
    );
  }

  Expanded DetailsWeather(
      {required String urlImage,
      required String name,
      String? unit,
      required String values}) {
    return Expanded(
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image(
                image: AssetImage(urlImage),
                width: 20,
                height: 20,
              ),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black54,
                ),
              ),
              RichText(
                text: TextSpan(
                  text: values,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: unit != null ? ' $unit' : '',
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
