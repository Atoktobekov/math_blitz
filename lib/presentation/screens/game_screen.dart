import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:math_blitz/presentation/viewmodels/game_view_model.dart';
import 'package:math_blitz/presentation/widgets/answerButton.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GameViewModel>(
      create: (_) => GameViewModel(),
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: const Text('Math Blitz',
            style: TextStyle(
              color: Colors.black,
              fontSize: 28,
              fontWeight: FontWeight.w400,
            ),
            )
        ),
        body: Consumer<GameViewModel>(
          builder: (context, vm, _) {
            final equation = vm.currentEquation;

            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (vm.isGameOver) {
                _showGameOverDialog(context, vm.points, vm.resetGame);
              }
            });

            return Stack(
              children: [
                // Игра
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
                            style: TextStyle(fontSize: 32),
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

                // Затемнение + кнопка "Начать"
                if (!vm.hasStarted)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withOpacity(0.25),
                      child: Center(
                        child: SizedBox(
                          width: 250,
                          height: 80,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 8,
                              shadowColor: Colors.black,
                              textStyle: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () => vm.startGame(),
                            child: const Text('НАЧАТЬ'),
                          ),
                        ),

                      ),
                    ),
                  ),
              ],
            );

          },
        ),
      ),
    );
  }

  void _showGameOverDialog(
      BuildContext context,

      int points,
      VoidCallback onRestart,
      ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Text('Вы проиграли!'),
        content: Text('Ваш счёт: $points'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onRestart();
            },
            child: Text('Начать заново'),
          ),
        ],
      ),
    );
  }
}
