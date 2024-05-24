import 'dart:convert';
import 'dart:io';
import '../models/entities/member.dart';
import '../configs/constants.dart';
import 'package:http/http.dart' as http;
import '../configs/http_api_exception.dart';

class TripService {
  Future<void> save(String name, List<File> images) async {
    String url = "${BASE_URL}trip/save";
    var request = http.MultipartRequest('POST', Uri.parse(url));
    for (var image in images) {
      request.files
          .add(await http.MultipartFile.fromPath('images', image.path));
    }
    request.fields['name'] = name;
    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        // Manejar la respuesta del servidor si es exitosa
        print('Archivo enviado exitosamente');
      } else {
        // Manejar errores
        print('Error al enviar el archivo: ${response.statusCode}');
      }
    } catch (e) {
      // Manejar excepciones
      print('Excepción al enviar el archivo: $e');
    }
  }
}
