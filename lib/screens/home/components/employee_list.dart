import 'package:assignment/model/response/get_employees_list_response.dart';
import 'package:flutter/material.dart';
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
                  subtitle:
                      Text('Age- ${employees[index].employeeAge.toString()}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
