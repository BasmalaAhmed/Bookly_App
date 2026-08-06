import 'package:flutter/material.dart';

class DraggableHandle extends StatelessWidget {
  const DraggableHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
                    width: 48,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  );
  }
}