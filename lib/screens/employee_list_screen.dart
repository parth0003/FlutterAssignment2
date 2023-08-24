import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment2/commonWidgets/text_widget.dart';
import 'package:flutter_assignment2/constants/color_constant.dart';
import 'package:flutter_assignment2/constants/image_constant.dart';
import 'package:flutter_assignment2/logic/cubits/employeeListCubit/employee_list_cubit.dart';
import 'package:flutter_assignment2/routes/routes_import.gr.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

@RoutePage()
class EmployeeListScreen extends StatelessWidget {
  const EmployeeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmployeeListCubit(),
      child: const EmployeeList(),
    );
  }
}

class EmployeeList extends StatelessWidget {
  const EmployeeList({super.key});

  @override
  Widget build(BuildContext context) {
    var employeeListCubit = BlocProvider.of<EmployeeListCubit>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: textWidget("Employee List", ColorConstant.whiteColor, 14.sp, FontWeight.w500),
        backgroundColor: ColorConstant.primaryColor,
      ),
      body: SafeArea(
        child: BlocBuilder<EmployeeListCubit, EmployeeListState>(
          builder: (context, state) {
            if (state is HasEmployeeDataState) {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          () {
                            var employeeList = state.employees;
                            var currentEmployee = employeeList
                                .where(
                                    (emp) => ((emp.endDate == null) || (DateTime.fromMillisecondsSinceEpoch(emp.endDate!).isAfter(DateTime.now()))))
                                .toList();
                            return (currentEmployee.isNotEmpty)
                                ? Column(
                                    children: [
                                      Container(
                                        color: ColorConstant.backgroundColor,
                                        width: double.infinity,
                                        padding: EdgeInsets.symmetric(vertical: 2.5.h, horizontal: 4.w),
                                        child: textWidget("Current employees", ColorConstant.primaryColor, 13.sp, FontWeight.w500),
                                      ),
                                      ListView.builder(
                                        physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: currentEmployee.length,
                                        itemBuilder: (context, index) {
                                          var emp = currentEmployee[index];
                                          return SwipeActionCell(
                                            key: ObjectKey(currentEmployee[index]),
                                            trailingActions: <SwipeAction>[
                                              SwipeAction(
                                                  icon: Image.asset(
                                                    ImageConstant.deleteIcon,
                                                    width: 7.w,
                                                  ),
                                                  onTap: (CompletionHandler handler) async {
                                                    employeeListCubit.deleteEmployee(emp.id!, emp, context);
                                                  },
                                                  color: Colors.red),
                                            ],
                                            child: GestureDetector(
                                              onTap: () {
                                                AutoRouter.of(context).push(AddEmployeeDetailsRoute(isEdit: true, empId: emp.id!)).then((value) {
                                                  if (value is bool && value) {
                                                    employeeListCubit.getEmployeeList();
                                                  }
                                                });
                                              },
                                              behavior: HitTestBehavior.translucent,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 2.h),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        textWidget(emp.employeeName ?? "", ColorConstant.textColor, 12.sp, FontWeight.w500),
                                                        Padding(
                                                          padding: EdgeInsets.symmetric(vertical: 1.h),
                                                          child: textWidget(emp.employeeRole ?? "", ColorConstant.hintColor, 11.sp, FontWeight.w400),
                                                        ),
                                                        textWidget("From ${DateFormat("d MMM, yyyy").format(DateTime.fromMillisecondsSinceEpoch(emp.startDate!))}${(emp.endDate != null)? " - ${DateFormat("d MMM, yyyy").format(DateTime.fromMillisecondsSinceEpoch(emp.endDate!))}" : ""}", ColorConstant.hintColor, 10.sp, FontWeight.w400),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 2.h),
                                                  Divider(
                                                    color: ColorConstant.dividerColor,
                                                    height: 0,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  )
                                : const SizedBox();
                          }(),
                          () {
                            var employeeList = state.employees;
                            var previousEmployee = employeeList
                                .where(
                                    (emp) => ((emp.endDate != null) && (DateTime.fromMillisecondsSinceEpoch(emp.endDate!).isBefore(DateTime.now()))))
                                .toList();
                            return (previousEmployee.isNotEmpty)
                                ? Column(
                                    children: [
                                      Container(
                                        color: ColorConstant.backgroundColor,
                                        width: double.infinity,
                                        padding: EdgeInsets.symmetric(vertical: 2.5.h, horizontal: 4.w),
                                        child: textWidget("Previous employees", ColorConstant.primaryColor, 13.sp, FontWeight.w500),
                                      ),
                                      ListView.builder(
                                        physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: previousEmployee.length,
                                        itemBuilder: (context, index) {
                                          var emp = previousEmployee[index];
                                          return SwipeActionCell(
                                            key: ObjectKey(previousEmployee[index]),
                                            trailingActions: <SwipeAction>[
                                              SwipeAction(
                                                  icon: Image.asset(
                                                    ImageConstant.deleteIcon,
                                                    width: 7.w,
                                                  ),
                                                  onTap: (CompletionHandler handler) async {
                                                    employeeListCubit.deleteEmployee(emp.id!, emp, context);
                                                  },
                                                  color: Colors.red),
                                            ],
                                            child: GestureDetector(
                                              onTap: () {
                                                AutoRouter.of(context).push(AddEmployeeDetailsRoute(isEdit: true, empId: emp.id!)).then((value) {
                                                  if (value is bool && value) {
                                                    employeeListCubit.getEmployeeList();
                                                  }
                                                });
                                              },
                                              behavior: HitTestBehavior.translucent,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 2.h),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        textWidget(emp.employeeName ?? "", ColorConstant.textColor, 12.sp, FontWeight.w500),
                                                        Padding(
                                                          padding: EdgeInsets.symmetric(vertical: 1.h),
                                                          child: textWidget(emp.employeeRole ?? "", ColorConstant.hintColor, 11.sp, FontWeight.w400),
                                                        ),
                                                        textWidget("From ${DateFormat("d MMM, yyyy").format(DateTime.fromMillisecondsSinceEpoch(emp.startDate!))}${(emp.endDate != null)? " - ${DateFormat("d MMM, yyyy").format(DateTime.fromMillisecondsSinceEpoch(emp.endDate!))}" : ""}", ColorConstant.hintColor, 10.sp, FontWeight.w400),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 2.h),
                                                  Divider(
                                                    color: ColorConstant.dividerColor,
                                                    height: 0,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  )
                                : const SizedBox();
                          }(),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: ColorConstant.backgroundColor,
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 2.h, bottom: 4.h, left: 4.w),
                    child: textWidget("Swipe left to delete", ColorConstant.hintColor, 12.sp, FontWeight.w400),
                  ),
                ],
              );
            } else {
              return noDataWidget();
            }
          },
        ),
      ),
      floatingActionButton: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          AutoRouter.of(context).push(AddEmployeeDetailsRoute(isEdit: false, empId: 0)).then((value) {
            if (value is bool && value) {
              employeeListCubit.getEmployeeList();
            }
          });
        },
        child: Image.asset(
          ImageConstant.addButton,
          width: 12.w,
        ),
      ),
    );
  }
}

Widget noDataWidget() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const SizedBox(
        width: double.infinity,
      ),
      Image.asset(
        ImageConstant.noDataImage,
        width: 60.w,
      ),
      Padding(
        padding: EdgeInsets.only(top: 0.5.h),
        child: textWidget("No employee records found", ColorConstant.textColor, 12.sp, FontWeight.w500),
      ),
    ],
  );
}
