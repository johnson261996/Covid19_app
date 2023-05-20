
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../model/covidModel.dart';
import '../repository/apiRepository.dart';

part 'covid_event.dart';
part 'covid_state.dart';

class CovidBloc extends Bloc<CovidEvent, CovidState> {
  final ApiRepository _apiRepository = ApiRepository();

  CovidBloc() : super(CovidInitial()) {
    on<CovidEvent>((event, emit)async {
      try {
        emit(CovidLoading());
        final mList = await _apiRepository.fetchCovidList();
        emit(CovidLoaded(mList));
        if (mList.error != null) {
          emit(CovidError(mList.error));
        }
      } on NetworkError {
        emit(CovidError("Failed to fetch data. is your device online?"));
      }    });
  }
}
