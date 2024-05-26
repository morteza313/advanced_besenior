import 'package:advanced_besenior/core/params/forcast_params.dart';
import 'package:advanced_besenior/core/resources/data_state.dart';
import 'package:advanced_besenior/features/feature_weather/data/models/suggest_city_model.dart';
import 'package:advanced_besenior/features/feature_weather/domain/entities/current_city_entities.dart';
import 'package:advanced_besenior/features/feature_weather/domain/entities/forcast_days_entities.dart';

abstract class WeatherRepository {
  Future<DataState<CurrentCityEntity>> fetchCurrentWeatherData(String cityName);
  Future<DataState<ForecastDaysEntity>> fetchForecastWeatherData(
      ForcastParams params);
  Future<List<Data>> fetchSuggestData(cityName);
}
