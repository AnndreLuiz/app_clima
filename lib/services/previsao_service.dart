import 'package:app_clima/controllers/cidade_controller.dart';
import 'package:app_clima/models/previsao_hora.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'dart:convert';

class PrevisaoService {
  final String baseUrlAPI = 'dataservice.accuweather.com';
  final String path =
      'forecasts/v1/hourly/12hour/${CidadeController.instancia.cidadeEscolhida.codigo}';
  final Map<String, String> params = {
    'apikey': dotenv.get('API_KEY'),
    'language': 'pt-BR',
    'metric': 'true',
  };

  Future<List<PrevisaoHora>> recuperarUltimasPrevisoes() async {
    final Response resposta = await get(Uri.https(baseUrlAPI, path, params));

    if (resposta.statusCode == 200) {
      Iterable it = json.decode(resposta.body);
      List<PrevisaoHora> previsoes = List.from(
          it.map((objJson) => PrevisaoHora.transformarHorario(objJson)));
      return previsoes;
    } else {
      throw Exception('falha ao carregar as previsoes');
    }
  }
}
