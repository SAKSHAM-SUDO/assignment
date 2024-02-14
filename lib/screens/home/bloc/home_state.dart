part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class LoadingState extends HomeState {}

class EmployeeDataLoadedSuccessState extends HomeState {
  final List<Employee> employees;
  const EmployeeDataLoadedSuccessState(this.employees);
}

class ErrorState extends HomeState {
  final String error;
  const ErrorState(this.error);
}

class SearchResultsState extends HomeState {
  final List<Employee> searchResults;
  const SearchResultsState(this.searchResults);
}

class FilteredEmployeesByAgeState extends HomeState {
  final List<Employee> filteredEmployees;
  const FilteredEmployeesByAgeState(this.filteredEmployees);
}

