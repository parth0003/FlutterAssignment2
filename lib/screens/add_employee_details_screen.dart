import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment2/commonWidgets/customCalender/classes/event.dart';
import 'package:flutter_assignment2/commonWidgets/customCalender/flutter_calendar_carousel.dart';
import 'package:flutter_assignment2/commonWidgets/text_widget.dart';
import 'package:flutter_assignment2/constants/color_constant.dart';
import 'package:flutter_assignment2/constants/image_constant.dart';
import 'package:flutter_assignment2/logic/cubits/addEmployeeCubit/add_employee_cubit.dart';
import 'package:flutter_assignment2/logic/cubits/addEmployeeCubit/add_employee_state.dart';
import 'package:flutter_assignment2/logic/cubits/datePickerCubit/date_picker_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

@RoutePage()
class AddEmployeeDetailsScreen extends StatelessWidget {
  final bool isEdit;
  final int empId;

  const AddEmployeeDetailsScreen({super.key, required this.isEdit, required this.empId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddEmployeeCubit(),
      child: AddEmployeeForm(isEdit: isEdit, empId: empId),
    );
  }
}

class AddEmployeeForm extends StatelessWidget {
  final bool isEdit;
  final int empId;
  const AddEmployeeForm({super.key, required this.isEdit, required this.empId});

  @override
  Widget build(BuildContext context) {
    var addEmployeeCubit = BlocProvider.of<AddEmployeeCubit>(context);
    if(isEdit){
      addEmployeeCubit.getEmployeeFromId(empId);
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: textWidget((isEdit) ? "Edit Employee Details" : "Add Employee Details", ColorConstant.whiteColor, 14.sp, FontWeight.w500),
        backgroundColor: ColorConstant.primaryColor,
        automaticallyImplyLeading: false,
        actions: [
          if (isEdit)
            GestureDetector(
              onTap: () {
                addEmployeeCubit.deleteEmployee(context, empId);
              },
              behavior: HitTestBehavior.translucent,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: SizedBox(
                  width: 6.w,
                  height: 6.w,
                  child: Image.asset(
                    ImageConstant.deleteIcon,
                  ),
                ),
              ),
            )
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<AddEmployeeCubit, AddEmployeeState>(
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 1.3.h,
                        ),

                        ///Employee Name
                        Container(
                          padding: EdgeInsets.zero,
                          margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.3.h),
                          decoration:
                          BoxDecoration(border: Border.all(color: ColorConstant.borderColor, width: 0.3.w), borderRadius: BorderRadius.circular(2.w)),
                          child: TextFormField(
                              controller: addEmployeeCubit.employeeNameController,
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
                            selectEmployeeRole(context, addEmployeeCubit);
                          },
                          behavior: HitTestBehavior.translucent,
                          child: Container(
                            padding: EdgeInsets.zero,
                            margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.3.h),
                            decoration: BoxDecoration(
                                border: Border.all(color: ColorConstant.borderColor, width: 0.3.w), borderRadius: BorderRadius.circular(2.w)),
                            child: TextFormField(
                                controller: TextEditingController(text: state.employeeRole),
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
                                    openDatePicker(context, addEmployeeCubit, state.startDate ?? DateTime.now(), state.endDate);
                                  },
                                  behavior: HitTestBehavior.translucent,
                                  child: Container(
                                    padding: EdgeInsets.zero,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: ColorConstant.borderColor, width: 0.3.w), borderRadius: BorderRadius.circular(2.w)),
                                    child: TextFormField(
                                        controller: TextEditingController(text: DateFormat("d MMM yyyy").format(state.startDate ?? DateTime.now())),
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
                                child: Image.asset(
                                  ImageConstant.backIcon,
                                  width: 6.w,
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    openDatePicker(context, addEmployeeCubit, state.startDate ?? DateTime.now(), state.endDate, isStartDate: false);
                                  },
                                  behavior: HitTestBehavior.translucent,
                                  child: Container(
                                    padding: EdgeInsets.zero,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: ColorConstant.borderColor, width: 0.3.w), borderRadius: BorderRadius.circular(2.w)),
                                    child: TextFormField(
                                        controller: TextEditingController(
                                            text: (state.endDate == null) ? "No Date" : DateFormat("d MMM yyyy").format(state.endDate ?? DateTime.now())),
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
                        onTap: () {
                          if ((state.employeeName ?? "").trim().isEmpty) {
                            Fluttertoast.showToast(
                              msg: "Please enter employee name",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                            );
                          } else if ((state.employeeRole ?? "").trim().isEmpty) {
                            Fluttertoast.showToast(
                              msg: "Please select employee role",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                            );
                          } else {
                            addEmployeeCubit.saveEmployeeDetails(context);
                          }
                        },
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
          },
        ),
      ),
    );
  }
}

