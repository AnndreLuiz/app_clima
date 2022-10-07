import 'package:app_clima/Widgets/configuracoes.dart';
import 'package:app_clima/Widgets/home.dart';
import 'package:app_clima/controllers/cidade_controller.dart';
import 'package:app_clima/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

Future main() async {
  await DotEnv.DotEnv().load(fileName: '.env');
  await CidadeController.instancia.inicializarDB();
  await CidadeController.instancia.inicializarCidade();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: TemaController.instancia,
      builder: (context, child) {
        return MaterialApp(
            title: 'Clima',
            theme: TemaController.instancia.usarTemaEscuro
                ? ThemeData.dark()
                : ThemeData.light(),
            debugShowCheckedModeBanner: false,
            home: CidadeController.instancia.cidadeEscolhida != null
                ? Home()
                : Configuracoes(),
            routes: {
              '/home': (context) => Home(),
            });
      },
    );
  }
}
