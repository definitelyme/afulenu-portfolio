import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/cupertino.dart' hide Router;
import 'package:flutter/material.dart' hide Router;
import 'package:flutter_bloc/flutter_bloc.dart' hide ReadContext;
import 'package:flutter_portal/flutter_portal.dart';
import 'package:portfolio/manager/locator/locator.dart';
import 'package:portfolio/manager/theme/theme.dart';
import 'package:portfolio/utils/utils.dart';
import 'package:portfolio/widgets/widgets.dart';

/// Application Router
final AppRouter _router = AppRouter();

class Portfolio extends StatelessWidget {
  /// This is the entry point for portfolio App
  const Portfolio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(create: (_) => getIt<ThemeCubit>()),
      ],
      child: BlocBuilder<ThemeCubit, AppTheme>(
        builder: (context, app) => Portal(
          child: PlatformBuilder(
            cupertino: (context) => CupertinoApp.router(
              title: AppStrings.appName.capitalizeFirst(),
              debugShowCheckedModeBanner: false,
              theme: app.cupertinoThemeData(),
              color: Colors.deepPurpleAccent,
              routeInformationParser:
                  _router.defaultRouteParser(includePrefixMatches: true),
              routerDelegate: _router.delegate(
                navigatorObservers: () => <NavigatorObserver>[
                  // if (env.flavor == BuildFlavor.prod)
                  FirebaseAnalyticsObserver(
                    analytics: getIt<FirebaseAnalytics>(),
                  ),
                ],
              ),
              builder: (context, child) => Helpers.setup(
                context,
                _router,
                ScreenUtilInit(
                  designSize: QueryContext(
                    context: context,
                    desktop: true,
                    tablet: true,
                  ).breakpoint(context),
                  builder: () => child!,
                ),
              ),
            ),
            material: (context) => MaterialApp.router(
              title: AppStrings.appName.capitalizeFirst(),
              debugShowCheckedModeBanner: false,
              theme: app.themeData(),
              darkTheme: AppTheme.dark().themeData(),
              routeInformationParser:
                  _router.defaultRouteParser(includePrefixMatches: true),
              routerDelegate: _router.delegate(
                navigatorObservers: () => <NavigatorObserver>[
                  // if (env.flavor == BuildFlavor.prod)
                  FirebaseAnalyticsObserver(
                    analytics: getIt<FirebaseAnalytics>(),
                  ),
                ],
              ),
              builder: (context, child) => Helpers.setup(
                context,
                _router,
                ScreenUtilInit(
                  designSize: QueryContext(
                    context: context,
                    desktop: true,
                    tablet: true,
                  ).breakpoint(context),
                  builder: () => child!,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
