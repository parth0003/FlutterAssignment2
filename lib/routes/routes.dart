part of 'routes_import.dart';

@AutoRouterConfig(replaceInRouteName: "Screen,Route")
class AppRouter extends $AppRouter {

  @override
  RouteType get defaultRouteType => Platform.isAndroid? const RouteType.material() : const RouteType.cupertino();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: EmployeeListRoute.page, path: "/"),
    AutoRoute(page: AddEmployeeDetailsRoute.page, path: "/addEmployeeDetailsRoute")
  ];
}