import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:portfolio/utils/utils.dart';
import 'package:portfolio/widgets/widgets.dart';

/// A stateless widget to render SplashScreen.
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      body: Stack(
        children: [
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Align(
              alignment: Alignment.center,
              child: FlutterLogo(
                style: FlutterLogoStyle.horizontal,
                curve: Curves.easeInOut,
                size: 200,
                duration: Duration(milliseconds: 1400),
              ),
            ),
          ),
          //
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: App.height * 0.05,
            child: SpinKitWave(
              color: Theme.of(context).accentColor,
              size: 30.0,
              duration: const Duration(milliseconds: 1200),
              type: SpinKitWaveType.center,
              itemCount: 7,
            ),
          ),
        ],
      ),
    );
  }
}
