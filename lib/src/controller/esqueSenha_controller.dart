import 'package:flutter/material.dart';
import 'package:trabalhocurso/src/model/esqueSenha_model.dart';

class EsquesenhaController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  bool validateForm() {
    final form = formKey.currentState;
    if (form == null) return false;
    return form.validate();
  }

  Future<bool> sendRecoveryEmail() async {
    if (!validateForm()) return false;

    final email = emailController.text.trim();

    // Simula um delay para "envio" do email
    await Future.delayed(const Duration(seconds: 2));

    // Aqui poderia validar se o email existe, enviar email, etc.
    // Como é só exemplo, vamos aceitar sempre.

    return true;
  }

  void dispose() {
    emailController.dispose();
  }
}
