import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:portfolio/features/home/presentation/widgets/index.dart';
import 'package:portfolio/widgets/widgets.dart';
import 'package:portfolio/utils/utils.dart';

/// A stateless widget to render HomeScreen.
class HomeScreen extends StatelessWidget with AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveWidget(
        builder: (query, config) => SingleChildScrollView(
          controller: ScrollController(),
          physics: Helpers.physics,
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.symmetric(
            horizontal: query.fold(
              isMobile: 0.04.sw,
              isTablet: 0.05.sw,
              orElse: 0.04.sw,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeScreenFullHeight(),
              //
              AutoSizeText.selectable(
                'What I Do',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              //
              VerticalSpace(height: 0.35.sh),
            ],
          ),
        ),
      ),
    );
  }
}
