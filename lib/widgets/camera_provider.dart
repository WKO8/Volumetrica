import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CameraProvider extends ChangeNotifier {
  late CameraController _controller;

  CameraProvider(List<CameraDescription> cameras) {
    _controller = CameraController(cameras.first, ResolutionPreset.medium);
  }

  CameraController get controller => _controller;

  Future<void> initialize() async {
    await _controller.initialize();
    notifyListeners();
  }

  // Função para enviar a foto para o servidor
  Future<void> sendPhotoToServer(XFile photoFile) async {
    var uri = Uri.parse('https://seu-dominio.com/predict'); // Substitua pelo URL do seu servidor
    var request = http.MultipartRequest('POST', uri)
      ..headers.addAll({'Content-Type': 'multipart/form-data'})
      ..files.add(await http.MultipartFile.fromPath('file', photoFile.path));

    var response = await request.send();
    if (response.statusCode == 200) {
      print('Foto enviada com sucesso.');
      // Processar a resposta do servidor conforme necessário
    } else {
      print('Falha ao enviar foto.');
    }
  }
}