import 'package:app_clima/models/previsao_hora.dart';

class PrevisaoService {
  List<PrevisaoHora> recuperarUltimasPrevisoes() {
    return [
      PrevisaoHora('11:00', 'Ensolarado', 1, 30),
      PrevisaoHora('12:00', 'Ensolarado', 1, 30),
      PrevisaoHora('13:00', 'Ensolarado', 1, 32),
      PrevisaoHora('14:00', 'Ensolarado', 1, 32),
      PrevisaoHora('15:00', 'Ensolarado', 1, 34),
      PrevisaoHora('16:00', 'Ensolarado', 1, 35),
      PrevisaoHora('17:00', 'Ensolarado', 1, 34),
      PrevisaoHora('18:00', 'Parcialmente ensolarado', 2, 29),
      PrevisaoHora('19:00', 'Nuvens esparsas', 3, 28),
      PrevisaoHora('20:00', 'Nuvens esparsas', 3, 27),
    ];
  }
}
