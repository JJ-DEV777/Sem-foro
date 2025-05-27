import 'package:flutter/material.dart';

// Tela de cadastro (registro) de usuário
class TelaRegistro extends StatefulWidget {
  const TelaRegistro({super.key});

  @override
  State<TelaRegistro> createState() => _TelaRegistroState();
}

class _TelaRegistroState extends State<TelaRegistro> {
  final nomeController = TextEditingController();
  final telefoneController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  void registrar() {
    String nome = nomeController.text;
    String telefone = telefoneController.text;
    String email = emailController.text;
    String senha = senhaController.text;

    if (nome.isNotEmpty && telefone.isNotEmpty && email.isNotEmpty && senha.length >= 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Usuário cadastrado com sucesso!')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('❌ Erro ao tentar se cadastrar. Preencha todos os campos corretamente!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.pushReplacementNamed(context, '/inicio'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: telefoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: 'Telefone'),
            ),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: senhaController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Senha'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: registrar,
              child: const Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}