library onboarding_controller.dart;

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'onboarding_controller.g.dart';

var onboardingController =
    StateNotifierProvider.autoDispose<OnBoardingController, OnboardingState>(
  (ref) => OnBoardingController(const OnboardingState()),
);

class OnBoardingController extends StateNotifier<OnboardingState> {
  OnBoardingController(OnboardingState state) : super(state);

  bool get isSplashVisible => state.splashVisible;

  bool get isLoading => state.isLoading;

  Future<void> hideSplash([bool? value]) async =>
      state = state.copyWith(splashVisible: value ?? false);
}

@CopyWith(generateCopyWithNull: true)
class OnboardingState {
  const OnboardingState({
    this.isLoading = false,
    this.splashVisible = true,
  });

  final bool splashVisible;
  final bool isLoading;
}
