import 'package:flutter/material.dart';
import 'package:trabalhocurso/src/controller/registro_controller.dart';

class RegistroView extends StatefulWidget {
  const RegistroView({super.key});

  @override
  State<RegistroView> createState() => _RegistroViewState();
}

class _RegistroViewState extends State<RegistroView> {
  final RegistroController controller = RegistroController();

  bool _loading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String? _errorMessage;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    setState(() {
      _errorMessage = null;
    });

    if (!controller.validateForm()) return;

    if (controller.passwordController.text != controller.confirmPasswordController.text) {
      setState(() {
        _errorMessage = "As senhas não coincidem.";
      });
      return;
    }

    setState(() {
      _loading = true;
    });

    final success = await controller.registerUser();

    setState(() {
      _loading = false;
    });

    if (success) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registro realizado com sucesso!')),
      );
      Navigator.pop(context); // Volta para tela anterior (login)
    } else {
      setState(() {
        _errorMessage = "Erro no registro. Tente novamente.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(title: const Text('Registrar'),
        backgroundColor: Colors.greenAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: controller.usernameController,
                decoration: InputDecoration(
                  labelText: 'Usuário',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder( // Define a borda do campo
                    borderRadius: BorderRadius.circular(12), // Borda com bordas arredondadas
                    borderSide: BorderSide(
                      color: Colors.black, // Cor da borda
                      width: 2, // Largura da borda
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Digite seu usuário';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: controller.emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Digite seu email';
                  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) return 'Digite um email válido';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: controller.passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  prefixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2,
                        ),
                      ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Digite sua senha';
                  if (value.length < 6) return 'Senha deve ter ao menos 6 caracteres';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: controller.confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                decoration: InputDecoration(
                  labelText: 'Confirmar senha',
                  prefixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2,
                        ),
                      ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Confirme sua senha';
                  if (value != controller.passwordController.text) return 'As senhas não coincidem';
                  return null;
                },
              ),
              const SizedBox(height: 24),

              if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),

              const SizedBox(height: 24),

              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: _loading ? null : _register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _loading ? Colors.grey : Colors.teal, // Cor do fundo (botão)
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Bordas arredondadas
                    ),
                    side: BorderSide(
                      color: Colors.black,
                      // Cor da borda, caso queira uma borda visível
                      width: 2,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20), // Padding para aumentar a largura do botão
                  ),
                  child: _loading
                      ? const CircularProgressIndicator(
                    color: Colors.teal,
                    strokeWidth: 2,
                  )
                      : const Text('Registrar',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
