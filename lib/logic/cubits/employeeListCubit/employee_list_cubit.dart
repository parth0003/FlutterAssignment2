import 'package:flutter/material.dart';
import 'package:flutter_assignment2/commonWidgets/text_widget.dart';
import 'package:flutter_assignment2/constants/color_constant.dart';
import 'package:flutter_assignment2/data/model/employee_model.dart';
import 'package:flutter_assignment2/databaseHelper/database_connection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

part 'employee_list_state.dart';

class EmployeeListCubit extends Cubit<EmployeeListState> {
  EmployeeListCubit() : super(FetchEmployeeListState()) {
    getEmployeeList();
  }

  getEmployeeList() {
    DatabaseConnection.getEmployees().then((employeeList) {
      List<EmployeeModel> employees = employeeList.map(
              (entry) => EmployeeModel(
            id: entry["id"],
            employeeName: entry["employee_name"],
            employeeRole: entry["employee_role"],
            startDate: entry["start_date"],
            endDate: entry["end_date"],
          )).toList();

      if(employees.isEmpty) {
        emit(EmptyListState());
      } else {
        emit(HasEmployeeDataState(employees));
      }
    });
  }

  deleteEmployee(int id, EmployeeModel employeeModel, BuildContext context) async {
    await DatabaseConnection.deleteEmployee(id);
    getEmployeeList();
    final snackBar = SnackBar(
      content: textWidget("Employee data has been deleted", ColorConstant.whiteColor, 11.sp, FontWeight.w400),
      duration: const Duration(seconds: 3), // Duration for how long the SnackBar is displayed
      action: SnackBarAction(
        label: 'Undo',
        textColor: ColorConstant.primaryColor,
        onPressed: () async {
          await DatabaseConnection.createEmployee(employeeModel);
          getEmployeeList();
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
