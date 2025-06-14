import 'package:math_blitz/domain/models/Equation.dart';

abstract class ICheckAnswer {
  bool execute(Equation equation, int userAnswer);
}
