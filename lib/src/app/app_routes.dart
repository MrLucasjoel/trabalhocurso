import 'package:flutter/material.dart';
import 'package:trabalhocurso/src/view/esqueSenha_view.dart';
import 'package:trabalhocurso/src/view/home_view.dart';
import 'package:trabalhocurso/src/view/login_view.dart';
import 'package:trabalhocurso/src/view/registro_view.dart';

class AppRoutes {
  static const String login = '/login';
  static const String registro = '/registro';
  static const String esquesenha = '/esquesenha';
  static const String home = '/home';
  //static const String perfil = '/perfil';
  //static const String configuracoes = '/configuracoes';
  //static const String ajuda = '/ajuda';

  static Map<String, WidgetBuilder> get routes => {
    login: (_) => const LoginView(),
    registro: (_) => const RegistroView(),
    esquesenha: (_) => const EsquesenhaView(),
    home: (_) => const HomeView(),
    //perfil: (_) => const PerfilView(),
    //configuracoes: (_) => const ConfiguracoesView(),
    //ajuda: (_) => const AjudaView(),
  };
}