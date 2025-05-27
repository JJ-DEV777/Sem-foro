import 'package:flutter/material.dart';


class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  // Lista de usuários permitidos (nome → senha)
  final Map<String, String> usuariosPermitidos = {
    'admin': '123456',
    'lilian': 'senha123',
    'iasmin': 'senha456',
    'wlad': 'senha789',
    'savio': 'senha321',
    'wesley': 'senha654',
    'jason': 'senha987',
  };

  // Controladores para capturar o texto digitado nos campos
  final nomeController = TextEditingController();
  final senhaController = TextEditingController();

  void login() {
    String nome = nomeController.text.toLowerCase(); // Normaliza para evitar problemas de maiúsculas/minúsculas
    String senha = senhaController.text;

    // Verifica se o nome está na lista e se a senha corresponde
    if (usuariosPermitidos.containsKey(nome) && usuariosPermitidos[nome] == senha) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('✅ Login realizado com sucesso! Bem-vindo, $nome!')),
      );
      Navigator.pushReplacementNamed(context, '/inicio');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('❌ Login inválido. Verifique seu nome e senha!')),
      );
    }
  }

  @override
  void dispose() {
    // Libera os controladores para evitar vazamento de memória
    nomeController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
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
              controller: senhaController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Senha'),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: login,
              child: const Text('Entrar'),
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/registro'),
              child: const Text('Não tem conta? Cadastre-se'),
            ),
          ],
        ),
      ),
    );
  }
}