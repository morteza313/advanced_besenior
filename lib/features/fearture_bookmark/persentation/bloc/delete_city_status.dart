import 'package:equatable/equatable.dart';

abstract class DeleteCityStatus extends Equatable {}

//initiall staet
class DeleteCityInitiall extends DeleteCityStatus {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

//loading state
class DeleteCityLoading extends DeleteCityStatus {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

//loaded state
class DeleteCityCompleted extends DeleteCityStatus {
  final String name;
  DeleteCityCompleted(this.name);

  @override
  List<Object?> get props => [name];
}

//error state
class DeleteCityError extends DeleteCityStatus {
  String message;
  DeleteCityError(this.message);

  @override
  List<Object?> get props => [message];
}
