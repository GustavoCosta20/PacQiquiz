import 'package:http/http.dart' as http;
import './question_model.dart';
import 'dart:convert';

class DBconnect {
  final url = Uri.parse(
      'https://qiquiz-caf52-default-rtdb.firebaseio.com/questions.json');

  Future<List<Question>> fetchQuestions(String categoria) async {
    return http.get(url).then((response) {
      var data = json.decode(response.body) as Map<String, dynamic>;
      List<Question> newQuestions = [];

      data.forEach((key, value) {
        //  verifica se a pergunta pertence à categoria desejada
        if (value['categoria'] == categoria) {
          var newQuestion = Question(
            id: key,
            title: value['title'],
            options: Map.castFrom(value['options']),
          );

          newQuestions.add(newQuestion);
        }
      });

      return newQuestions;
    });
  }
}
