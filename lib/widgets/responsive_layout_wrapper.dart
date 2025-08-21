import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ResponsiveLayoutWrapper extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  final double maxHeight;
  final EdgeInsets padding;

  const ResponsiveLayoutWrapper({
    super.key,
    required this.child,
    this.maxWidth = 400, // Default to 400 for mobile-like experience
    this.maxHeight = 800,
    this.padding = const EdgeInsets.all(16.0),
  });

  @override
  Widget build(BuildContext context) {
    // Only apply constraints on web platform
    if (!kIsWeb) {
      return child;
    }

    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: maxWidth,
          maxHeight: maxHeight,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: child,
          ),
        ),
      ),
    );
  }
}
