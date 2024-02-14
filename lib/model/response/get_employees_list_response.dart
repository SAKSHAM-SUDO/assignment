import 'dart:convert';

EmployeeListResponse userFromJson(String str) => EmployeeListResponse.fromJson(json.decode(str));

String userToJson(EmployeeListResponse data) => json.encode(data.toJson());

class EmployeeListResponse {
  String status;
  List<Employee> employees;
  String message;

  EmployeeListResponse({
    required this.status,
    required this.employees,
    required this.message,
  });

  factory EmployeeListResponse.fromJson(Map<String, dynamic> json) => EmployeeListResponse(
        status: json["status"],
        employees: List<Employee>.from(json["data"].map((x) => Employee.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(employees.map((x) => x.toJson())),
        "message": message,
      };
}

class Employee {
  int id;
  String employeeName;
  int employeeSalary;
  int employeeAge;
  String profileImage;

  Employee({
    required this.id,
    required this.employeeName,
    required this.employeeSalary,
    required this.employeeAge,
    required this.profileImage,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"],
        employeeName: json["employee_name"],
        employeeSalary: json["employee_salary"],
        employeeAge: json["employee_age"],
        profileImage: json["profile_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employee_name": employeeName,
        "employee_salary": employeeSalary,
        "employee_age": employeeAge,
        "profile_image": profileImage,
      };
}
