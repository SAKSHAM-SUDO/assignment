import 'package:assignment/model/response/get_employees_list_response.dart';
import 'package:assignment/services/api_service.dart';
import 'package:assignment/utils/url.dart';
import 'package:dio/dio.dart';

class Service {
  static final dio = Dio();

  static Future<EmployeeListResponse> getEmployeesList() async {
    Map<String, dynamic> jsonMap = await ApiService.makeRequest(
      Url.GET_EMPLOYEES_LIST,
      RequestType.get,
      null,
      null,
    );
    return EmployeeListResponse.fromJson(jsonMap);
  }
}
