// Define Controller for rhe app
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/utils/utils.dart';

var drawerProvider = StateNotifierProvider.autoDispose<ScaffoldDrawerController,
    _ScaffoldDrawerState>(
  (ref) => ScaffoldDrawerController(
    _ScaffoldDrawerState(key: GlobalKey<ScaffoldState>()),
  ),
);

// Define StateNotifier for the app
class ScaffoldDrawerController extends StateNotifier<_ScaffoldDrawerState> {
  ScaffoldDrawerController(_ScaffoldDrawerState state) : super(state);

  ScaffoldState? get _scaffold => state.key.currentState;

  bool get drawerOpen =>
      _scaffold != null && (_scaffold!.hasDrawer && _scaffold!.isDrawerOpen);

  bool get drawerClosed =>
      _scaffold != null && (_scaffold!.hasDrawer && !_scaffold!.isDrawerOpen);

  void open() {
    if (_scaffold != null) if (_scaffold!.hasDrawer && !_scaffold!.isDrawerOpen)
      return _scaffold!.openDrawer();
  }

  Future<void> close([BuildContext? context]) async {
    if (_scaffold != null) if (_scaffold!.hasDrawer && _scaffold!.isDrawerOpen)
      context != null
          ? await AutoRouter.of(context).pop()
          : await navigator.pop();
  }
}

class _ScaffoldDrawerState {
  final GlobalKey<ScaffoldState> key;
  final bool isOpen;
  final bool isClosed;

  _ScaffoldDrawerState({
    required this.key,
    this.isOpen = false,
    this.isClosed = true,
  });

  _ScaffoldDrawerState copyWith({
    GlobalKey<ScaffoldState>? key,
    bool? isOpen,
    bool? isClosed,
  }) {
    return _ScaffoldDrawerState(
      key: key ?? this.key,
      isOpen: isOpen ?? this.isOpen,
      isClosed: isClosed ?? this.isClosed,
    );
  }
}
