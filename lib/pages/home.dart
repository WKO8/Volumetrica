import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:volumetrica/others/auth_shared_preference.dart';
import 'package:volumetrica/widgets/custom_button.dart';
import 'package:volumetrica/widgets/custom_bottom_navigation_bar.dart';
import 'package:volumetrica/widgets/custom_side_menu.dart';
// Importe a página de perfil

class HomePage extends StatefulWidget {
  final List<CameraDescription> cameras;

  const HomePage({
    super.key, 
    required this.cameras,
  });

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CameraController _controller;
  XFile? _capturedPhoto;
  bool _showCapturedPhoto = false;
  String? _prediction;
  String? _imagePath;
  bool _isLoading = false;
  bool _isPhotoShown = false;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    final firstCamera = widget.cameras[0]; // Usa 'widget.cameras'
    _controller = CameraController(
      firstCamera,
      ResolutionPreset.high,
    );

    await _controller.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _takePicture() async {
    try {
      final XFile? imageFile = await _controller.takePicture();
      if (imageFile!= null) {
        setState(() {
          _capturedPhoto = imageFile;
          _showCapturedPhoto = true;
          _isLoading = true;
          _isPhotoShown = true; // Inicia o carregamento
          _imagePath = imageFile.path; // Define o caminho da imagem aqui, já que temos a referência
        });

        const String apiUrl = 'https://6c72-2804-1b3-6147-2020-8904-9fc3-57a7-23b8.ngrok-free.app/predict';
        print(_imagePath);
        final request = http.MultipartRequest('POST', Uri.parse(apiUrl));
        request.files.add(await http.MultipartFile.fromPath('file', _imagePath!));

        final response = await request.send();
        if (response.statusCode == 200) {
          final responseBody = await response.stream.transform(utf8.decoder).join();
          final jsonResponse = jsonDecode(responseBody);
          setState(() {
            _prediction = jsonResponse['prediction'].toString();
            _isLoading = false; // Finaliza o carregamento
          });
        } else {
          print('Erro ao enviar a imagem: ${response.reasonPhrase}');
          setState(() {
            _isLoading = false; // Garante que o carregamento seja finalizado mesmo em caso de erro
          });
        }
      } else {
        print('Falha ao capturar a imagem ou obter o caminho da imagem.');
        setState(() {
          _isLoading = false; // Garante que o carregamento seja finalizado em caso de falha na obtenção do caminho da imagem
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false; // Garante que o carregamento seja finalizado em caso de exceção
      });
      return;
    }
  }

  void _closePhotoAndShowCamera() {
    setState(() {
      _showCapturedPhoto = false;
      _capturedPhoto = null;
      _isLoading = false;
      _isPhotoShown = false; // Atualiza o estado para não mostrar a foto
    });
  }

  void _addPredictionToHistory(String fileName, String objectName, String volumeInMl) {
    print('$fileName, $objectName, $volumeInMl');
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final colorButton = const Color(0xFF448AB5);
  final colorGradient1 = const Color(0xFF448AB5);
  final colorGradient2 = const Color(0xFF1E3C4F);
  final colorButtonSelected = const Color(0xFF20A4F3);
  final colorWhite = const Color(0xFFF8F8FF);
  final colorTransparent = Colors.transparent;

 @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Stack(
        children: [
          Visibility(
            visible:!_showCapturedPhoto || _capturedPhoto == null,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 60.0),
                child: CameraPreview(_controller),
              ),
            ),
          ),
      if (_showCapturedPhoto && _capturedPhoto!= null)
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: Stack(
              alignment: Alignment.center, // Centraliza todos os filhos do Stack
              children: [
                Image.file(
                  File(_capturedPhoto!.path),
                  fit: BoxFit.cover,
                  width: double.infinity, // Faz a imagem ocupar toda a largura disponível
                ),
                // Usando o operador ternário para decidir entre o CircularProgressIndicator e o widget Text
                _isLoading
                ? const CircularProgressIndicator() // Indicador de carregamento
                  : Positioned(
                    bottom: 100, // Posiciona o texto abaixo do centro
                    left: 0,
                    right: 0,
                    child: Text(
                      '${(_prediction?? 'Carregando...').isEmpty? '0' : ((double.tryParse(_prediction?? '')?? 0) * 1000).round().toString()} ml',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
              ],
            ),
          ),
        ),
          Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 150,
              backgroundColor: Colors.transparent,
              flexibleSpace: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                        scaffoldContext: context,
                        content: const Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(15),
                        width: 60,
                        height: 40,
                        color: colorButton,
                        onPressed: () => _scaffoldKey.currentState!.openDrawer(),
                      ),
                      CustomButton(
                        scaffoldContext: context,
                        content: _isPhotoShown ? 
                          const Icon(
                            Icons.close, color: 
                            Colors.white,) :  
                          const Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        borderRadius: BorderRadius.circular(15),
                        width: 60,
                        height: 40,
                        color: colorButton,
                        onPressed: _isPhotoShown ? 
                          _closePhotoAndShowCamera : 
                          () async {
                          final isLoggedIn = await AuthSharedPreferences.loadLoggedInState();
                          if (isLoggedIn) {
                            // Redirecionar para a tela de perfil se o usuário estiver logado
                            Navigator.pushNamed(context, '/profile');
                          } else {
                            Navigator.pushNamed(context, '/signin');
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            drawer: const CustomSideMenu(),
            body: Column(
              children: [
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButton(
                        scaffoldContext: context,
                        content: const Icon(
                          Icons.flip_camera_ios,
                          size: 35,
                          color: Colors.white,
                        ),
                        width: 50,
                        height: 50,
                        color: colorButton,
                        borderRadius: BorderRadius.circular(50),
                        onPressed: () => {},
                      ),
                      CustomButton(
                        scaffoldContext: context,
                        content: const Icon(
                          Icons.camera,
                          size: 35,
                          color: Colors.white,
                        ),
                        width: 50,
                        height: 50,
                        color: colorButton,
                        borderRadius: BorderRadius.circular(50),
                        onPressed: _takePicture,
                      ),
                      CustomButton(
                        scaffoldContext: context,
                        content: const Icon(
                          Icons.add_rounded,
                          size: 35,
                          color: Colors.white,
                        ),
                        width: 50,
                        height: 50,
                        color: colorButton,
                        borderRadius: BorderRadius.circular(50),
                        onPressed: () {
                          if (_imagePath != null) {
                            final volumeInMl = (double.tryParse(_prediction!)! * 1000).round().toString(); // Use '0' como padrão se a previsão não estiver disponível
                            _addPredictionToHistory(_imagePath!.split('/').last, "objeto", volumeInMl);
                          } else {
                            print('Falha ao capturar a imagem ou obter a previsão');
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            bottomNavigationBar: CustomBottomNavigationBar(
              firstIcon: Icon(
                CupertinoIcons.cube,
                size: 30,
                color: colorButtonSelected,
              ),
              firstText: Text(
                "Volume",
                style: TextStyle(
                  fontSize: 12,
                  color: colorButtonSelected
                ),
              ),
              secondIcon: Icon(
                Icons.history,
                size: 33,
                color: colorWhite,
              ),
              secondText: Text(
                "Histórico",
                style: TextStyle(
                  fontSize: 12,
                  color: colorWhite
                ),
              ),
              linearGradient: LinearGradient(
                colors: [colorGradient1, colorGradient2],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15), 
                topRight: Radius.circular(15)
              ),
              onPressed: () => {},
            ),
          ),
        ],
      );
    }
  }

}