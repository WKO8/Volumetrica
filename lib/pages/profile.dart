import 'package:flutter/material.dart';
import 'package:volumetrica/others/auth_shared_preference.dart';
import 'package:volumetrica/others/database_manager.dart'; // Importe o seu arquivo de banco de dados

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFAFD3E9), // Cor final do gradiente
              Color(0xFF20A4F3), // Cor inicial do gradiente
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/user_avatar.png'),
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
                        style: TextStyle(fontSize: 18, color: Colors.red),
                      );
                    } else if (snapshot.hasData) {
                      final email = snapshot.data!['email'];
                      return Text(
                        'Email: $email',
                        style: const TextStyle(fontSize: 18),
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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "Histórico",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _logout(context);
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
}