selectEmployeeRole(BuildContext context, AddEmployeeCubit addEmployeeCubit) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        width: double.infinity,
        height: 30.h,
        decoration: BoxDecoration(
          color: ColorConstant.whiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(3.w),
            topRight: Radius.circular(3.w),
          ),
        ),
        child: Column(
          children: [
            ListTile(
              title: Center(
                child: textWidget("Product Designer", ColorConstant.textColor, 12.sp, FontWeight.w400),
              ),
              onTap: () {
                addEmployeeCubit.updateRole("Product Designer");
                AutoRouter.of(context).pop();
              },
            ),
            Divider(
              color: ColorConstant.dividerColor,
              height: 0,
            ),
            ListTile(
              title: Center(
                child: textWidget("Flutter Developer", ColorConstant.textColor, 12.sp, FontWeight.w400),
              ),
              onTap: () {
                addEmployeeCubit.updateRole("Flutter Developer");
                AutoRouter.of(context).pop();
              },
            ),
            Divider(
              color: ColorConstant.dividerColor,
              height: 0,
            ),
            ListTile(
              title: Center(
                child: textWidget("QA Tester", ColorConstant.textColor, 12.sp, FontWeight.w400),
              ),
              onTap: () {
                addEmployeeCubit.updateRole("QA Tester");
                AutoRouter.of(context).pop();
              },
            ),
            Divider(
              color: ColorConstant.dividerColor,
              height: 0,
            ),
            ListTile(
              title: Center(
                child: textWidget("Product Owner", ColorConstant.textColor, 12.sp, FontWeight.w400),
              ),
              onTap: () {
                addEmployeeCubit.updateRole("Product Owner");
                AutoRouter.of(context).pop();
              },
            ),
          ],
        ),
      );
    },
  );
}

