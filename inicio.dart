import 'dart:async';
import 'package:flutter/material.dart';

// Enum com as ações possíveis
enum SemaforoAction { vermelho, amarelo, verde, todas, apagado }

class TelaInicio extends StatefulWidget {
  const TelaInicio({Key? key}) : super(key: key);

  @override
  State<TelaInicio> createState() => _TelaInicioState();
}

class _TelaInicioState extends State<TelaInicio> {
  SemaforoAction _acao = SemaforoAction.apagado;
  Timer? _blinkTimer;
  bool _showOn = true;

  @override
  void dispose() {
    _blinkTimer?.cancel();
    super.dispose();
  }

  void _acionar(SemaforoAction novaAcao) {
    // Cancela qualquer piscar em andamento
    _blinkTimer?.cancel();
    _showOn = true;

    if (novaAcao == SemaforoAction.piscar) {
     
    }

    setState(() {
      _acao = novaAcao;
    });
  }

  Color _corPara(SemaforoAction luz) {
    // Se for “todas”, acende todas as três
    if (_acao == SemaforoAction.todas) {
      return _corEstatica(luz);
    }


  Color _corEstatica(SemaforoAction luz) {
    switch (luz) {
      case SemaforoAction.vermelho:
        return Colors.red;
      case SemaforoAction.amarelo:
        return Colors.yellow;
      case SemaforoAction.verde:
        return Colors.green;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Semáforo Inteligente'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Semáforo
          Container(
            width: 80,
            height: 220,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildLuz(_corPara(SemaforoAction.vermelho)),
                _buildLuz(_corPara(SemaforoAction.amarelo)),
                _buildLuz(_corPara(SemaforoAction.verde)),
              ],
            ),
          ),

          const SizedBox(height: 40),

          // Botões de controle
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              _buildBotao(
                'Luz Vermelha',
                Colors.red,
                () => _acionar(SemaforoAction.vermelho),
              ),
              _buildBotao(
                'Luz Amarela',
                Colors.yellow,
                () => _acionar(SemaforoAction.amarelo),
              ),
              _buildBotao(
                'Luz Verde',
                Colors.green,
                () => _acionar(SemaforoAction.verde),
              ),
              _buildBotao(
                'Acender Todas',
                Colors.blue,
                () => _acionar(SemaforoAction.todas),
              ),
              _buildBotao(
                'Piscar Luzes',
                Colors.deepOrange,
                () => _acionar(SemaforoAction.piscar),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLuz(Color color) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
    );
  }

  Widget _buildBotao(String label, Color bg, VoidCallback onPressed) {
    return SizedBox(
      width: 140,
      height: 40,
      child: ElevatedButton(
        onPressed: onPressed,
              style: ElevatedButton.styleFrom(backgroundColor: bg),
        child: Text(label, style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}