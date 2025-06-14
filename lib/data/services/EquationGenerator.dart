import 'dart:math';
import 'package:math_blitz/domain/models/Equation.dart';
import 'package:math_blitz/core/interfaces/IEquationGenerator.dart';



class EquationGenerator implements IEquationGenerator {
  final Random _random = Random();
  int? _lastResult;

  @override
  Equation generate(int correctAnswers) {
    int targetAnswer;

    // Generate new answer
    do {
      targetAnswer = _random.nextInt(3) + 1;
    } while (targetAnswer == _lastResult);

    _lastResult = targetAnswer;

    String expression = '';
    int evaluated = -999;

    //Generate new Equation
    while (evaluated != targetAnswer) {
      final buffer = StringBuffer();
      int currentResult = 0;

      int length = 2 + (correctAnswers ~/ 5); //expression lengthens by 1 every 5 right answers
      for (int i = 0; i < length; i++) {
        int num = _random.nextInt(3) + 1;
        String operator = _random.nextBool() ? '+' : '-';

        if (i == 0) {
          buffer.write('$num');
          currentResult = num;
        } else {
          buffer.write(' $operator $num');
          currentResult += (operator == '+') ? num : -num;
        }
      }

      expression = buffer.toString();
      evaluated = currentResult;
    }

    return Equation(expression: expression, correctAnswer: targetAnswer);
  }
}
