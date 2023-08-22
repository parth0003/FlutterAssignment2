import 'package:flutter_assignment2/data/model/employee_model.dart';
import 'package:flutter_assignment2/databaseHelper/database_connection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'employee_list_state.dart';

class EmployeeListCubit extends Cubit<EmployeeListState> {
  EmployeeListCubit() : super(FetchEmployeeListState()) {
    DatabaseConnection.getEmployees().then((employeeList) {
      List<EmployeeModel> employees = employeeList.map(
              (entry) => EmployeeModel(
                  id: entry["id"],
                  employeeName: entry["employee_name"],
                  employeeRole: entry["employee_role"],
                  startDate: ((entry["start_date"] != null)? DateTime.parse(entry["start_date"]) : null),
                  endDate: ((entry["end_date"] != null)? DateTime.parse(entry["end_date"]) : null),
              )).toList();

      if(employees.isEmpty) {
        emit(EmptyListState());
      } else {
        emit(HasEmployeeDataState(employees));
      }
    });
  }
}
