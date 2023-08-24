import 'package:flutter_bloc/flutter_bloc.dart';

enum DatePickerState { today, nextMonday, nextTuesday, afterWeek, noDate, custom, dateChange }

class DatePickerCubit extends Cubit<DatePickerState> {
  DatePickerCubit() : super(DatePickerState.today);

  DateTime selectedDate = DateTime.now();

  @override
  void onChange(Change<DatePickerState> change) {
    switch (change.nextState) {
      case DatePickerState.today:
        selectedDate = DateTime.now();
        break;

      case DatePickerState.nextMonday:
        DateTime nextMonday = DateTime.now().add(const Duration(days: 1));
        while (nextMonday.weekday != DateTime.monday) {
          nextMonday = nextMonday.add(const Duration(days: 1));
        }
        selectedDate = nextMonday;
        break;

      case DatePickerState.nextTuesday:
        DateTime nextTuesday = DateTime.now().add(const Duration(days: 1));
        while (nextTuesday.weekday != DateTime.tuesday) {
          nextTuesday = nextTuesday.add(const Duration(days: 1));
        }
        selectedDate = nextTuesday;
        break;

      case DatePickerState.afterWeek:
        selectedDate = DateTime.now().add(const Duration(days: 7));
        break;

      case DatePickerState.noDate:
        break;

      case DatePickerState.custom:
        break;

      case DatePickerState.dateChange:
        break;
    }
    super.onChange(change);
  }

  void selectToday() => emit(DatePickerState.today);

  void selectNoDate() => emit(DatePickerState.noDate);

  void selectNextMonday() => emit(DatePickerState.nextMonday);

  void selectNextTuesday() => emit(DatePickerState.nextTuesday);

  void selectAfterWeek() => emit(DatePickerState.afterWeek);

  void onDateChange() {
    emit(DatePickerState.dateChange);
    emit(DatePickerState.custom);
  }
}
