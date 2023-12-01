import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qiquiz_app/servicos/autenticacao_servico.dart';
import 'package:qiquiz_app/_comum/minhas_cores.dart';
import 'package:qiquiz_app/telas/inicio_tela.dart';
import 'package:logger/logger.dart';

class Rank extends StatefulWidget {
  const Rank({Key? key}) : super(key: key);

  @override
  _RankState createState() => _RankState();
}

class _RankState extends State<Rank> {
  var logger = Logger();
  late Future<List<Map<String, dynamic>>> _ranking;

  @override
  void initState() {
    _ranking = _getRanking();
    super.initState();
  }

  Future<List<Map<String, dynamic>>> _getRanking() async {
    List<Map<String, dynamic>> ranking = [];

    try {
      List<QueryDocumentSnapshot> users =
          await AutenticacaoServico().obterRanking();

      for (QueryDocumentSnapshot user in users) {
        String nome = user['nome'];
        int pontuacao = user['pontuacao'];

        ranking.add({'nome': nome, 'pontuacao': pontuacao});
      }
    } catch (e) {
      logger.d('Erro ao obter ranking: $e');
    }

    return ranking;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 59, 220, 231),
        title: const Text(
          "Rank",
          style: TextStyle(color: Color(0xFF2D5D70)),
        ),
        iconTheme: const IconThemeData(
          color: Color(0xFF2D5D70), // cor do ícone
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: const Color.fromARGB(255, 59, 220, 231),
          child: ListView(children: [
            ListTile(
              leading: const Icon(Icons.arrow_back),
              title: const Text("Voltar ao menu"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const InicioTela()),
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
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(18, 10, 28, 0),
                  child: Text(
                    "QIQUIZ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 65,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D5D70),
                      fontFamily: 'Monoton',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 10, 18, 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: MinhasCores.azulTopoGradiente,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(
                        child: Text(
                          'Top 10 maiores pontuações',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 23, 48, 58),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 10, 18, 10),
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                    future: _ranking,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          List<Map<String, dynamic>> ranking = snapshot.data!;

                          int primeiroLugar = 0;
                          int segundoLugar = 1;
                          int terceiroLugar = 2;

                          return Column(
                            children: [
                              for (int i = 0; i < ranking.length; i++)
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: ListTile(
                                    title: Text(
                                      '${i + 1}º  ${ranking[i]['nome']}',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    subtitle: Text(
                                      'Pontuação: ${ranking[i]['pontuacao']}',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    trailing: i == primeiroLugar
                                        ? const FaIcon(
                                            FontAwesomeIcons.trophy,
                                            color: Colors.amber,
                                            size: 24,
                                          )
                                        : i == segundoLugar
                                            ? const FaIcon(
                                                FontAwesomeIcons.trophy,
                                                color: Color.fromARGB(
                                                    255, 205, 205, 205),
                                                size: 24,
                                              )
                                            : i == terceiroLugar
                                                ? const FaIcon(
                                                    FontAwesomeIcons.trophy,
                                                    color: Color.fromARGB(
                                                        255, 206, 87, 44),
                                                    size: 24,
                                                  )
                                                : null,
                                  ),
                                ),
                            ],
                          );
                        } else {
                          return const Center(
                            child: Text('Sem dados de ranking.'),
                          );
                        }
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
