import 'package:flutter/material.dart';
import 'package:qiquiz_app/_comum/minhas_cores.dart';
import 'package:qiquiz_app/_comum/meu_snack_bar.dart';
import 'package:qiquiz_app/componentes/decoracao_campo_autenticacao.dart';
import 'package:qiquiz_app/servicos/autenticacao_servico.dart';
import 'package:logger/logger.dart';

class AutenticacaoTela extends StatefulWidget {
  const AutenticacaoTela({super.key});

  @override
  State<AutenticacaoTela> createState() => _AutenticacaoTelaState();
}

class _AutenticacaoTelaState extends State<AutenticacaoTela> {
  bool queroEntrar = true;
  var logger = Logger();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();

  final AutenticacaoServico _autenServico = AutenticacaoServico();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
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
              key: _formKey,
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
                      TextFormField(
                        controller: _emailController,
                        decoration: getAuthenticationInputDecoration("Email"),
                        validator: (String? value) {
                          if (value == null) {
                            return "O email não pode ser vazio";
                          }
                          if (value.length < 5) {
                            return "O email é muito curto...";
                          }
                          if (!value.contains("@")) {
                            return "Email inválido...";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: _senhaController,
                        decoration: getAuthenticationInputDecoration("Senha"),
                        obscureText: true,
                        validator: (String? value) {
                          if (value == null) {
                            return "A senha não pode ser vazia";
                          }
                          if (value.length < 5) {
                            return "A senha é muito curta...";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Visibility(
                        visible: !queroEntrar,
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: getAuthenticationInputDecoration(
                                  "Confirme sua senha"),
                              obscureText: true,
                              validator: (String? value) {
                                if (value == null) {
                                  return "A confirmação não pode ser vazia";
                                }
                                if (value.length < 5) {
                                  return "A confirmação é muito curta...";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              controller: _nomeController,
                              decoration:
                                  getAuthenticationInputDecoration("Nome"),
                              validator: (String? value) {
                                if (value == null) {
                                  return "O nome não pode ser vazio";
                                }
                                if (value.length < 5) {
                                  return "O nome é muito curto...";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          botaoPrincipalClicado();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xFF2D5D70), // Cor de fundo
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(10.0), // Valor de raio
                            ),
                            elevation: 5,
                            side: const BorderSide(
                                color: Color.fromARGB(255, 95, 88, 88),
                                width: 0.5) // Altura da sombra
                            ),
                        child: Text(
                          (queroEntrar) ? "Entrar" : "Cadastrar",
                          style: const TextStyle(
                            color: Colors.white, // Cor do texto
                          ),
                        ),
                      ),
                      const Divider(),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            queroEntrar = !queroEntrar;
                          });
                        },
                        child: Text(
                          (queroEntrar)
                              ? "Ainda não tem uma conta? Cadastre-se aqui!"
                              : "Já tem uma conta? Entre aqui!",
                          style: const TextStyle(color: Color(0xFF2D5D70)),
                        ),
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

  botaoPrincipalClicado() {
    String nome = _nomeController.text;
    String email = _emailController.text;
    String senha = _senhaController.text;

    if (_formKey.currentState!.validate()) {
      if (queroEntrar) {
        logger.d("entrada validada");
        _autenServico
            .logarUsuarios(email: email, senha: senha)
            .then((String? erro) {
          if (erro != null) {
            mostrarSnackBar(context: context, texto: erro);
          }
        });
      } else {
        logger.d("Cadastro validado");
        logger.d("$_emailController, $_senhaController, $_nomeController,");
        _autenServico
            .cadastrarUsuario(nome: nome, senha: senha, email: email)
            .then(
          (String? erro) {
            if (erro != null) {
              //Voltou com erro
              mostrarSnackBar(context: context, texto: erro);
            }
          },
        );
      }
    } else {
      logger.d("form inválido");
    }
  }
}
