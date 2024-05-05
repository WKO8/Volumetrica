import 'package:flutter/material.dart';
import 'package:volumetrica/others/database.dart'; // Importe o seu arquivo de banco de dados

class DatabaseManager extends ChangeNotifier {
  final Database db = const Database();
  List<Map<String, dynamic>> _userData = [];

  List<Map<String, dynamic>> get userData => _userData;

  Future<void> saveData(String email, String password) async {
    await db.saveData(email, password);
    notifyListeners();
  }

  Future<void> listUsers() async {
    // Se a lista de usuários estiver vazia, resetar os IDs
    if (userData.isEmpty) {
      await db.resetIds();
    }
    // Se não, continuar normalmente
    _userData = await db.listUsers();
    notifyListeners();
  }

  Future<void> listUniqueUser(int id) async {
    await db.listUniqueUser(id);
    notifyListeners();
  }

  Future<void> deleteUser(int id) async {
    await db.excluirUsuario(id);
    await db.decrementIds(id);
    notifyListeners();
  }

  Future<void> deleteUserByEmail(String email) async {
    await db.deleteUser(email);
    notifyListeners();
  }

  Future<void> updateUser(int id, String email, String password) async {
    await db.updateUser(id, email, password);
    notifyListeners();
  }
}