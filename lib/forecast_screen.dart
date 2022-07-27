import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:wather_app/forecast_model.dart';
import 'package:wather_app/location.dart';
import 'package:http/http.dart' as http;

class WeatherForecastScreen extends StatefulWidget {
  const WeatherForecastScreen({Key? key}) : super(key: key);

  @override
  State<WeatherForecastScreen> createState() => _WeatherForecastScreenState();
}

class _WeatherForecastScreenState extends State<WeatherForecastScreen> {
  Loading loading = Loading();
  WeatherStatus weatherStatus = WeatherStatus();
  Future<WeatherForecast> getWeatherForecast() async {
    await loading.initLocationService();
    var latitude = loading.latitude;
    var longitude = loading.longitude;
    var url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=b056a6201885b0b4ec820c308df3a343&units=metric");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return weatherForecastFromJson(response.body);
    }
    return throw Exception();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 126, 197, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 67, 95, 93),
        title: const Text("Weather Forecast"),
        centerTitle: true,
      ),
      body: FutureBuilder<WeatherForecast>(
        future: getWeatherForecast(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            color: Colors.transparent,
                            child: const Center(
                              child: Text(
                                "Forecast For Today",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 10,
                          child: SizedBox(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child:Container(
                                    color: Colors.transparent,
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                           Text(
                                                  DateFormat.Hm().format(
                                                      snapshot.data!.list[0].dtTxt),
                                                  style: const TextStyle(fontSize: 20),
                                                ),
                                                 Text(
                                                  DateFormat.Hm().format(
                                                      snapshot.data!.list[1].dtTxt),
                                                  style: const TextStyle(fontSize: 20),
                                                ),
                                                 Text(
                                                  DateFormat.Hm().format(
                                                      snapshot.data!.list[2].dtTxt),
                                                  style: const TextStyle(fontSize: 20),
                                                ),
                                                 Text(
                                                  DateFormat.Hm().format(
                                                      snapshot.data!.list[3].dtTxt),
                                                  style: const TextStyle(fontSize: 20),
                                                ),
                                                 Text(
                                                  DateFormat.Hm().format(
                                                      snapshot.data!.list[4].dtTxt),
                                                  style: const TextStyle(fontSize: 20),
                                                ),
                                        ],
                                      ),
                                    ),
                                ), ),
                                Expanded(
                                  flex: 2,
                                  child:Container(
                                    color: Colors.transparent,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children:const [
                                       Text("-"),
                                        Text("-"),
                                         Text("-"),
                                          Text("-"),
                                           Text("-")
                                      ],
                                    ),
                                  ),
                                ), ),
                                Expanded(
                                  flex: 2,
                                  child:Container(
                                  color: Colors.transparent,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                        "${snapshot.data!.list[0].main.temp.toStringAsFixed(0)}°",
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      Text(
                                        "${snapshot.data!.list[1].main.temp.toStringAsFixed(0)}°",
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      Text(
                                        "${snapshot.data!.list[2].main.temp.toStringAsFixed(0)}°",
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      Text(
                                        "${snapshot.data!.list[3].main.temp.toStringAsFixed(0)}°",
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      Text(
                                        "${snapshot.data!.list[4].main.temp.toStringAsFixed(0)}°",
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      ],
                                    ),
                                  ),
                                ), ),
                                Expanded(
                                  flex: 2,
                                  child:Container(
                                  color: Colors.transparent,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                       Text(
                                      weatherStatus.getWeatherIcon(snapshot
                                          .data!.list[0].weather[0].id),
                                      style: const TextStyle(fontSize: 30),
                                    ),
                                    Text(
                                      weatherStatus.getWeatherIcon(snapshot
                                          .data!.list[1].weather[0].id),
                                      style: const TextStyle(fontSize: 30),
                                    ),
                                    Text(
                                      weatherStatus.getWeatherIcon(snapshot
                                          .data!.list[2].weather[0].id),
                                      style: const TextStyle(fontSize: 30),
                                    ),
                                    Text(
                                      weatherStatus.getWeatherIcon(snapshot
                                          .data!.list[3].weather[0].id),
                                      style: const TextStyle(fontSize: 30),
                                    ),
                                    Text(
                                      weatherStatus.getWeatherIcon(snapshot
                                          .data!.list[4].weather[0].id),
                                      style: const TextStyle(fontSize: 30),
                                    )
                                    ],),
                                  ),
                                ), ),
                              ]
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            color: Colors.transparent,
                            child: const Center(
                              child: Text(
                                "5 Days Forecast",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 10,
                          child: SizedBox(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child:Container(
                                    color: Colors.transparent,
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                           Text(
                                                  DateFormat.E().format(
                                                      snapshot.data!.list[6].dtTxt),
                                                  style: const TextStyle(fontSize: 20),
                                                ),
                                                 Text(
                                                  DateFormat.E().format(
                                                      snapshot.data!.list[14].dtTxt),
                                                  style: const TextStyle(fontSize: 20),
                                                ),
                                                 Text(
                                                  DateFormat.E().format(
                                                      snapshot.data!.list[22].dtTxt),
                                                  style: const TextStyle(fontSize: 20),
                                                ),
                                                 Text(
                                                  DateFormat.E().format(
                                                      snapshot.data!.list[30].dtTxt),
                                                  style: const TextStyle(fontSize: 20),
                                                ),
                                                 Text(
                                                  DateFormat.E().format(
                                                      snapshot.data!.list[38].dtTxt),
                                                  style: const TextStyle(fontSize: 20),
                                                ),
                                        ],
                                      ),
                                    ),
                                ), ),
                                Expanded(
                                  flex: 2,
                                  child:Container(
                                    color: Colors.transparent,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children:const [
                                       Text("-"),
                                        Text("-"),
                                         Text("-"),
                                          Text("-"),
                                           Text("-")
                                      ],
                                    ),
                                  ),
                                ), ),
                                Expanded(
                                  flex: 2,
                                  child:Container(
                                  color: Colors.transparent,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                        "${snapshot.data!.list[6].main.temp.toStringAsFixed(0)}°",
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      Text(
                                        "${snapshot.data!.list[14].main.temp.toStringAsFixed(0)}°",
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      Text(
                                        "${snapshot.data!.list[22].main.temp.toStringAsFixed(0)}°",
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      Text(
                                        "${snapshot.data!.list[30].main.temp.toStringAsFixed(0)}°",
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      Text(
                                        "${snapshot.data!.list[38].main.temp.toStringAsFixed(0)}°",
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      ],
                                    ),
                                  ),
                                ), ),
                                Expanded(
                                  flex: 2,
                                  child:Container(
                                  color: Colors.transparent,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                       Text(
                                      weatherStatus.getWeatherIcon(snapshot
                                          .data!.list[6].weather[0].id),
                                      style: const TextStyle(fontSize: 30),
                                    ),
                                    Text(
                                      weatherStatus.getWeatherIcon(snapshot
                                          .data!.list[14].weather[0].id),
                                      style: const TextStyle(fontSize: 30),
                                    ),
                                    Text(
                                      weatherStatus.getWeatherIcon(snapshot
                                          .data!.list[22].weather[0].id),
                                      style: const TextStyle(fontSize: 30),
                                    ),
                                    Text(
                                      weatherStatus.getWeatherIcon(snapshot
                                          .data!.list[30].weather[0].id),
                                      style: const TextStyle(fontSize: 30),
                                    ),
                                    Text(
                                      weatherStatus.getWeatherIcon(snapshot
                                          .data!.list[38].weather[0].id),
                                      style: const TextStyle(fontSize: 30),
                                    )
                                    ],),
                                  ),
                                ), ),
                              ]
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
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
