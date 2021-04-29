import 'dart:convert';

import 'package:flutter_application_1/src/models/asteroides_model.dart';
import 'package:flutter_application_1/src/models/dia_model.dart';
import 'package:http/http.dart' as http;

class NasaProvider {
  String _apikey = '9iYWYqHHgPoGfxmgb3sxBVPeJcGkzoHaZTkkuCaG';
  String _url = 'api.nasa.gov';
  var hoy = new DateTime.now();

  Future<Imagen> getImagenDia() async {
    final url = Uri.https(_url, '/planetary/apod', {
      'api_key': _apikey,
    }); //configura la llamada a la base de datos
    final resp = await http.get(url); //llama a la base de datos
    final decodeddata = json
        .decode(resp.body); //todo el string que llega lo convierte en un mapa
    final dia = new Imagen.fromJsonMap(decodeddata);
    // // print(dia.url);
    return dia;
  }

  Future<Asteroides> getAsteroides() async {
    String _fecha = ('${hoy.year}-${hoy.month}-${hoy.day}');
    final url = Uri.https(_url, '/neo/rest/v1/feed', {
      'start_date': _fecha,
      'end_date': _fecha,
      'api_key': _apikey,
    });
    final resp = await http.get(url);
    final decodeddata = json.decode(resp.body);
    final aster = new Asteroides.fromJson(decodeddata);
    // var x = aster.nearEarthObjects.values.first;
    // Map y = x.estimatedDiameter.values.first;
    // print(y);
    // for (var x in aster.nearEarthObjects.values.first) {
    //   //entra en los astoides y el nearearhobjects y agarra el primer mapa que esta en la lista
    //   var y = x.estimatedDiameter;
    //   var z = y.kilometers;
    //   print(z.estimatedDiameterMax);
    //   // for (var a in z.kilometers.values) {
    //   //   print(a);
    // }

    //   // for (var y in x.links.values.first) {
    //   //   print(y);
    //   // }
    // }
    return aster;
  }
}
