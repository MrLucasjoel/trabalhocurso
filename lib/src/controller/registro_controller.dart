import 'package:flutter/material.dart';
import 'package:trabalhocurso/src/model/registro_model.dart';

class RegistroController {
  final formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool validateForm() {
    final form = formKey.currentState;
    if (form == null) return false;
    return form.validate();
  }

  // Método de registro fictício (sem API)
  Future<bool> registerUser() async {
    if (!validateForm()) return false;

    final username = usernameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (password != confirmPassword) {
      return false; // Senhas não conferem
    }

    // Simula um atraso de registro
    await Future.delayed(const Duration(seconds: 2));

    // Aqui poderia salvar em um banco local, ou só aceitar o cadastro
    // Como é só exemplo, vamos aceitar sempre que passar as validações

    // Você pode retornar true para indicar sucesso
    return true;
  }

  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }
}
