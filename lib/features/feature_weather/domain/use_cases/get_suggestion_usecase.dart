import 'package:advanced_besenior/core/usecase/use_case.dart';
import 'package:advanced_besenior/features/feature_weather/data/models/suggest_city_model.dart';
import 'package:advanced_besenior/features/feature_weather/domain/repository/weather_repository.dart';

class GetSuggestionUsecase implements UseCase<List<Data>, String> {
  final WeatherRepository _weatherRepository;
  GetSuggestionUsecase(this._weatherRepository);

  @override
  Future<List<Data>> call(String param) {
    return _weatherRepository.fetchSuggestData(param);
  }
}
