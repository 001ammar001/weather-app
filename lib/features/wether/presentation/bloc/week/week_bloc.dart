import 'package:weather_app/core/constants.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/features/country/domin/entites/countrys.dart';
import 'package:weather_app/features/wether/domin/entites/weather_entity.dart';
import 'package:weather_app/features/wether/domin/usecases/get_week_weather.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'week_event.dart';
part 'week_states.dart';

class WeekBloc extends Bloc<WeekEvent, WeekStates> {
  final GetWeekWeatherUseCase getWeekWeatherUseCase;
  int weekIndex = 0;

  WeekBloc({
    required this.getWeekWeatherUseCase,
  }) : super(WeekInitState()) {
    on<WeekEvent>(
      (event, emit) async {
        if (event is GetWeekWeatherEvent) {
          emit(WeekLoadingState());
          final weatherOrFailure =
              await getWeekWeatherUseCase(event.countryEnitity);
          if (weatherOrFailure.runtimeType == Failure) {
            emit(WeekFaildState(
                message: getFailureMessage(weatherOrFailure.left)));
          } else {
            emit(WeekFinishLoadingState(
              weekWeather: weatherOrFailure.right,
            ));
          }
        }
      },
    );
  }

  String getFailureMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverErrorMessage;
      case NetworkFailure:
        return offlineErrorMessage;
      case EmptyCacheFailure:
        return emptyCacheErrorMessage;
      default:
        return defaultErrorMessage;
    }
  }
}
