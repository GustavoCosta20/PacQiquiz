import 'package:flutter/material.dart';
import 'package:qiquiz_app/models/question_model.dart';
import 'package:qiquiz_app/servicos/autenticacao_servico.dart';
import 'package:qiquiz_app/_comum/minhas_cores.dart';
import 'package:qiquiz_app/telas/categorias.dart';
import 'package:qiquiz_app/widgets/next_buttom.dart';
import 'package:qiquiz_app/widgets/option_card.dart';
import 'package:qiquiz_app/widgets/question_widget.dart';
import 'package:qiquiz_app/widgets/result_box.dart';
import '../models/db_connect.dart';

class Perguntas extends StatefulWidget {
  final String categoria;
  @override
  State<Perguntas> createState() => _Perguntas();
  const Perguntas({required this.categoria, Key? key}) : super(key: key);
}

class _Perguntas extends State<Perguntas> {
  var db = DBconnect();

  late Future _questions;

  Future<List<Question>> getData(String categoria) async {
    return db.fetchQuestions(categoria);
  }

  @override
  void initState() {
    _questions = getData(widget.categoria);
    super.initState();
  }

  int index = 0;
  int score = 0;

  bool isPressed = false;
  bool isAlreadySelected = false;

  void nextQuestion(int questionLenght) {
    if (index == questionLenght - 1) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => ResultBox(
                result: score,
                questionLenght: questionLenght,
                onPressed: startOver,
              ));
    } else {
      if (isPressed) {
        setState(() {
          index++;
          isPressed = false;
          isAlreadySelected = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Selecione uma resposta'),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(vertical: 20.0),
        ));
      }
    }
  }

  void checkAnswerAndUpdate(bool value) {
    if (isAlreadySelected) {
      return;
    } else {
      if (value == true) {
        score++;
      }
      setState(() {
        isPressed = true;
        isAlreadySelected = true;
      });
    }
  }

  void startOver() {
    AutenticacaoServico()
        .atualizarPontuacao(score); // Adiciona pontuação ao Firebase

    setState(() {
      index = 0;
      score = 0;
      isPressed = false;
      isAlreadySelected = false;
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _questions as Future<List<Question>>,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            var extractedData = snapshot.data as List<Question>;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: const Color.fromARGB(255, 59, 220, 231),
                title: const Text(
                  "Perguntas",
                  style: TextStyle(color: Color(0xFF2D5D70)),
                ),
                iconTheme: const IconThemeData(
                  color: Color(0xFF2D5D70), //  cor do ícone
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      'Pontuação: $score',
                      style: const TextStyle(
                          fontSize: 18.0, color: Color(0xFF2D5D70)),
                    ),
                  ),
                ],
              ),
              drawer: Drawer(
                child: Container(
                  color: const Color.fromARGB(255, 59, 220, 231),
                  child: ListView(children: [
                    ListTile(
                      leading: const Icon(Icons.arrow_back),
                      title: const Text("Voltar para as categorias"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Categoria()),
                        );
                      },
                    ),
                  ]),
                ),
              ),
              body: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          MinhasCores.azulTopoGradiente,
                          MinhasCores.azulBaixoGradiente,
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 120),
                    child: Column(
                      children: [
                        QuestionWidget(
                          indexAction: index,
                          question: extractedData[index].title,
                          totalQuestions: extractedData.length,
                        ),
                        const Divider(color: Colors.white),
                        const SizedBox(height: 25.0),
                        for (int i = 0;
                            i < extractedData[index].options.length;
                            i++)
                          GestureDetector(
                            onTap: () => checkAnswerAndUpdate(
                                extractedData[index]
                                    .options
                                    .values
                                    .toList()[i]),
                            child: OptionCard(
                              option:
                                  extractedData[index].options.keys.toList()[i],
                              color: isPressed
                                  ? extractedData[index]
                                              .options
                                              .values
                                              .toList()[i] ==
                                          true
                                      ? MinhasCores.correct
                                      : MinhasCores.incorrect
                                  : const Color(0xFF2D5D70),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 530),
                    child: Form(
                      child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            //mainAxisAlignment: MainAxisAlignment.center,
                            //crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                "QIQUIZ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2D5D70),
                                  fontFamily: 'Monoton',
                                ),
                              ),
                              SizedBox(
                                height: 32,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              floatingActionButton: GestureDetector(
                onTap: () => nextQuestion(extractedData.length),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: .0),
                  child: NextButtom(),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
            );
          }
        } else {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Por favor espere as questões carregarem...',
                  style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      fontSize: 14.0),
                ),
              ],
            ),
          );
        }
        return const Center(
          child: Text('No data'),
        );
      },
    );
  }
}
