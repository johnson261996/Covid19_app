part of 'covid_bloc.dart';

@immutable
abstract class CovidEvent {
  const CovidEvent();

  @override
  List<Object> get props => [];
}

class GetCovidList extends CovidEvent {}

