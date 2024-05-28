import 'package:advanced_besenior/features/feature_weather/domain/entities/current_city_entities.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class CwStatus extends Equatable {}

class CwLoading extends CwStatus {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CwCompleated extends CwStatus {
  final CurrentCityEntity currentCityEntity;

  CwCompleated(this.currentCityEntity);

  @override
  // TODO: implement props
  List<Object?> get props => [currentCityEntity];
}

class CWError extends CwStatus {
  final String message;
  CWError(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
