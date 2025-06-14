import 'package:math_blitz/domain/models/Equation.dart';
import 'package:math_blitz/core/interfaces/ICheckAnswer.dart';

class CheckAnswer2 implements ICheckAnswer {
  @override
  bool execute(Equation equation, int userAnswer) {
    print('Проверка ответа: ${equation.correctAnswer} == $userAnswer');
    return equation.correctAnswer == userAnswer;
  }
}
