import 'package:math_blitz/domain/models/Equation.dart';

abstract class IEquationGenerator {
  Equation generate(int correctAnswers);
}
