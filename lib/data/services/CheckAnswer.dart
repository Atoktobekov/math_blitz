import 'package:math_blitz/domain/models/Equation.dart';
import 'package:math_blitz/core/interfaces/ICheckAnswer.dart';

class CheckAnswer implements ICheckAnswer {
  @override
  bool execute(Equation equation, int userAnswer) {
    return equation.correctAnswer == userAnswer;
  }
}
