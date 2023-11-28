import 'package:flutter/material.dart';
import 'package:qiquiz_app/servicos/autenticacao_servico.dart';
import 'package:qiquiz_app/_comum/minhas_cores.dart';
import 'categorias.dart'; // Importe o arquivo categorias.dart
import 'rank.dart'; // Importe o arquivo rank.dart
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InicioTela extends StatelessWidget {
  const InicioTela({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 59, 220, 231),
        title: const Text(
          "Menu",
          style: TextStyle(color: Color(0xFF2D5D70)),
        ),
        iconTheme: const IconThemeData(
          color: Color(0xFF2D5D70), // Defina a cor desejada para o ícone
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: const Color.fromARGB(255, 59, 220, 231),
          child: ListView(children: [
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Deslogar"),
              onTap: () {
                AutenticacaoServico().deslogar();
              },
            )
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "QIQUIZ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 65,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D5D70),
                    fontFamily: 'Monoton',
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                SizedBox(
                  height: 80, // Defina a altura desejada
                  width: 200, // Defina a largura desejada
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Categoria()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 28, 136, 144),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10.0), // Valor de raio
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      "Iniciar Quiz",
                      style: TextStyle(fontSize: 23.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                    height: 80, // Defina a altura desejada
                    width: 200, // Defina a largura desejada
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Rank()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 28, 136, 144),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Rank  ",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 23.0)),
                          FaIcon(
                            FontAwesomeIcons
                                .trophy, // Ícone de troféu do pacote font_awesome_flutter
                            color: Colors.white,
                            size: 24, // Tamanho do ícone
                          ),
                          SizedBox(width: 8),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
