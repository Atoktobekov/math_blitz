import 'package:flutter/material.dart';
import 'package:math_blitz/presentation/widgets/PauseOverlay.dart';
import 'package:provider/provider.dart';
import 'package:math_blitz/presentation/viewmodels/game_view_model.dart';
import 'package:math_blitz/presentation/widgets/answerButton.dart';

class GameScreen extends StatefulWidget {
  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool _hasStartedAutomatically = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GameViewModel>(
      create: (_) => GameViewModel(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Math Blitz',
            style: TextStyle(
              color: Colors.black,
              fontSize: 28,
              fontWeight: FontWeight.w400,
            ),
          ),
          actions: [
            Consumer<GameViewModel>(
              builder: (context, vm, _) => IconButton(
                icon: const Icon(Icons.pause, color: Colors.black, size: 35),
                onPressed: () {
                  if (!vm.isPaused && vm.hasStarted && !vm.isGameOver) {
                    vm.pauseGame();
                  }
                },
              ),
            ),
          ],
        ),
        body: Consumer<GameViewModel>(
          builder: (context, vm, _) {
            final equation = vm.currentEquation;

            // Старт игры один раз после первого рендера
            if (!_hasStartedAutomatically) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                vm.startGame();
              });
              _hasStartedAutomatically = true;
            }

            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (vm.isGameOver) {
                _showGameOverDialog(context, vm.points, vm.resetGame);
              }
            });

            return Stack(
              children: [
                // Основной экран игры
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Очки: ${vm.points}', style: TextStyle(fontSize: 24)),
                        const SizedBox(height: 20),
                        if (equation != null)
                          Text(
                            "${equation.expression} =?",
                            style: const TextStyle(fontSize: 32),
                            textAlign: TextAlign.center,
                          ),
                        const SizedBox(height: 40),
                        Column(
                          children: vm.options.map((option) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: SizedBox(
                                width: double.infinity,
                                child: AnswerButton(
                                  answer: option,
                                  fillPercent: vm.timeLeftPercent,
                                  onPressed: () => vm.answerSelected(option),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),

                // Затемнение при паузе
                if (vm.isPaused)
                  PauseOverlay(
                    onResume: () => vm.resumeGame(),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showGameOverDialog(BuildContext context, int points, VoidCallback onRestart) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('Вы проиграли!'),
        content: Text('Ваш счёт: $points'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onRestart();
            },
            child: const Text('Начать заново'),
          ),
        ],
      ),
    );
  }
}
