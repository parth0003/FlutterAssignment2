import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment2/commonWidgets/text_widget.dart';
import 'package:flutter_assignment2/constants/color_constant.dart';
import 'package:flutter_assignment2/constants/image_constant.dart';
import 'package:flutter_assignment2/logic/cubits/addEmployeeCubit/add_employee_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

@RoutePage()
class AddEmployeeDetailsScreen extends StatelessWidget {
  const AddEmployeeDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: textWidget("Add Employee Details", ColorConstant.whiteColor, 14.sp, FontWeight.w500),
          backgroundColor: ColorConstant.primaryColor,
          automaticallyImplyLeading: false),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => AddEmployeeCubit(),
          child: BlocBuilder<AddEmployeeCubit, AddEmployeeState>(
            builder: (context, state) {
              if (state == AddEmployeeState.initial) {
                return addEmployeeForm(context);
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

Widget addEmployeeForm(BuildContext context) {
  return Column(
    children: [
      Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 1.3.h,),
              ///Employee Name
              Container(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.3.h),
                decoration: BoxDecoration(
                    border: Border.all(color: ColorConstant.borderColor, width: 0.3.w), borderRadius: BorderRadius.circular(2.w)),
                child: TextFormField(
                    controller: context.read<AddEmployeeCubit>().employeeNameController,
                    style: TextStyle(
                      color: ColorConstant.textColor,
                      fontFamily: "Roboto",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      height: 1.3,
                      letterSpacing: 0.15,
                    ),
                    decoration: InputDecoration(
                      isCollapsed: true,
                      prefixIcon: SizedBox(
                        width: 5.w,
                        height: 6.h,
                        child: Padding(
                          padding: EdgeInsets.all(2.w),
                          child: Image.asset(ImageConstant.userIcon),
                        ),
                      ),
                      hintText: 'Employee name',
                      border: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      hintStyle: TextStyle(
                        color: ColorConstant.hintColor,
                        fontFamily: "Roboto",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        height: 1.3,
                        letterSpacing: 0.15,
                      ),
                    ),
                    textAlignVertical: TextAlignVertical.center),
              ),
              ///Employee Role
              GestureDetector(
                onTap: () {

                },
                behavior: HitTestBehavior.translucent,
                child: Container(
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.3.h),
                  decoration: BoxDecoration(
                      border: Border.all(color: ColorConstant.borderColor, width: 0.3.w), borderRadius: BorderRadius.circular(2.w)),
                  child: TextFormField(
                      controller: context.read<AddEmployeeCubit>().employeeRoleController,
                      enabled: false,
                      style: TextStyle(
                        color: ColorConstant.textColor,
                        fontFamily: "Roboto",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        height: 1.3,
                        letterSpacing: 0.15,
                      ),
                      decoration: InputDecoration(
                        isCollapsed: true,
                        prefixIcon: SizedBox(
                          width: 5.w,
                          height: 6.h,
                          child: Padding(
                            padding: EdgeInsets.all(2.5.w),
                            child: Image.asset(ImageConstant.roleIcon),
                          ),
                        ),
                        suffixIcon: SizedBox(
                          width: 5.w,
                          height: 6.h,
                          child: Padding(
                            padding: EdgeInsets.all(3.w),
                            child: Image.asset(ImageConstant.downArrowIcon),
                          ),
                        ),
                        hintText: 'Select role',
                        border: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        hintStyle: TextStyle(
                          color: ColorConstant.hintColor,
                          fontFamily: "Roboto",
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          height: 1.3,
                          letterSpacing: 0.15,
                        ),
                      ),
                      textAlignVertical: TextAlignVertical.center),
                ),
              ),
              ///Date Widget
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.3.h),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {

                        },
                        behavior: HitTestBehavior.translucent,
                        child: Container(
                          padding: EdgeInsets.zero,
                          decoration: BoxDecoration(
                              border: Border.all(color: ColorConstant.borderColor, width: 0.3.w), borderRadius: BorderRadius.circular(2.w)),
                          child: TextFormField(
                              controller: context.read<AddEmployeeCubit>().startDateController,
                              enabled: false,
                              style: TextStyle(
                                color: ColorConstant.textColor,
                                fontFamily: "Roboto",
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                height: 1.3,
                                letterSpacing: 0.15,
                              ),
                              decoration: InputDecoration(
                                isCollapsed: true,
                                prefixIcon: SizedBox(
                                  width: 5.w,
                                  height: 6.h,
                                  child: Padding(
                                    padding: EdgeInsets.all(3.7.w),
                                    child: Image.asset(ImageConstant.calendarIcon),
                                  ),
                                ),
                                hintText: 'No date',
                                border: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                hintStyle: TextStyle(
                                  color: ColorConstant.hintColor,
                                  fontFamily: "Roboto",
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  height: 1.3,
                                  letterSpacing: 0.15,
                                ),
                              ),
                              textAlignVertical: TextAlignVertical.center),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      child: Image.asset(ImageConstant.backIcon, width: 6.w,),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {

                        },
                        behavior: HitTestBehavior.translucent,
                        child: Container(
                          padding: EdgeInsets.zero,
                          decoration: BoxDecoration(
                              border: Border.all(color: ColorConstant.borderColor, width: 0.3.w), borderRadius: BorderRadius.circular(2.w)),
                          child: TextFormField(
                              controller: context.read<AddEmployeeCubit>().endDateController,
                              enabled: false,
                              style: TextStyle(
                                color: ColorConstant.textColor,
                                fontFamily: "Roboto",
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                height: 1.3,
                                letterSpacing: 0.15,
                              ),
                              decoration: InputDecoration(
                                isCollapsed: true,
                                prefixIcon: SizedBox(
                                  width: 5.w,
                                  height: 6.h,
                                  child: Padding(
                                    padding: EdgeInsets.all(3.7.w),
                                    child: Image.asset(ImageConstant.calendarIcon),
                                  ),
                                ),
                                hintText: 'No date',
                                border: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                hintStyle: TextStyle(
                                  color: ColorConstant.hintColor,
                                  fontFamily: "Roboto",
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  height: 1.3,
                                  letterSpacing: 0.15,
                                ),
                              ),
                              textAlignVertical: TextAlignVertical.center),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      SizedBox(
        height: 3.h,
      ),
      Divider(
        color: ColorConstant.dividerColor,
        height: 0,
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                AutoRouter.of(context).back();
              },
              behavior: HitTestBehavior.translucent,
              child: Container(
                decoration: BoxDecoration(color: ColorConstant.primaryLightColor, borderRadius: BorderRadius.circular(1.w)),
                padding: EdgeInsets.symmetric(vertical: 1.3.h, horizontal: 4.w),
                child: textWidget("Cancel", ColorConstant.primaryColor, 11.sp, FontWeight.w500, textAlign: TextAlign.center),
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.translucent,
              child: Container(
                decoration: BoxDecoration(color: ColorConstant.primaryColor, borderRadius: BorderRadius.circular(1.w)),
                padding: EdgeInsets.symmetric(vertical: 1.3.h, horizontal: 4.w),
                child: textWidget("Save", ColorConstant.whiteColor, 11.sp, FontWeight.w500, textAlign: TextAlign.center),
              ),
            )
          ],
        ),
      ),
    ],
  );
}
