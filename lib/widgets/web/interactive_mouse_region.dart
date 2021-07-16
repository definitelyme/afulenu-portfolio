import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InteractiveMouseRegion extends ConsumerWidget {
  final SystemMouseCursor Function(PointerHoverEvent?)? onHover;
  final SystemMouseCursor Function(PointerEnterEvent)? onEnter;
  final SystemMouseCursor Function(PointerExitEvent)? onExit;
  final Widget? child;
  final bool opaque;

  const InteractiveMouseRegion({
    Key? key,
    this.child,
    this.opaque = true,
    this.onHover,
    this.onEnter,
    this.onExit,
  }) : super(key: key);

  @override
  Widget build(context, watch) {
    return MouseRegion(
      cursor: watch(_mouseCursorProvider).cursor,
      opaque: opaque,
      onHover: (e) => context
          .read(_mouseCursorProvider.notifier)
          .changeCursor(onHover?.call(e)),
      onEnter: (e) => context
          .read(_mouseCursorProvider.notifier)
          .changeCursor(onEnter?.call(e)),
      onExit: (e) => context
          .read(_mouseCursorProvider.notifier)
          .changeCursor(onExit?.call(e)),
      child: child,
    );
  }
}

var _mouseCursorProvider =
    StateNotifierProvider.autoDispose<_MouseCursorProvider, _MouseCursorState>(
  (ref) => _MouseCursorProvider(),
);

class _MouseCursorProvider extends StateNotifier<_MouseCursorState> {
  _MouseCursorProvider() : super(const _MouseCursorState());

  SystemMouseCursor get value => state.cursor;

  void changeCursor(SystemMouseCursor? newValue) =>
      state = state.copyWith(cursor: newValue);
}

class _MouseCursorState {
  static const kDefault = SystemMouseCursors.basic;

  final SystemMouseCursor cursor;

  const _MouseCursorState({
    this.cursor = kDefault,
  });

  _MouseCursorState copyWith({
    SystemMouseCursor? cursor,
  }) {
    return _MouseCursorState(
      cursor: cursor ?? this.cursor,
    );
  }
}
