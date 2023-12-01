import 'package:flutter/material.dart';
import 'package:qiquiz_app/_comum/minhas_cores.dart';
import 'package:qiquiz_app/telas/inicio_tela.dart';
import 'perguntas.dart';

class Categoria extends StatelessWidget {
  const Categoria({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 59, 220, 231),
        title: const Text(
          "Categorias",
          style: TextStyle(color: Color(0xFF2D5D70)),
        ),
        iconTheme: const IconThemeData(
          color: Color(0xFF2D5D70), // muda cor do ícone
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              child: Center(
                child: SingleChildScrollView(
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
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Perguntas(
                                          categoria: "Geografia"),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 28, 136, 144),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/geografia.png',
                                      width: 95,
                                      height: 100,
                                    ),
                                    const Text(
                                      "Geografia",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Perguntas(
                                          categoria: "Biologia"),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 28, 136, 144),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/biologia.png',
                                      width: 95,
                                      height: 100,
                                    ),
                                    const Text(
                                      "Biologia",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Perguntas(
                                            categoria: "Historia"),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 28, 136, 144),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        'assets/images/historia.png',
                                        width: 95,
                                        height: 100,
                                      ),
                                      const Text(
                                        "História",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Perguntas(
                                            categoria: "Fisica"),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 28, 136, 144),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        'assets/images/fisica.png',
                                        width: 95,
                                        height: 100,
                                      ),
                                      const Text(
                                        "Física",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
