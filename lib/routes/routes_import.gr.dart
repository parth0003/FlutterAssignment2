// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;
import 'package:flutter_assignment2/screens/add_employee_details_screen.dart'
    as _i1;
import 'package:flutter_assignment2/screens/employee_list_screen.dart' as _i2;

abstract class $AppRouter extends _i3.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    AddEmployeeDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<AddEmployeeDetailsRouteArgs>();
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.AddEmployeeDetailsScreen(
          key: args.key,
          isEdit: args.isEdit,
          empId: args.empId,
        ),
      );
    },
    EmployeeListRoute.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.EmployeeListScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.AddEmployeeDetailsScreen]
class AddEmployeeDetailsRoute
    extends _i3.PageRouteInfo<AddEmployeeDetailsRouteArgs> {
  AddEmployeeDetailsRoute({
    _i4.Key? key,
    required bool isEdit,
    required int empId,
    List<_i3.PageRouteInfo>? children,
  }) : super(
          AddEmployeeDetailsRoute.name,
          args: AddEmployeeDetailsRouteArgs(
            key: key,
            isEdit: isEdit,
            empId: empId,
          ),
          initialChildren: children,
        );

  static const String name = 'AddEmployeeDetailsRoute';

  static const _i3.PageInfo<AddEmployeeDetailsRouteArgs> page =
      _i3.PageInfo<AddEmployeeDetailsRouteArgs>(name);
}

class AddEmployeeDetailsRouteArgs {
  const AddEmployeeDetailsRouteArgs({
    this.key,
    required this.isEdit,
    required this.empId,
  });

  final _i4.Key? key;

  final bool isEdit;

  final int empId;

  @override
  String toString() {
    return 'AddEmployeeDetailsRouteArgs{key: $key, isEdit: $isEdit, empId: $empId}';
  }
}

/// generated route for
/// [_i2.EmployeeListScreen]
class EmployeeListRoute extends _i3.PageRouteInfo<void> {
  const EmployeeListRoute({List<_i3.PageRouteInfo>? children})
      : super(
          EmployeeListRoute.name,
          initialChildren: children,
        );

  static const String name = 'EmployeeListRoute';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
}
