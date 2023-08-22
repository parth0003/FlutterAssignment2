import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum AddEmployeeState {initial}

class AddEmployeeCubit extends Cubit<AddEmployeeState> {
  AddEmployeeCubit() : super(AddEmployeeState.initial);

  DateTime startDate = DateTime.now();
  DateTime? endDate;
  TextEditingController employeeNameController = TextEditingController();
  TextEditingController employeeRoleController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
}