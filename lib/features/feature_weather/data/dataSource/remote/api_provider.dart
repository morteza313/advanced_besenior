import 'package:advanced_besenior/core/utils/constants.dart';
import 'package:dio/dio.dart';

class APiProvider {
  final Dio dio = Dio();
  var apiKey = Constants.apiKey;

// current weather api call
  Future<dynamic> callCurrentWeather(cityName) async {
    var respone = await dio.get(
      '${Constants.baseUrl}/data/2.5/weather',
      queryParameters: {
        'q': cityName,
        "appid": Constants.apiKey,
        "units": 'metric',
      },
    );
    return respone;
  }
}
