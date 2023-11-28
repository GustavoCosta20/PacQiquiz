import 'package:flutter/material.dart';
import 'package:qiquiz_app/_comum/minhas_cores.dart';

class ResultBox extends StatelessWidget {
  const ResultBox({
    Key? key,
    required this.result,
    required this.questionLenght,
    required this.onPressed,
  }) : super(key: key);
  final int result;
  final int questionLenght;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 32, 165, 175),
      content: Padding(
        padding: const EdgeInsets.all(60.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Resultado:',
              style: TextStyle(color: Colors.white, fontSize: 19.0),
            ),
            const SizedBox(height: 20.0),
            CircleAvatar(
              radius: 70.0,
              backgroundColor: result == questionLenght / 2
                  ? Colors.yellow
                  : result < questionLenght / 2
                      ? MinhasCores.incorrect
                      : MinhasCores.correct,
              child: Text(
                '$result/$questionLenght',
                style: const TextStyle(fontSize: 30.0),
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              result == questionLenght / 2
                  ? 'Quase lá'
                  : result < questionLenght / 2
                      ? 'Tente de novo\n'
                      : 'Muito bem!',
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(width: 25.0),
            GestureDetector(
              onTap: onPressed,
              child: const Text(
                'Recomeçar',
                style: TextStyle(
                  color: Color(0xFF2D5D70),
                  fontSize: 20.0,
                  letterSpacing: 1.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
