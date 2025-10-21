import 'package:flutter/material.dart';
import 'package:trabalhocurso/src/controller/login_controller.dart';
import 'package:trabalhocurso/src/model/user_model.dart';
import 'package:trabalhocurso/src/view/esqueSenha_view.dart';
import 'package:trabalhocurso/src/view/registro_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginController loginController = LoginController();

  bool _loading = false;
  bool _obscurePassword = true;
  String? _erro;

  void _login() async {
    if (!loginController.validateForm()) return;

    setState(() {
      _loading = true;
      _erro = null;
    });

    final user = UserModel(
      username: loginController.usernameController.text,
      password: loginController.passwordController.text,
    );

    try {
      // Simulação de login assíncrono
      await Future.delayed(const Duration(seconds: 2));

      // Aqui você pode chamar a lógica real do loginController.login,
      // que pode retornar sucesso ou erro (ajuste conforme seu controller)
      final sucesso = user.username == 'admin' && user.password == '123456';

      if (sucesso) {
        // Login bem-sucedido: redireciona para home
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        setState(() {
          _erro = 'Usuário ou senha inválidos';
        });
      }
    } catch (e) {
      setState(() {
        _erro = 'Erro no login. Tente novamente.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: loginController.formKey,
          child: Column(
            children: [
              // Campo usuário
              TextFormField(
                controller: loginController.usernameController,
                decoration: InputDecoration(
                  labelText: 'Usuário',
                  prefixIcon: const Icon(Icons.person),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Digite seu usuário';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Campo senha
              TextFormField(
                controller: loginController.passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Digite sua senha';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Mensagem de erro
              if (_erro != null)
                Text(
                  _erro!,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              const SizedBox(height: 24),

              // Botão login
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _loading ? null : _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white24,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _loading
                      ? const CircularProgressIndicator(
                    color: Colors.black,
                    strokeWidth: 2,
                  )
                      : const Text(
                    'Entrar',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RegistroView()),
                  );
                },
                child: const Text('Registrar'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const EsquesenhaView()),
                  );
                },
                child: const Text('Esqueceu a senha?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
