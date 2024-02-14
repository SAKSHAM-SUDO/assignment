import 'package:assignment/model/age_group.dart';
import 'package:assignment/model/response/get_employees_list_response.dart';
import 'package:assignment/utils/shared_prefs.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repository/repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(LoadingState()) {
    on<LoadEmployeesData>(_loadEmployeesData);
    on<SearchEmployeeEvent>(_searchEmployee);
    on<FilterEmployeesByAge>(_filterEmployeesByAge);
  }
  _loadEmployeesData(LoadEmployeesData event, Emitter<HomeState> emit) async {
    emit(LoadingState());
    List<Employee> employeeList = await SharedPrefs.getEmployees();
    if (employeeList.isNotEmpty) {
      emit(EmployeeDataLoadedSuccessState(employeeList));
    } else {
      EmployeeListResponse response = await Repository.getEmployeesList();
      if (response.status == "success") {
        SharedPrefs.saveEmployees(response.employees);
        emit(EmployeeDataLoadedSuccessState(response.employees));
      } else {
        emit(ErrorState(response.message));
      }
    }
  }

  _searchEmployee(
    SearchEmployeeEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(LoadingState());

    final List<Employee> allEmployees = await SharedPrefs.getEmployees();
    final List<Employee> searchResults = allEmployees
        .where((employee) => employee.employeeName
            .toLowerCase()
            .contains(event.name.toLowerCase()))
        .toList();
    emit(SearchResultsState(searchResults));
  }

  List<Employee> filterEmployeesByAge(
      List<Employee> employees, AgeGroup? ageGroup) {
    if (ageGroup == null) {
      return employees;
    }

    return employees.where((employee) {
      return employee.employeeAge >= ageGroup.lowerBound &&
          employee.employeeAge <= ageGroup.upperBound;
    }).toList();
  }

  _filterEmployeesByAge(
      FilterEmployeesByAge event, Emitter<HomeState> emit) async {
    emit(LoadingState());
    List<Employee> allEmployees = await SharedPrefs.getEmployees();
    final List<Employee> filteredEmployees =
        filterEmployeesByAge(allEmployees, event.ageGroup);
    emit(FilteredEmployeesByAgeState(filteredEmployees));
  }
}
