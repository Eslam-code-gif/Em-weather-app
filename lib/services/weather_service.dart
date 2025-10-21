import 'dart:convert';


import 'package:geolocator/geolocator.dart';
import 'package:minimal_weather_app/const/strings.dart';

import '../models/weather_model.dart';
import 'package:http/http.dart' as http;
class WeatherService {
  static const String BASE_URL = AppStrings.baseUrl;
  final String apiKey;

  WeatherService(this.apiKey);


  Future<Weather> getWeather(double latitude, double longitude) async {
    final url = '$BASE_URL?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      print("Failed to load weather. Status code: ${response.statusCode}");
      print("API Response body: ${response.body}");
      throw Exception(AppStrings.weatherError);
    }
  }


  Future<Position> getCurrentLocationPosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error(AppStrings.locationDisable);
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error(AppStrings.locationDenied);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(AppStrings.locationPermanentlyDenied);
    }

    //* fetch the current location
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: AndroidSettings(
        accuracy: LocationAccuracy.high,
        forceLocationManager: true,
        timeLimit: Duration(
            seconds: 30),
      ),
    );

    print("Received Position: Lat=${position.latitude}, Lon=${position
        .longitude}, Accuracy=${position.accuracy}m");

    return position;
  }
}