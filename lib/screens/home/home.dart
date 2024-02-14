// ignore_for_file: use_build_context_synchronously

import 'dart:math';
import 'package:assignment/model/age_group.dart';
import 'package:assignment/model/response/get_employees_list_response.dart';
import 'package:assignment/screens/home/bloc/home_bloc.dart';
import 'package:assignment/utils/screens.dart';
import 'package:assignment/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _searchController;
  AgeGroup? selectedAgeGroup;

  @override
  void initState() {
    _searchController = TextEditingController();
    BlocProvider.of<HomeBloc>(context).add(LoadEmployeesData());
    super.initState();
  }

  void _searchEmployees(String query) {
    if (query.isEmpty) {
      context.read<HomeBloc>().add(LoadEmployeesData());
    }
    context.read<HomeBloc>().add(SearchEmployeeEvent(query));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<AgeGroup> _createAgeGroups(List<Employee> employees, int step) {
    if (employees.isEmpty) {
      return [];
    }
    int minAge = employees.map((e) => e.employeeAge).reduce(min);
    int maxAge = employees.map((e) => e.employeeAge).reduce(max);

    final ageGroups = <AgeGroup>[];
    for (int lowerBound = minAge; lowerBound <= maxAge; lowerBound += step) {
      int upperBound = lowerBound + step - 1;
      if (upperBound > maxAge) {
        upperBound = maxAge;
      }
      ageGroups.add(AgeGroup(lowerBound, upperBound));
    }
    return ageGroups;
  }

  void _openFilterScreen(List<AgeGroup> ageGroups) async {
  final selectedAgeGroup = await Navigator.pushNamed(
    context,
    Screens.filter,
    arguments: ageGroups,
  );
    if (selectedAgeGroup != null) {
      BlocProvider.of<HomeBloc>(context)
          .add(FilterEmployeesByAge(selectedAgeGroup as AgeGroup?));
    } else {
      context.read<HomeBloc>().add(LoadEmployeesData());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeScreen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: (value) {
                _searchEmployees(_searchController.text);
              },
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            Expanded(
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is ErrorState) {
                    return Text(state.error);
                  } else if (state is LoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is EmployeeDataLoadedSuccessState) {
                    return EmployeList(employees: state.employees);
                  } else if (state is SearchResultsState) {
                    return EmployeList(employees: state.searchResults);
                  } else if (state is FilteredEmployeesByAgeState) {
                    return EmployeList(employees: state.filteredEmployees);
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          List<Employee> employees = await SharedPrefs.getEmployees();
          List<AgeGroup> ageGroups = _createAgeGroups(employees, 10);
          _openFilterScreen(ageGroups);
        },
        child: const Icon(Icons.filter_list),
      ),
    );
  }
}

class EmployeList extends StatelessWidget {
  const EmployeList({
    super.key,
    required this.employees,
  });

  final List<Employee> employees;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: employees.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(employees[index].employeeName),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
