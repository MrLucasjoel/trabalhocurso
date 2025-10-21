import 'package:flutter/material.dart';
import 'package:trabalhocurso/src/model/user_model.dart';

class LoginController {
  // Controladores de TextField
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // Chave do formulário para validação
  final formKey = GlobalKey<FormState>();

  // Função para validar o formulário
  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  // Função de login
  void login(UserModel user, BuildContext context) {
    // Aqui você pode adicionar a lógica de autenticação
    // Por enquanto, vamos apenas fazer uma validação simples
    if (user.username == 'admin' && user.password == '123456') {
      // Simulação de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login bem-sucedido!')),
      );
      // Redireciona para a tela principal
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // Simulação de falha
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuário ou senha inválidos')),
      );
    }
  }
}
