import 'dart:async';
import 'dart:math';
//import 'dart:nativewrappers/_internal/vm/lib/math_patch.dart';
import 'package:flutter/foundation.dart';
import 'package:math_blitz/domain/models/Equation.dart';
import 'package:math_blitz/data/services/EquationGenerator.dart';
import 'package:math_blitz/data/services/CheckAnswer.dart';

class GameViewModel extends ChangeNotifier {
  final EquationGenerator _equationGenerator = EquationGenerator();
  final CheckAnswer _checkAnswer = CheckAnswer();
  final rand = Random();

  bool hasStarted = false;
  int score = 0;
  int points = 0;
  Equation? currentEquation;
  List<int> options = [];
  Timer? _timer;

  static const int maxTimeSeconds = 7;
  double timeLeftPercent = 1.0;
  bool isGameOver = false;

  GameViewModel() {}

  void generateNewEquation() {
    _timer?.cancel();
    isGameOver = false;
    timeLeftPercent = 1.0;

    currentEquation = _equationGenerator.generate(score);
    options = [1, 2, 3];

    _startTimer();
    notifyListeners();
  }
  void startGame() {
    points = 0;
    score = 0;
    hasStarted = true;
    generateNewEquation(); // generating new Equation
    notifyListeners();
  }


  void _startTimer() {
    const tick = Duration(milliseconds: 100);
    final totalTicks = maxTimeSeconds * 1000 ~/ tick.inMilliseconds;
    int elapsedTicks = 0;

    _timer = Timer.periodic(tick, (timer) {
      elapsedTicks++;
      timeLeftPercent = 1 - (elapsedTicks / totalTicks);

      if (timeLeftPercent <= 0) {
        timeLeftPercent = 0;
        timer.cancel();
        _handleGameOver();
      }

      notifyListeners();
    });
  }

  void answerSelected(int selected) {
    if (currentEquation == null || isGameOver) return;

    _timer?.cancel();
    bool correct = _checkAnswer.execute(currentEquation!, selected);

    if (correct) {
      score++;
      points+= 1 * score * (rand.nextInt(score+1) +1);
      generateNewEquation();
    } else {
      _handleGameOver();
    }
  }

  void _handleGameOver() {
    isGameOver = true;
    notifyListeners();
  }

  void resetGame() {
    _timer?.cancel();
    points = 0;
    score = 0;
    generateNewEquation();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
