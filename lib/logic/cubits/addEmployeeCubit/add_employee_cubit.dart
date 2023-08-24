import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_assignment2/data/model/employee_model.dart';
import 'package:flutter_assignment2/databaseHelper/database_connection.dart';
import 'package:flutter_assignment2/logic/cubits/addEmployeeCubit/add_employee_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddEmployeeCubit extends Cubit<AddEmployeeState> {
  AddEmployeeCubit() : super(AddEmployeeState()) {
    employeeNameController.addListener(() {
      emit(state.copyWith(employeeName: employeeNameController.text));
    });
  }

  TextEditingController employeeNameController = TextEditingController();

  updateRole(String role) {
    emit(state.copyWith(employeeRole: role));
  }

  updateStartDate(DateTime date) {
    emit(state.copyWith(startDate: date));
  }

  updateEndDate(DateTime? date) {
    emit(state.copyWith(endDate: date, isNullDate: (date == null)));
  }

  saveEmployeeDetails(BuildContext context) async {
    await DatabaseConnection.createEmployee(
      EmployeeModel(employeeName: state.employeeName, employeeRole: state.employeeRole, startDate: (state.startDate ?? DateTime.now()).millisecondsSinceEpoch, endDate: (state.endDate != null)? state.endDate!.millisecondsSinceEpoch : null),
    );
    Fluttertoast.showToast(
      msg: "Employee details save successfully",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
    );
    AutoRouter.of(context).pop(true);
  }

  deleteEmployee(BuildContext context, int id) async {
    await DatabaseConnection.deleteEmployee(id);
    Fluttertoast.showToast(
      msg: "Employee details delete successfully",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
    );
    AutoRouter.of(context).pop(true);
  }

  Future<EmployeeModel> getEmployeeFromId(int id) async {
    var employeeList =  await DatabaseConnection.getEmployee(id);
    List<EmployeeModel> employees = employeeList.map(
            (entry) => EmployeeModel(
          id: entry["id"],
          employeeName: entry["employee_name"],
          employeeRole: entry["employee_role"],
          startDate: entry["start_date"],
          endDate: entry["end_date"],
        )).toList();
    var emp = employees.first;
    employeeNameController.text = emp.employeeName ?? "";
    emit(state.copyWith(employeeName: emp.employeeName, employeeRole: emp.employeeRole, startDate: DateTime.fromMillisecondsSinceEpoch(emp.startDate!), endDate: (emp.endDate != null)? DateTime.fromMillisecondsSinceEpoch(emp.endDate!) : null));
    return emp;
  }
}
