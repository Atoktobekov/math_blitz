import 'package:flutter/material.dart';


class PauseOverlay extends StatelessWidget {
  final VoidCallback onResume;

  const PauseOverlay({required this.onResume, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.93),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: onResume,
                child: Text('Продолжить'),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Заглушка, пока ничего не делает
                },
                child: Text('Настройки'),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Заглушка выхода в меню
                },
                child: Text('Выход в главное меню'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
