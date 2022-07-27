import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wather_app/location.dart';
import 'package:http/http.dart' as http;
import 'package:wather_app/model_city.dart';
import 'package:wather_app/modle.screen.dart';

class Forecast extends StatefulWidget {
  const Forecast({Key? key}) : super(key: key);

  @override
  State<Forecast> createState() => _ForecastState();
}

class _ForecastState extends State<Forecast> {
  TextEditingController cityController = TextEditingController();
  String cityName = "yangon";

  WeatherStatus weatherStatus = WeatherStatus();
  Future<ErrorWeather> getErrorWeatherApp(String cityName) async {
    var url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=1c98d67c708fb4f33b01301841909d2b&units=metric");
    var response = await http.get(url);
    if (response.statusCode == 404) {
      return errorWeatherFromJson(response.body);
    } else {
      return throw Exception();
    }
  }

  Future<Weather> getWeatherApp() async {
    var url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=1c98d67c708fb4f33b01301841909d2b&units=metric");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return weatherFromJson(response.body);
    }
    throw Exception();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 67, 95, 93),
        title: SizedBox(
          height: 50,
          child: TextFormField(
            controller: cityController,
            cursorColor: Colors.white,
            decoration: const InputDecoration(
                hintText: "City Search",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                )),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  setState(() {
                    cityName = cityController.text;
                  });
                },
                icon: const Icon(Icons.search)),
          )
        ],
      ),
      body: FutureBuilder<Weather>(
        future: getWeatherApp(),
        builder: (BuildContext context, AsyncSnapshot<Weather> snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;
            return SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      Color.fromARGB(255, 126, 255, 227),
                      Colors.blue
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    data!.sys.country,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    data.name,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            color: Colors.transparent,
                            child: Center(
                              child: Text(
                                data.weather[0].description,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                          SizedBox(
                            child: Center(
                              child: Text(
                                weatherStatus
                                    .getWeatherIcon(data.weather[0].id),
                                style: const TextStyle(fontSize: 130),
                              ),
                            ),
                          ),
                          SizedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    const Icon(Icons.air),
                                    Text(
                                        "${data.wind.speed.toStringAsFixed(0)}km/h"),
                                  ],
                                ),
                                Text(
                                  "${data.main.temp.toStringAsFixed(0)}°",
                                  style: const TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Column(
                                  children: [
                                    const Icon(Icons.water_drop),
                                    Text("${data.clouds.all.toString()}%"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            color: Colors.transparent,
                            child: Center(
                              child: Text(
                                weatherStatus.getMessage(
                                  data.main.temp.toInt(),
                                ),
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 320,
                      decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.vertical(
                            top: Radius.elliptical(
                                MediaQuery.of(context).size.width, 130.0)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 150,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white38,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text("Humidity"),
                                Text("${data.main.humidity}%")
                              ],
                            ),
                          ),
                          Container(
                            height: 150,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white38,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text("feel like"),
                                Text(
                                    "${data.main.feelsLike.toStringAsFixed(0)}°")
                              ],
                            ),
                          ),
                          Container(
                            height: 150,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white38,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [Text(data.weather[0].icon)],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return FutureBuilder<ErrorWeather>(
                future: getErrorWeatherApp(cityName),
                builder: (BuildContext context,
                    AsyncSnapshot<ErrorWeather> snapshot) {
                  return Container(
                    child: Center(
                      child: Text(snapshot.data!.message),
                    ),
                  );
                });
          }
          return const SpinKitRipple(
            color: Colors.red,
            size: 100.0,
          );
        },
      ),
    );
  }
}
