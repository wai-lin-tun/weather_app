import 'dart:convert';

ErrorWeather errorWeatherFromJson(String str) => ErrorWeather.fromJson(json.decode(str));

String errorWeatherToJson(ErrorWeather data) => json.encode(data.toJson());

class ErrorWeather {
    ErrorWeather({
        required this.cod,
        required this.message,
    });

    String cod;
    String message;

    factory ErrorWeather.fromJson(Map<String, dynamic> json) => ErrorWeather(
        cod: json["cod"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "cod": cod,
        "message": message,
    };
}
