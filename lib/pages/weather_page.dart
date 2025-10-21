import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:lottie/lottie.dart' ;
import 'package:minimal_weather_app/const/strings.dart';
import 'package:minimal_weather_app/const/styles.dart';
import 'package:minimal_weather_app/pages/settings_page.dart';
import 'package:minimal_weather_app/services/weather_service.dart';

import '../models/weather_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //* api key
  final _weatherService = WeatherService(AppStrings.apiKey);
  Weather? _weather;
  String? _displayCityName;

  //* fetch weather
  void _fetchWeather() async {
    try {
      final position = await _weatherService.getCurrentLocationPosition();

      final weather = await _weatherService.getWeather(
        position.latitude,
        position.longitude,
      );

      setState(() {
        _weather = weather;
      });
      _fetchDisplayCity(position.latitude, position.longitude);
    } catch (e) {
      print("errrrrrrrrrrrrrrrrrrrrrrrrrrreeeeeeeeeeeeee$e");
      setState(() {
        _displayCityName = 'Location or Weather Error';
      });
    }
  }



  //* weather animations
  String getWeatherAnimation(String? mainCondition){
   if (mainCondition==null) return AppStrings.sunnyAnimation; //* default to sunny
    switch(mainCondition.toLowerCase()){
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return AppStrings.cloudyAnimation;
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return AppStrings.rainAnimation;
      case 'thunderstorm':
        return AppStrings.thunderAnimation;
      case 'clear':
        return AppStrings.sunnyAnimation;
      default:
        return AppStrings.sunnyAnimation;
    }
  }

  // في ملف weather_page.dart

  Future<void> _fetchDisplayCity(double lat, double lon) async {
    try {

      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);
      final Placemark placemark = placemarks[0];

      final List<String?> potentialCityNames = [
        placemark.administrativeArea,
        placemark.locality,
        placemark.subAdministrativeArea,
        placemark.country,
      ];

      String? rawCityName;
      for (var name in potentialCityNames) {
        if (name != null && name.trim().isNotEmpty) {
          rawCityName = name;
          break;
        }
      }


      String finalCityName = (rawCityName ?? '').replaceAll('_', '').trim();

      setState(() {
        _displayCityName = finalCityName.isNotEmpty ? finalCityName : null;
      });

    } catch (e) {
      setState(() {
        _displayCityName = 'Location Area';
      });
    }
  }
  //* init state
  @override
  void initState(){
    super.initState();

    //* fetch weather on startup
    _fetchWeather();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor:  Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
              onPressed: (){
                Navigator.push(context,
                MaterialPageRoute(builder: (context)=> const SettingsPage()),
                );
              },
              icon: Icon(Icons.settings,
                 color:  Theme.of(context).colorScheme.primary,
              )
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 100.h,),
              //* location icon
              Icon(Icons.location_on,
              color: Theme.of(context).colorScheme.primary,
              ),
              //* city name
              Text(
                _displayCityName ?? _weather?.cityName ?? AppStrings.loadCity,
                style: TextStyles.cityNameStyle(context),
              ),
        
              SizedBox(height: 120.h,),
              //* animation
              Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
        
              SizedBox(height: 120.h,),
              //* temperature
              Text('${_weather?.temperature.round()??""}°',
              style: TextStyles.temperatureStyle(context)
              ),

        
              //* weather condition
              //Text(_weather?.mainCondition??''),
            ],
          ),
        ),
      ),
    );
  }
}
