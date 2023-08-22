class EmployeeModel {
  int? id;
  String? employeeName, employeeRole;
  DateTime? startDate, endDate;

  EmployeeModel({this.id, this.employeeName, this.employeeRole, this.startDate, this.endDate});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "employee_name": employeeName,
      "employee_role": employeeRole,
      "start_date": startDate,
      "end_date": endDate,
    };
  }
}
