import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:portfolio/utils/utils.dart';
import 'package:portfolio/widgets/widgets.dart';

/// A stateless widget to render ContactMeScreen.
class ContactMeScreen extends StatelessWidget with AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveWidget(
        builder: (query, config) => Container(
          child: TextButton(
            onPressed: () => context.router.navigate(const AboutMeRoute()),
            child: const Text('Go to About me page'),
          ),
        ),
      ),
    );
  }
}
