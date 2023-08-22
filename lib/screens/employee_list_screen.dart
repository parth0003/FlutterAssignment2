import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment2/commonWidgets/text_widget.dart';
import 'package:flutter_assignment2/constants/color_constant.dart';
import 'package:flutter_assignment2/constants/image_constant.dart';
import 'package:flutter_assignment2/logic/cubits/employeeListCubit/employee_list_cubit.dart';
import 'package:flutter_assignment2/routes/routes_import.gr.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

@RoutePage()
class EmployeeListScreen extends StatelessWidget {
  const EmployeeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: textWidget("Employee List", ColorConstant.whiteColor, 14.sp, FontWeight.w500),
        backgroundColor: ColorConstant.primaryColor,
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => EmployeeListCubit(),
          child: BlocBuilder<EmployeeListCubit, EmployeeListState>(
            builder: (context, state) {
              if (state is HasEmployeeDataState) {
                return Center(
                  child: Text("Has Data"),
                );
              } else {
                return noDataWidget();
              }
            },
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          // AutoRouter.of(context).push(const AddEmployeeDetailsRoute());

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
