import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wather_app/forecast_screen.dart';
import 'package:wather_app/location.dart';
import 'package:wather_app/modle.screen.dart';
import 'package:http/http.dart' as http;
import 'package:wather_app/second_screen.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({Key? key}) : super(key: key);

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  Loading loading = Loading();
  WeatherStatus weatherStatus = WeatherStatus();

  Future<Weather> getWeather() async {
    await loading.initLocationService();
    var latitude = loading.latitude;
    var longitude = loading.longitude;
    var url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=b056a6201885b0b4ec820c308df3a343&units=metric");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      print(response.statusCode);
      return weatherFromJson(response.body);
    }

    return throw Exception(response.statusCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title:const Text("Weather App"),
        backgroundColor:const Color.fromARGB(255, 67, 95, 93),
        actions: [
        IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const Forecast()));
          },
          icon:const Padding(
            padding:  EdgeInsets.only(right: 10),
            child:  Icon(Icons.search),
          ))
      ]),
      body: FutureBuilder<Weather>(
        future: getWeather(),
        builder: (BuildContext context, AsyncSnapshot<Weather> snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;
            return Container(
              decoration:const BoxDecoration(
                gradient:  LinearGradient(
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
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.transparent,
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
                                style: const TextStyle(fontSize: 120),
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
                            height: 20,
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
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>const WeatherForecastScreen() ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white38
                                ),
                                child:const Padding(
                                  padding:  EdgeInsets.all(8.0),
                                  child: Text("5 Days Forecast"),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
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
                    ),
                  )
                ],
              ),
            );
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
