class AddEmployeeState {
  final String? employeeName;
  final String? employeeRole;
  final DateTime? startDate, endDate;

  AddEmployeeState({this.employeeName, this.employeeRole, this.startDate, this.endDate});

  AddEmployeeState copyWith({employeeName, employeeRole, startDate, endDate, bool isNullDate = false}) {
    return AddEmployeeState(
      employeeName: employeeName ?? this.employeeName,
      employeeRole: employeeRole ?? this.employeeRole,
      startDate: startDate ?? this.startDate,
      endDate: (isNullDate)? null : endDate ?? this.endDate
    );
  }
}