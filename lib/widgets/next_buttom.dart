import 'package:flutter/material.dart';

class NextButtom extends StatelessWidget {
  const NextButtom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330.0,
      height: 60.0,
      decoration: BoxDecoration(
        color: const Color(0xFF2D5D70),
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: const Text(
        'Próxima Questão',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20.0, color: Colors.white),
      ),
    );
  }
}
