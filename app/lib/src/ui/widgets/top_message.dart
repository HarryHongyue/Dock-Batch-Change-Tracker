import 'package:flutter/material.dart';

class TopMessage {
  static OverlayEntry? _current;

  static void show(BuildContext context, String text, {bool error = false}) {
    hide();

    final overlay = Overlay.of(context, rootOverlay: true);
    _current = OverlayEntry(
      builder: (context) => _MessageOverlay(text: text, error: error),
    );
    overlay.insert(_current!);

    Future.delayed(const Duration(seconds: 2), hide);
  }

  static void hide() {
    _current?.remove();
    _current = null;
  }
}

class _MessageOverlay extends StatelessWidget {
  final String text;
  final bool error;

  const _MessageOverlay({required this.text, required this.error});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final background = error ? colorScheme.error : colorScheme.primary;
    final foreground = error ? colorScheme.onError : colorScheme.onPrimary;

    return SafeArea(
      child: IgnorePointer(
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 12, left: 16, right: 16),
            child: Material(
              color: background,
              borderRadius: BorderRadius.circular(16),
              elevation: 6,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                child: Text(
                  text,
                  style: TextStyle(
                    color: foreground,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
