import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volumetrica/services/authentication.dart';
import 'package:volumetrica/widgets/custom_button.dart';
import 'package:volumetrica/others/auth_shared_preference.dart'; // Importe o arquivo de autenticação

class CustomSideMenu extends StatefulWidget {
  const CustomSideMenu({super.key});

  @override
  State<CustomSideMenu> createState() => _CustomSideMenuState();
}

class _CustomSideMenuState extends State<CustomSideMenu> {
  late bool isLoggedIn = false; // Adicionado estado para controlar o login

  final ValueNotifier<int> _selectedIndexNotifier = ValueNotifier<int>(0); // Initialize the selected index to 0 (or any default index)
  final AuthService authService = AuthService();
  
  @override
  void initState() {
    super.initState();
    _loadLoginState();
  }

  Future<void> _loadLoginState() async {
    final bool loggedInState = await AuthSharedPreferences.loadLoggedInState();
    setState(() {
      isLoggedIn = loggedInState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFAFD3E9), Color(0xFF20A4F3)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  Theme(
                    data: Theme.of(context).copyWith(
                      dividerTheme: const DividerThemeData(color: Colors.transparent),
                    ),
                    child: DrawerHeader(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 40.0, left: 15.0),
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
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 100.0),
                      child: ValueListenableBuilder<int>(
                        valueListenable: _selectedIndexNotifier,
                        builder: (context, selectedIndex, child) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              // home page list tile
                              _buildListTile(
                                icon: CupertinoIcons.cube_fill,
                                text: "Volume",
                                index: 0,
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.pushNamed(context, '/home');
                                },
                              ),
                              const SizedBox(height: 20),
                              // history page list tile
                              _buildListTile(
                                icon: Icons.history,
                                text: "Histórico",
                                index: 1,
                                onTap: () {
                                  // Navigator.pop(context);
                                  // Navigator.pushNamed(context, '/home'); // Assuming you want to navigate to the home page with history opened
                                },
                              ),
                              const SizedBox(height: 20),
                              // about page list tile
                              _buildListTile(
                                icon: Icons.info_outline,
                                text: "Sobre",
                                index: 2,
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.pushNamed(context, '/about');
                                },
                              ),
                              const SizedBox(height: 20),
                              // logout list tile (only if isLoggedIn is true)
                              if (isLoggedIn)
                                _buildListTile(
                                  icon: Icons.logout,
                                  text: "Logout",
                                  index: 3,
                                  onTap: () {
                                    _confirmLogout(context);
                                  },
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile({required IconData icon, required String text, required int index, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(
        icon,
        size: 30,
        color: _selectedIndexNotifier.value == index ? const Color(0xFF448AB5) : Colors.white,
      ),
      title: Text(
        text,
        style: TextStyle(
          color: _selectedIndexNotifier.value == index ? const Color(0xFF448AB5) : Colors.white,
          fontSize: 20,
        ),
      ),
      onTap: () {
        _selectedIndexNotifier.value = index; // Update the selected index without setState
        onTap();
      },
    );
  }

  Future<void> _logout(BuildContext context) async {
    await AuthSharedPreferences.saveLoggedInState(false); // Altera o estado de isLoggedIn para false
    authService.signOut();
    setState(() {
      isLoggedIn = false;
    });
  }

  Future<void> _confirmLogout(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero, // Remove o preenchimento interno do conteúdo
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.width * 0.7, // Defina a largura do container como 70% da largura da tela
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min, // Define o tamanho principal para o mínimo
                children: [
                  const Text(
                    'Confirmar Logout',
                    style: TextStyle(
                      fontSize: 22,
                      color: Color(0xFF448AB5), // Define a cor do título
                      fontWeight: FontWeight.bold, // Define o título em negrito
                    ),
                  ),
                  const SizedBox(height: 20), // Adiciona um espaçamento entre o título e o texto
                  const Text(
                    'Tem certeza que deseja fazer logout?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF448AB5), // Define a cor do texto
                    ),
                    textAlign: TextAlign.center, // Centraliza o texto
                  ),
                  const SizedBox(height: 20), // Adiciona um espaçamento entre o texto e os botões
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center, // Centraliza os botões
                    children: [
                      Expanded( // Garante que os botões tenham o mesmo tamanho
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.035), // Define o espaçamento lateral dos botões como 10% do tamanho do Dialog
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.blue, // Define o background azul
                            ),
                            child: const Text(
                              'Cancelar',
                              style: TextStyle(
                                color: Colors.white, // Define a cor do texto como branco
                                fontWeight: FontWeight.bold, // Define o botão em negrito
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 20), // Adiciona um espaçamento entre os botões
                      Expanded( // Garante que os botões tenham o mesmo tamanho
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.035), // Define o espaçamento lateral dos botões como 10% do tamanho do Dialog
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.red, // Define o background vermelho
                            ),
                            child: const Text(
                              'Logout',
                              style: TextStyle(
                                color: Colors.white, // Define a cor do texto como branco
                                fontWeight: FontWeight.bold, // Define o botão em negrito
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