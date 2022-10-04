import 'package:app_clima/Widgets/proximas_temperaturas.dart';
import 'package:app_clima/Widgets/resumo.dart';
import 'package:app_clima/models/previsao_hora.dart';
import 'package:app_clima/services/previsao_service.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<PrevisaoHora> ultimasPrevisoes;

  @override
  void initState() {
    super.initState();
    PrevisaoService service = PrevisaoService();
    ultimasPrevisoes = service.recuperarUltimasPrevisoes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clima'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Resumo(
              cidade: 'Lindoia-SP',
              temperaturaAtual: 30,
              temperaturaMaxima: 40,
              temperaturaMinima: 25,
              descricao: 'Ensolarado',
              numeroIcone: 1,
            ),
            Padding(
              padding: EdgeInsets.all(10),
            ),
            ProximasTemperaturas(
              previsoes: ultimasPrevisoes,
            )
          ],
        ),
      ),
    );
  }
}
