import 'package:flutter/material.dart';
import 'package:trabalhocurso/src/controller/esqueSenha_controller.dart';
import 'package:trabalhocurso/src/controller/esqueSenha_controller.dart';

class EsquesenhaView extends StatefulWidget {
  const EsquesenhaView({super.key});

  @override
  State<EsquesenhaView> createState() => _EsquesenhaViewState();
}

class _EsquesenhaViewState extends State<EsquesenhaView> {
  final EsquesenhaController controller = EsquesenhaController();

  bool _loading = false;
  String? _errorMessage;
  String? _successMessage;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _sendRecovery() async {
    setState(() {
      _errorMessage = null;
      _successMessage = null;
    });

    if (!controller.validateForm()) return;

    setState(() {
      _loading = true;
    });

    final success = await controller.sendRecoveryEmail();

    setState(() {
      _loading = false;
    });

    if (success) {
      setState(() {
        _successMessage = 'Email de recuperação enviado! Verifique sua caixa de entrada.';
      });
    } else {
      setState(() {
        _errorMessage = 'Erro ao enviar email. Tente novamente.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recuperar Senha')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              TextFormField(
                controller: controller.emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Digite seu email';
                  }
                  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                    return 'Digite um email válido';
                  }
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

              if (_successMessage != null)
                Text(
                  _successMessage!,
                  style: const TextStyle(color: Colors.green),
                  textAlign: TextAlign.center,
                ),

              const SizedBox(height: 24),

              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _loading ? null : _sendRecovery,
                  child: _loading
                      ? const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  )
                      : const Text('Enviar email de recuperação'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
