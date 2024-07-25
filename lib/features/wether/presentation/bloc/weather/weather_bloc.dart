import 'package:weather_app/core/constants.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/features/country/domin/entites/countrys.dart';
import 'package:weather_app/features/wether/domin/entites/weather_entity.dart';
import 'package:weather_app/features/wether/domin/usecases/get_today_weather_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'weather_event.dart';
part 'weather_states.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherStates> {
  final GetTodayWeatherUseCase getTodayWeatherUseCase;
  int index = DateTime.now().hour;

  WeatherBloc({
    required this.getTodayWeatherUseCase,
  }) : super(WeatherInitState()) {
    on<WeatherEvent>(
      (event, emit) async {
        if (event is GetTodayWeatherEvent) {
          emit(WeatherLoadingState());
          final weatherOrFailure =
              await getTodayWeatherUseCase(event.countryEnitity);
          if (weatherOrFailure.runtimeType == Failure) {
            emit(WeatherFaildState(
                message: getFailureMessage(weatherOrFailure.left)));
          } else {
            emit(TodayWeatherFinishLoadingState(
                todayWeather: weatherOrFailure.right));
          }
        } else if (event is ChangeIndexEvent) {
          emit(WeatherLoadingState());
          index = event.index;
          emit(TodayWeatherFinishLoadingState(
            todayWeather: event.weatherEntity,
          ));
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
