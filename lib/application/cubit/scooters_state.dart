import 'package:scooter_app/data/model/scooter_model.dart';

abstract class ScootersState {}

class ScootersLoading extends ScootersState {}

class ScootersLoaded extends ScootersState {
  final List<ScooterModel> scooters;
  ScootersLoaded(this.scooters);
}

class ScootersError extends ScootersState {
  final String message;
  ScootersError(this.message);
}

class SelectScooter extends ScootersState{
  final ScooterModel scooter;
  SelectScooter(this.scooter);
}
