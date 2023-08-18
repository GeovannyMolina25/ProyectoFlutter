import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
import 'package:proyectofinal/models/modelVideojuegos.dart';

class VideojuegosService {
  VideojuegosService();
  Future<List<Videojuego>?> getComputador() async {
    List<Videojuego> result = [];
    try {
      var url = Uri.https('demo7065986.mockable.io', 'api/videoJuego');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        if (response.body.isEmpty) {
          return result;
        } else {
          List<dynamic> listBody = json.decode(response.body);
          for (var item in listBody) {
            var NewVideojuego = Videojuego.fromJson(item);
            result.add(NewVideojuego);
          }
        }
      } else {
        developer.log('Request failed with status: ${response.statusCode}.');
      }
      return result;
    } catch (ex) {
      developer.log(ex.toString());
      return null;
    }
  }
}
