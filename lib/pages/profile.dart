import 'package:flutter/material.dart';
import 'package:volumetrica/others/auth_shared_preference.dart';
import 'package:volumetrica/others/database_manager.dart';
import 'package:volumetrica/widgets/custom_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFAFD3E9), // Cor final do gradiente
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 65), // Espaçamento para posicionar o botão na parte superior esquerda
            child: CustomButton(
              scaffoldContext: context,
              content: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              width: 60,
              height: 40,
              borderRadius: BorderRadius.circular(15),
              color: const Color(0xFF448AB5),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/images/user_avatar.png'),
                    ),
                    const SizedBox(height: 20),
                    FutureBuilder<Map<String, dynamic>>(
                      future: _getUserData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return const Text(
                            'Erro ao carregar dados',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          );
                        } else if (snapshot.hasData) {
                          final email = snapshot.data!['email'];
                          return Text(
                            'Email: $email',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            ),
                          );
                        } else {
                          return const Text(
                            'Dados não encontrados',
                            style: TextStyle(fontSize: 18, color: Colors.red),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Histórico:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    const Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "Histórico",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _confirmLogout(context); // Chamando a função para confirmar o logout
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, 
                        backgroundColor: Colors.red,
                      ),
                      child: const Text('Logout'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<Map<String, dynamic>> _getUserData() async {
    final databaseManager = DatabaseManager();
    await databaseManager.listUsers();
    final userData = databaseManager.userData;
    if (userData.isNotEmpty) {
      return userData.first;
    } else {
      return {};
    }
  }

  Future<void> _logout(BuildContext context) async {
    await AuthSharedPreferences.saveLoggedInState(false);
    Navigator.pushNamed(context, '/home');
  }

  Future<void> _confirmLogout(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero, // Removendo o preenchimento interno do conteúdo
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.width * 0.7, // Definindo a largura do container como 70% da largura da tela
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min, // Definindo o tamanho principal como mínimo
                children: [
                  const Text(
                    'Confirmar Logout',
                    style: TextStyle(
                      fontSize: 22,
                      color: Color(0xFF448AB5), // Definindo a cor do título
                      fontWeight: FontWeight.bold, // Definindo o título em negrito
                    ),
                  ),
                  const SizedBox(height: 20), // Adicionando um espaço entre o título e o texto
                  const Text(
                    'Tem certeza que deseja fazer logout?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF448AB5), // Definindo a cor do texto
                    ),
                    textAlign: TextAlign.center, // Centralizando o texto
                  ),
                  const SizedBox(height: 20), // Adicionando um espaço entre o texto e os botões
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center, // Centralizando os botões
                    children: [
                      Expanded( // Garantindo que os botões tenham o mesmo tamanho
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.035), // Definindo o espaçamento lateral dos botões como 10% do tamanho do Dialog
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.blue, // Definindo o background azul
                            ),
                            child: const Text(
                              'Cancelar',
                              style: TextStyle(
                                color: Colors.white, // Definindo a cor do texto como branco
                                fontWeight: FontWeight.bold, // Definindo o botão em negrito
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 20), // Adicionando um espaço entre os botões
                      Expanded( // Garantindo que os botões tenham o mesmo tamanho
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.035), // Definindo o espaçamento lateral dos botões como 10% do tamanho do Dialog
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.red, // Definindo o background vermelho
                            ),
                            child: const Text(
                              'Logout',
                              style: TextStyle(
                                color: Colors.white, // Definindo a cor do texto como branco
                                fontWeight: FontWeight.bold, // Definindo o botão em negrito
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                              _logout(context);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}