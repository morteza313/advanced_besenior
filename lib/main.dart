import 'package:advanced_besenior/core/widgets/mian_wrapper.dart';
import 'package:advanced_besenior/features/feature_weather/data/dataSource/remote/api_provider.dart';
import 'package:advanced_besenior/features/feature_weather/data/repository/weather_repositoryimpl.dart';
import 'package:advanced_besenior/features/feature_weather/domain/use_cases/get_current_weather_useCase.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    GetCurrentWeatherUsecase getCurrentWeatherUsecase =
        GetCurrentWeatherUsecase(WeatherRepositoryimpl(APiProvider()));

    getCurrentWeatherUsecase('tehran');
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainWrapper(),
    );
  }
}
