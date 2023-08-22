part of 'employee_list_cubit.dart';

abstract class EmployeeListState {}

class FetchEmployeeListState extends EmployeeListState {

}

class EmptyListState extends EmployeeListState {

}

class HasEmployeeDataState extends EmployeeListState {
  List<EmployeeModel> employees;

  HasEmployeeDataState(this.employees);
}

