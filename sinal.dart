import 'package:flutter/material.dart';

class Sinal extends StatefulWidget {
  const Sinal({super.key});

  @override
  State<Sinal> createState() => _SinalState();
}

class _SinalState extends State<Sinal> {
  Color luzSuperior = Colors.transparent;
  Color luzMeio = Colors.transparent;
  Color luzInferior = Colors.transparent;

  void acenderUmaLuz(Color cor) {
    setState(() {
      luzSuperior = cor;
      luzMeio = Colors.transparent;
      luzInferior = Colors.transparent;
    });
  }

  void acenderTodasLuzes() {
    setState(() {
      luzSuperior = Colors.red;
      luzMeio = Colors.yellow;
      luzInferior = Colors.green;
    });
  }

  void piscarLuzes() async {
    for (int i = 0; i < 3; i++) {
      setState(() {
        luzSuperior = Colors.red;
        luzMeio = Colors.yellow;
        luzInferior = Colors.green;
      });
      await Future.delayed(const Duration(milliseconds: 500));

      setState(() {
        luzSuperior = Colors.transparent;
        luzMeio = Colors.transparent;
        luzInferior = Colors.transparent;
      });
      await Future.delayed(const Duration(milliseconds: 500));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Semáforo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.pushReplacementNamed(context, '/inicio'),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Caixa do Semáforo
          Container(
            width: 100,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Luz Vermelha (Topo)
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: luzSuperior,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
                // Luz Amarela (Meio)
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: luzMeio,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
                // Luz Verde (Inferior)
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: luzInferior,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),

          // Botões de comando
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => acenderUmaLuz(Colors.red),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Luz Vermelha'),
              ),
              ElevatedButton(
                onPressed: () => acenderUmaLuz(Colors.green),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text('Luz Verde'),
              ),
              ElevatedButton(
                onPressed: () => acenderUmaLuz(Colors.yellow),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
                child: const Text('Luz Amarela'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: acenderTodasLuzes,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: const Text('Acender Todas'),
              ),
              ElevatedButton(
                onPressed: piscarLuzes,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                child: const Text('Piscar Luzes'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}