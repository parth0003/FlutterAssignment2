import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment2/commonWidgets/customCalender/classes/event.dart';
import 'package:flutter_assignment2/commonWidgets/customCalender/flutter_calendar_carousel.dart';
import 'package:flutter_assignment2/commonWidgets/text_widget.dart';
import 'package:flutter_assignment2/constants/color_constant.dart';
import 'package:flutter_assignment2/constants/image_constant.dart';
import 'package:flutter_assignment2/logic/cubits/datePickerCubit/date_picker_cubit.dart';
import 'package:flutter_assignment2/logic/cubits/employeeListCubit/employee_list_cubit.dart';
import 'package:flutter_assignment2/routes/routes_import.gr.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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
          AutoRouter.of(context).push(const AddEmployeeDetailsRoute());
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

void openDatePicker(BuildContext context) {
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
                        Padding(
                          padding: EdgeInsets.only(top: 2.5.h, bottom: 2.h),
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
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  context.read<DatePickerCubit>().selectNextTuesday();
                                },
                                behavior: HitTestBehavior.translucent,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: (state == DatePickerState.nextTuesday) ? ColorConstant.primaryColor : ColorConstant.primaryLightColor,
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
                        SizedBox(height: 3.h,),
                        Divider(color: ColorConstant.dividerColor, height: 0,),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                          child: Row(
                            children: [
                              Image.asset(ImageConstant.calendarIcon, width: 4.w,),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 2.w),
                                child: textWidget(DateFormat.yMMMd().format(context.read<DatePickerCubit>().selectedDate), ColorConstant.textColor, 11.sp, FontWeight.w400),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  AutoRouter.of(context).pop();
                                },
                                behavior: HitTestBehavior.translucent,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: ColorConstant.primaryLightColor,
                                      borderRadius: BorderRadius.circular(1.w)),
                                  padding: EdgeInsets.symmetric(vertical: 1.3.h, horizontal: 4.w),
                                  child: textWidget(
                                      "Cancel",
                                      ColorConstant.primaryColor,
                                      11.sp,
                                      FontWeight.w500,
                                      textAlign: TextAlign.center),
                                ),
                              ),
                              SizedBox(width: 2.w,),
                              GestureDetector(
                                onTap: () {
                                  AutoRouter.of(context).pop();
                                },
                                behavior: HitTestBehavior.translucent,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: ColorConstant.primaryColor,
                                      borderRadius: BorderRadius.circular(1.w)),
                                  padding: EdgeInsets.symmetric(vertical: 1.3.h, horizontal: 4.w),
                                  child: textWidget(
                                      "Save",
                                      ColorConstant.whiteColor,
                                      11.sp,
                                      FontWeight.w500,
                                      textAlign: TextAlign.center),
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
