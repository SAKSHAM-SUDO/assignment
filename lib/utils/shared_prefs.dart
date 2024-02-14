import 'package:assignment/model/response/get_employees_list_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPrefs {
  static const String _keyEmployees = 'employees';
  static final SharedPrefs _instance = SharedPrefs._ctor();

  factory SharedPrefs() {
    return _instance;
  }

  SharedPrefs._ctor();

  static late SharedPreferences _prefs;

  static init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveEmployees(List<Employee> employees) async {
    _prefs = await SharedPreferences.getInstance();
    final String serializedEmployees =
        jsonEncode(employees.map((e) => e.toJson()).toList());
    await _prefs.setString(_keyEmployees, serializedEmployees);
  }

  static Future<List<Employee>> getEmployees() async {
     _prefs = await SharedPreferences.getInstance();
    final String? serializedEmployees = _prefs.getString(_keyEmployees);
    if (serializedEmployees != null) {
      final List<dynamic> decoded = jsonDecode(serializedEmployees);
      return decoded.map((e) => Employee.fromJson(e)).toList();
    } else {
      return [];
    }
  }
}
