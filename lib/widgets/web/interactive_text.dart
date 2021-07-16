import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// A stateless widget to render InteractiveText.
class InteractiveText extends StatefulWidget {
  final String text;

  const InteractiveText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  _InteractiveTextState createState() => _InteractiveTextState();
}

class _InteractiveTextState extends State<InteractiveText> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) => _hovered(true),
      onExit: (event) => _hovered(false),
      child: const Text('Sample text'),
    );
  }

  void _hovered(bool isHovered) => setState(() => _hovering = isHovered);
}
