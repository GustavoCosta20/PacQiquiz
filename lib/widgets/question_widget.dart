import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget(
      {Key? key,
      required this.question,
      required this.indexAction,
      required this.totalQuestions})
      : super(key: key);

  final String question;
  final int indexAction;
  final int totalQuestions;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        'Questão ${indexAction + 1}/$totalQuestions:\n$question',
        style: const TextStyle(
          fontSize: 23.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
