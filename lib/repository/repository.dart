import 'package:assignment/model/response/get_employees_list_response.dart';
import 'package:assignment/services/services.dart';

class Repository {
  static Future<EmployeeListResponse> getEmployeesList() =>
      Service.getEmployeesList();
}
