import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/features/home/presentation/managers/index.dart';
import 'package:portfolio/features/home/presentation/screens/export.dart';
import 'package:portfolio/features/home/presentation/widgets/index.dart';
import 'package:portfolio/features/home/presentation/widgets/top_menu_widget.dart';
import 'package:portfolio/utils/utils.dart';
import 'package:portfolio/widgets/widgets.dart';

/// A stateless widget to render HomeRootRouter.
class HomeRootRouter extends StatelessWidget with AutoRouteWrapper {
  const HomeRootRouter({Key? key}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) => this;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(
        env.splashDuration,
        () => context.read(onboardingController.notifier).hideSplash(),
      ),
      builder: (context, snapshot) {
        return Consumer(
          builder: (context, watch, child) => AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeInCubic,
            child: watch(onboardingController.notifier).isSplashVisible
                ? const SplashScreen()
                : const _RootViewBuilder(),
          ),
        );
      },
    );
  }
}

class _RootViewBuilder extends ConsumerWidget {
  const _RootViewBuilder({Key? key}) : super(key: key);

  @override
  Widget build(context, watch) {
    final top = 0.03.sh;

    return Scaffold(
      key: watch(drawerProvider).key,
      drawer: const SideMenuWidget(),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: top,
            child: const SizedBox.shrink(),
          ),
          //
          Positioned(
            top: top,
            left: 0,
            right: 0,
            height: kToolbarHeight,
            child: const TopMenuWidget(),
          ),
          //
          Positioned.fill(
            top: top + kToolbarHeight,
            child: ResponsiveWidget(
              builder: (query, _) => const AutoRouter(),
            ),
          ),
        ],
      ),
    );
  }
}