void openDatePicker(BuildContext context, AddEmployeeCubit addEmployeeCubit, DateTime? startDate, DateTime? endDate, {bool isStartDate = true}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: const Color.fromRGBO(0, 0, 0, 0.3),
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: ColorConstant.whiteColor,
        insetPadding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Wrap(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(color: ColorConstant.whiteColor, borderRadius: BorderRadius.circular(3.w)),
              child: BlocProvider(
                create: (context) => DatePickerCubit(),
                child: BlocBuilder<DatePickerCubit, DatePickerState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        if (isStartDate)
                          Padding(
                            padding: EdgeInsets.only(top: 2.5.h),
                            child: Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      context.read<DatePickerCubit>().selectToday();
                                    },
                                    behavior: HitTestBehavior.translucent,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: (state == DatePickerState.today) ? ColorConstant.primaryColor : ColorConstant.primaryLightColor,
                                          borderRadius: BorderRadius.circular(1.w)),
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(vertical: 1.5.h),
                                      margin: EdgeInsets.only(left: 4.w, right: 2.w),
                                      child: textWidget(
                                          "Today",
                                          (state == DatePickerState.today) ? ColorConstant.whiteColor : ColorConstant.primaryColor,
                                          11.sp,
                                          FontWeight.w400,
                                          textAlign: TextAlign.center),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      context.read<DatePickerCubit>().selectNextMonday();
                                    },
                                    behavior: HitTestBehavior.translucent,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: (state == DatePickerState.nextMonday) ? ColorConstant.primaryColor : ColorConstant.primaryLightColor,
                                          borderRadius: BorderRadius.circular(1.w)),
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(vertical: 1.5.h),
                                      margin: EdgeInsets.only(left: 2.w, right: 4.w),
                                      child: textWidget(
                                          "Next Monday",
                                          (state == DatePickerState.nextMonday) ? ColorConstant.whiteColor : ColorConstant.primaryColor,
                                          11.sp,
                                          FontWeight.w400,
                                          textAlign: TextAlign.center),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (isStartDate)
                          Padding(
                            padding: EdgeInsets.only(top: 2.h),
                            child: Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      context.read<DatePickerCubit>().selectNextTuesday();
                                    },
                                    behavior: HitTestBehavior.translucent,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color:
                                              (state == DatePickerState.nextTuesday) ? ColorConstant.primaryColor : ColorConstant.primaryLightColor,
                                          borderRadius: BorderRadius.circular(1.w)),
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(vertical: 1.5.h),
                                      margin: EdgeInsets.only(left: 4.w, right: 2.w),
                                      child: textWidget(
                                          "Next Tuesday",
                                          (state == DatePickerState.nextTuesday) ? ColorConstant.whiteColor : ColorConstant.primaryColor,
                                          11.sp,
                                          FontWeight.w400,
                                          textAlign: TextAlign.center),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      context.read<DatePickerCubit>().selectAfterWeek();
                                    },
                                    behavior: HitTestBehavior.translucent,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: (state == DatePickerState.afterWeek) ? ColorConstant.primaryColor : ColorConstant.primaryLightColor,
                                          borderRadius: BorderRadius.circular(1.w)),
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(vertical: 1.5.h),
                                      margin: EdgeInsets.only(left: 2.w, right: 4.w),
                                      child: textWidget(
                                          "After 1 week",
                                          (state == DatePickerState.afterWeek) ? ColorConstant.whiteColor : ColorConstant.primaryColor,
                                          11.sp,
                                          FontWeight.w400,
                                          textAlign: TextAlign.center),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (!isStartDate)
                          Padding(
                            padding: EdgeInsets.only(top: 2.h),
                            child: Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      context.read<DatePickerCubit>().selectNoDate();
                                    },
                                    behavior: HitTestBehavior.translucent,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: (state == DatePickerState.noDate) ? ColorConstant.primaryColor : ColorConstant.primaryLightColor,
                                          borderRadius: BorderRadius.circular(1.w)),
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(vertical: 1.5.h),
                                      margin: EdgeInsets.only(left: 4.w, right: 2.w),
                                      child: textWidget(
                                          "No Date",
                                          (state == DatePickerState.noDate) ? ColorConstant.whiteColor : ColorConstant.primaryColor,
                                          11.sp,
                                          FontWeight.w400,
                                          textAlign: TextAlign.center),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      context.read<DatePickerCubit>().selectToday();
                                    },
                                    behavior: HitTestBehavior.translucent,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: (state == DatePickerState.today) ? ColorConstant.primaryColor : ColorConstant.primaryLightColor,
                                          borderRadius: BorderRadius.circular(1.w)),
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(vertical: 1.5.h),
                                      margin: EdgeInsets.only(left: 2.w, right: 4.w),
                                      child: textWidget(
                                          "Today",
                                          (state == DatePickerState.today) ? ColorConstant.whiteColor : ColorConstant.primaryColor,
                                          11.sp,
                                          FontWeight.w400,
                                          textAlign: TextAlign.center),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                          child: CalendarCarousel<Event>(
                            onDayPressed: (DateTime date, List<Event> events) {
                              context.read<DatePickerCubit>().selectedDate = date;
                              context.read<DatePickerCubit>().onDateChange();
                            },
                            weekendTextStyle: TextStyle(
                              color: ColorConstant.textColor,
                            ),
                            weekdayTextStyle: TextStyle(color: ColorConstant.textColor),
                            headerTextStyle: TextStyle(
                                color: ColorConstant.textColor,
                                fontSize: 13.sp,
                                fontFamily: 'Roboto',
                                height: 1.0,
                                letterSpacing: 0.15,
                                fontWeight: FontWeight.w500),
                            todayButtonColor: ColorConstant.whiteColor,
                            todayBorderColor: ColorConstant.primaryColor,
                            todayTextStyle: TextStyle(
                              color: ColorConstant.primaryColor,
                            ),
                            dayPadding: 2.w,
                            selectedDayTextStyle: TextStyle(
                              color: ColorConstant.whiteColor,
                            ),
                            firstDayOfWeek: 0,
                            selectedDayBorderColor: ColorConstant.primaryColor,
                            selectedDayButtonColor: ColorConstant.primaryColor,
                            selectedDateTime: context.read<DatePickerCubit>().selectedDate,
                            weekFormat: false,
                            height: 40.h,
                            daysHaveCircularBorder: true,
                            leftButtonIcon: Image.asset(ImageConstant.leftIcon, width: 8.w),
                            rightButtonIcon: RotatedBox(
                              quarterTurns: 2,
                              child: Image.asset(ImageConstant.leftIcon, width: 8.w),
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
                            children: [
                              Image.asset(
                                ImageConstant.calendarIcon,
                                width: 4.w,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 2.w),
                                child: textWidget(DateFormat.yMMMd().format(context.read<DatePickerCubit>().selectedDate), ColorConstant.textColor,
                                    11.sp, FontWeight.w400),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  AutoRouter.of(context).pop();
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
                                onTap: () {
                                  if (isStartDate) {
                                    if (endDate != null && context.read<DatePickerCubit>().selectedDate.isAfter(endDate)) {
                                      Fluttertoast.showToast(
                                        msg: "Please select a joining date before termination date",
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                      );
                                    } else {
                                      addEmployeeCubit.updateStartDate(context.read<DatePickerCubit>().selectedDate);
                                      AutoRouter.of(context).pop();
                                    }
                                  } else {
                                    if (startDate != null &&
                                        (state != DatePickerState.noDate) &&
                                        context.read<DatePickerCubit>().selectedDate.isBefore(startDate)) {
                                      Fluttertoast.showToast(
                                        msg: "Please select a termination date after joining date",
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                      );
                                    } else {
                                      if (state != DatePickerState.noDate) {
                                        addEmployeeCubit.updateEndDate(context.read<DatePickerCubit>().selectedDate);
                                      } else {
                                        addEmployeeCubit.updateEndDate(null);
                                      }
                                      AutoRouter.of(context).pop();
                                    }
                                  }
                                },
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
                  },
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
