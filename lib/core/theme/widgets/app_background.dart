import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  const AppBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        gradient: isDark
            ? const RadialGradient(
                center: Alignment(-0.8, -0.9),
                radius: 1.5,
                colors: [
                  Color(0xFF150526),
                  Color(0xFF1C0733),
                  Color(0xFF150526),
                ],
              )
            : const RadialGradient(
                center: Alignment(-0.8, -0.9),
                radius: 1.4,
                colors: [
                  Color(0XFFFFFFFF),
                  Color(0xFFF5EFFB),
                  Color(0xFFE8DCF5),
                ],
              ),
      ),
      child: child,
    );
  }
}
