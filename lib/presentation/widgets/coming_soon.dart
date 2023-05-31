import 'package:flutter/material.dart';

class ComingSoonDialog extends StatelessWidget {
  const ComingSoonDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const Dialog(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Text(
          'Ilovaning bu qismi ishlab chiqish jarayonida',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
