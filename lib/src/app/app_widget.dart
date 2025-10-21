import 'package:flutter/material.dart';
import 'package:trabalhocurso/src/app/app_routes.dart';
import 'package:trabalhocurso/src/view/home_view.dart';
import 'package:trabalhocurso/src/view/login_view.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meu App',
      theme: ThemeData(
        useMaterial3: true, // Ativa o Material 3
        primaryColor: Colors.blue, // Defina a cor primária diretamente
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue), // Usando a cor primária como seed
        textTheme: TextTheme(
          headlineSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), // Definindo um estilo para headline
          bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.normal), // Estilo do corpo
          labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500), // Estilo do botão
        ),
      ),
      initialRoute: AppRoutes.login,
      routes: {
        AppRoutes.login: (context) => const LoginView(),
        AppRoutes.home: (context) => const HomeView(), // Corrigido o nome da classe para HomeView
      },
    );
  }
}
