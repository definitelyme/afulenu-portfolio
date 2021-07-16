// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;
import 'package:portfolio/features/home/presentation/pages/export.dart' as _i5;
import 'package:portfolio/features/home/presentation/roots/home_root_router.dart'
    as _i3;
import 'package:portfolio/features/home/presentation/screens/export.dart'
    as _i4;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    HomeRootRouter.name: (routeData) => _i1.AdaptivePage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i3.HomeRootRouter();
        }),
    HomeRoute.name: (routeData) => _i1.AdaptivePage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i4.HomeScreen();
        }),
    PortfolioRoute.name: (routeData) => _i1.AdaptivePage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i5.PortfolioScreen();
        }),
    ResumeRoute.name: (routeData) => _i1.AdaptivePage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i5.ResumeScreen();
        }),
    ContactMeRoute.name: (routeData) => _i1.AdaptivePage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i5.ContactMeScreen();
        }),
    AboutMeRoute.name: (routeData) => _i1.AdaptivePage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i5.AboutMeScreen();
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(HomeRootRouter.name, path: '/', children: [
          _i1.RouteConfig(HomeRoute.name, path: '', fullMatch: true),
          _i1.RouteConfig(PortfolioRoute.name,
              path: 'portfolio', fullMatch: true),
          _i1.RouteConfig(ResumeRoute.name, path: 'my-resume', fullMatch: true),
          _i1.RouteConfig(ContactMeRoute.name,
              path: 'talk-to-me', fullMatch: true),
          _i1.RouteConfig(AboutMeRoute.name, path: 'summary', fullMatch: true),
          _i1.RouteConfig('*#redirect',
              path: '*', redirectTo: '', fullMatch: true)
        ]),
        _i1.RouteConfig('*#redirect',
            path: '*', redirectTo: '/', fullMatch: true)
      ];
}

class HomeRootRouter extends _i1.PageRouteInfo {
  const HomeRootRouter({List<_i1.PageRouteInfo>? children})
      : super(name, path: '/', initialChildren: children);

  static const String name = 'HomeRootRouter';
}

class HomeRoute extends _i1.PageRouteInfo {
  const HomeRoute() : super(name, path: '');

  static const String name = 'HomeRoute';
}

class PortfolioRoute extends _i1.PageRouteInfo {
  const PortfolioRoute() : super(name, path: 'portfolio');

  static const String name = 'PortfolioRoute';
}

class ResumeRoute extends _i1.PageRouteInfo {
  const ResumeRoute() : super(name, path: 'my-resume');

  static const String name = 'ResumeRoute';
}

class ContactMeRoute extends _i1.PageRouteInfo {
  const ContactMeRoute() : super(name, path: 'talk-to-me');

  static const String name = 'ContactMeRoute';
}

class AboutMeRoute extends _i1.PageRouteInfo {
  const AboutMeRoute() : super(name, path: 'summary');

  static const String name = 'AboutMeRoute';
}
