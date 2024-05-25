import 'package:advanced_besenior/features/feature_weather/domain/entities/current_city_entities.dart';
import 'package:flutter/material.dart';

@immutable
abstract class CwStatus {}

class CwLoading extends CwStatus {}

class CwCompleated extends CwStatus {
  final CurrentCityEntity currentCityEntity;

  CwCompleated(this.currentCityEntity);
}

class CWError extends CwStatus {
  final String message;
  CWError(this.message);
}
