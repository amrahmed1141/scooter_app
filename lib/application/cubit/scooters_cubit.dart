import 'package:bloc/bloc.dart';
import 'package:scooter_app/application/cubit/scooters_state.dart';
import 'package:scooter_app/data/datasources/scooter_local_data.dart';
import 'package:scooter_app/data/model/scooter_model.dart';

class ScooterCubit extends Cubit<ScootersState> {
  final ScootersLocalData scootersLocalData;
  ScooterCubit(this.scootersLocalData) : super(ScootersLoading());

  late List<ScooterModel> scooters;

  void fetchScooters() {
    scooters = scootersLocalData.getScooters();
    try {
      emit(ScootersLoaded(scooters));
    } catch (_) {
      emit(ScootersError('Failed to load scooters'));
    }
  }

  void selectScooter(ScooterModel scooterModel) {
    emit(SelectScooter(scooterModel));
  }

  void resetScooterList() {
    emit(ScootersLoaded(scooters));
  }
}
