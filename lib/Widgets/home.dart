import 'package:app_clima/Widgets/proximas_temperaturas.dart';
import 'package:app_clima/Widgets/resumo.dart';
import 'package:app_clima/models/previsao_hora.dart';
import 'package:app_clima/services/previsao_service.dart';
import 'package:flutter/material.dart';
import 'dart:core';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<PrevisaoHora>> ultimasPrevisoes;

  @override
  void initState() {
    super.initState();
    carregarPrevisoes();
  }

  void carregarPrevisoes() {
    PrevisaoService service = PrevisaoService();
    ultimasPrevisoes = service.recuperarUltimasPrevisoes();
  }

  Future<Null> atualizarPrevisoes() async {
    setState(() => carregarPrevisoes());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clima'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: atualizarPrevisoes,
        child: Center(
          child: FutureBuilder<List<PrevisaoHora>>(
            future: ultimasPrevisoes,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<PrevisaoHora>? previsoes = snapshot.data;
                double temperaturaAtual = previsoes![0].temperatura;
                double menorTemperatura = double.maxFinite;
                double maiorTemperatura = double.negativeInfinity;
                previsoes.forEach((obj) {
                  if (obj.temperatura < menorTemperatura) {
                    menorTemperatura = obj.temperatura;
                  }
                });
                String descricao = previsoes[0].descricao;
                int numeroIcone = previsoes[0].numeroIcone;
                return Column(
                  children: [
                    Resumo(
                      cidade: 'Lindoia-SP',
                      temperaturaAtual: temperaturaAtual,
                      temperaturaMaxima: maiorTemperatura,
                      temperaturaMinima: menorTemperatura,
                      descricao: descricao,
                      numeroIcone: numeroIcone,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    ProximasTemperaturas(
                      previsoes: previsoes.sublist(1, previsoes.length),
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('erro ao carregar previsoes');
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
