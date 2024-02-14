part of 'home_bloc.dart';

class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadEmployeesData extends HomeEvent {}

class SearchEmployeeEvent extends HomeEvent {
  final String name;
  const SearchEmployeeEvent(this.name);
}
class FilterEmployeesByAge extends HomeEvent {
  final AgeGroup? ageGroup;
  const FilterEmployeesByAge(this.ageGroup);
}
