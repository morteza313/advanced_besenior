import 'package:advanced_besenior/core/params/forcast_params.dart';
import 'package:advanced_besenior/core/resources/data_state.dart';
import 'package:advanced_besenior/features/feature_weather/data/dataSource/remote/api_provider.dart';
import 'package:advanced_besenior/features/feature_weather/data/models/current_city_model.dart';
import 'package:advanced_besenior/features/feature_weather/data/models/forcastDaysModel.dart';
import 'package:advanced_besenior/features/feature_weather/data/models/suggest_city_model.dart';
import 'package:advanced_besenior/features/feature_weather/domain/entities/current_city_entities.dart';
import 'package:advanced_besenior/features/feature_weather/domain/entities/forcast_days_entities.dart';
import 'package:advanced_besenior/features/feature_weather/domain/entities/suggest_city_entity.dart';
import 'package:advanced_besenior/features/feature_weather/domain/repository/weather_repository.dart';
import 'package:dio/dio.dart';

class WeatherRepositoryimpl extends WeatherRepository {
  APiProvider apiProvider;
  WeatherRepositoryimpl(this.apiProvider);
  @override
  Future<DataState<CurrentCityEntity>> fetchCurrentWeatherData(
      String cityName) async {
    try {
      Response response = await apiProvider.callCurrentWeather(cityName);

      if (response.statusCode == 200) {
        CurrentCityEntity currentCityEntity =
            CurrentCityModel.fromJson(response.data);
        return DataSuccess(currentCityEntity);
      } else {
        return const DataFailed('Something went wron, try again ...');
      }
    } catch (e) {
      return const DataFailed('please check your connection ...');
    }
  }

  @override
  Future<DataState<ForecastDaysEntity>> fetchForecastWeatherData(
      ForcastParams params) async {
    try {
      Response response = await apiProvider.sendRequest7DaysForcast(params);

      if (response.statusCode == 200) {
        ForecastDaysEntity forecastDaysEntity =
            ForecastDaysModel.fromJson(response.data);
        return DataSuccess(forecastDaysEntity);
      } else {
        return const DataFailed('Something went wron, try again ...');
      }
    } catch (e) {
      return const DataFailed('please check your connection ...');
    }
  }

  @override
  Future<List<Data>> fetchSuggestData(cityName) async {
    Response response = await apiProvider.sendRequestCitySuggestion(cityName);

    SuggestCityEntity suggestCityEntity =
        SuggestCityModel.fromJson(response.data);

    return suggestCityEntity.data!;
  }
}
