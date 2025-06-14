import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  final int answer;
  final double fillPercent; // от 0.0 до 1.0
  final VoidCallback onPressed;

  const AnswerButton({
    required this.answer,
    required this.fillPercent,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final baseColor = Colors.blue;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 60,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: baseColor),
          color: Colors.grey[200],
        ),
        child: Stack(
          children: [
            FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: fillPercent.clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  color: baseColor,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            Center(
              child: Text(
                answer.toString(),
                style: TextStyle(
                  fontSize: 24,
                  color: fillPercent > 0.3 ? Colors.white : baseColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }
}
