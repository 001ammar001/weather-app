import 'package:weather_app/core/constants.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/features/country/domin/entites/countrys.dart';
import 'package:weather_app/features/country/domin/usecases/country_search.dart';
import 'package:weather_app/features/country/domin/usecases/set_location_usecasae.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'country_events.dart';
part 'country_states.dart';

class CountryBloc extends Bloc<CountryEvent, CountryStates> {
  final SearchForCountrysUseCase searchForCountrysUseCase;
  final SetLocationUseCase setLocationUseCase;
  CountryBloc({
    required this.searchForCountrysUseCase,
    required this.setLocationUseCase,
  }) : super(CountryInitState()) {
    on<CountryEvent>(
      (event, emit) async {
        if (event is SearchForCountryEvent) {
          emit(CountryLoadingSearchState());
          final countrysOrFailure = await searchForCountrysUseCase(event.query);
          if (countrysOrFailure.runtimeType == Failure) {
            emit(CountrySearchFaildState(
                message: getFailureMessage(countrysOrFailure.left)));
          } else {
            emit(
                CountryFinishSearchingState(countrys: countrysOrFailure.right));
          }
        } else if (event is SetLocationEvent) {
          emit(SetLocationCountySuccessState(country: event.country));
          setLocationUseCase(event.country);
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
