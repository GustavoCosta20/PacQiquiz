import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AutenticacaoServico {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> cadastrarUsuario({
    required String nome,
    required String senha,
    required String email,
  }) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );

      await userCredential.user!.updateDisplayName(nome);

      // adiciona usuário ao Firestore
      await _firestore
          .collection('usuarios')
          .doc(userCredential.user!.uid)
          .set({
        'nome': nome,
        'pontuacao': 0, // inicia a pontuação do usuário com 0
      });

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return "O usuário já está cadastrado";
      }
      return "Erro desconhecido";
    }
  }

  Future<String?> logarUsuarios({
    required String email,
    required String senha,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: senha);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> deslogar() async {
    return _firebaseAuth.signOut();
  }

  Future<void> atualizarPontuacao(int novaPontuacao) async {
    User? user = _firebaseAuth.currentUser;

    if (user != null) {
      await _firestore.collection('usuarios').doc(user.uid).update({
        'pontuacao': FieldValue.increment(novaPontuacao),
      });
    }
  }

  Future<int> obterPontuacaoUsuario() async {
    User? user = _firebaseAuth.currentUser;

    if (user != null) {
      DocumentSnapshot userSnapshot =
          await _firestore.collection('usuarios').doc(user.uid).get();
      return userSnapshot['pontuacao'] ?? 0;
    }

    return 0;
  }

  Future<List<QueryDocumentSnapshot>> obterRanking() async {
    QuerySnapshot rankingSnapshot = await _firestore
        .collection('usuarios')
        .orderBy('pontuacao', descending: true)
        .limit(10)
        .get();
    return rankingSnapshot.docs;
  }
}
