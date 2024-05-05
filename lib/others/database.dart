import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:crypto/crypto.dart';

class Database extends StatelessWidget {
  const Database({Key? key});

  _getDatabase() async {
    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados = join(caminhoBancoDados, "volumetrica.db");
    var db = await openDatabase(
        localBancoDados,
        version: 1,
        onCreate: (db, dbVersaoRecente){
          String sql = "CREATE TABLE users (id INTEGER PRIMARY KEY AUTOINCREMENT, email VARCHAR[255], password VARCHAR[255]) ";
          db.execute(sql);
        }
    );
      return db;
      //print("aberto: " + bd.isOpen.toString() );
    }
   
   Future<void> resetIds() async {
    // Resetar os IDs para começar do 1
    final db = await _getDatabase();
    await db.execute('UPDATE sqlite_sequence SET seq = 0 WHERE name = "users"');
   }

   Future<void> saveData(String email, String password) async {
    final db = await _getDatabase();
    
    // Criptografar a senha usando SHA-256
    final senhaCriptografada = _hashPassword(password);

    final dadosUsuario = {
      "email": email,
      "password": senhaCriptografada,
    };

    await db.transaction((txn) async {
      final id = await txn.insert("users", dadosUsuario);
      print("Salvo: $id");
    });
  }

  String _hashPassword(String password) {
    // Calcular o hash SHA-256 da senha
    var bytes = utf8.encode(password); // Codifica a senha como bytes
    var hash = sha256.convert(bytes); // Calcula o hash SHA-256
    return hash.toString(); // Retorna o hash como uma string hexadecimal
  }

  Future<bool> validateUser(String email, String password) async {
    final db = await _getDatabase();
    final encryptedPassword = _hashPassword(password);
    final users = await db.query(
      "users",
      where: "email = ? AND password = ?",
      whereArgs: [email, encryptedPassword],
    );
    return users.isNotEmpty;
  }

  Future<List<Map<String, dynamic>>> listUsers() async {
    final db = await _getDatabase();
    const sql = "SELECT * FROM users";
    final users = await db.rawQuery(sql);
    return users;
  }

  Future<void> listUniqueUser(int id) async{
    final db = await _getDatabase();
    List<Map> users = await db.query(
      "users",
      columns: ["id", "email", "password"],
      where: "id = ?",
      whereArgs: [id]
    );
    for(var usu in users){
      print("id: ${usu['id']} email: ${usu['email']} password: ${usu['password']}");
    }
  }

  Future<void> excluirUsuario(int id) async{
    final db = await _getDatabase();
    int retorno = await db.delete(
        "users",
        where: "id = ?",  //caracter curinga
        whereArgs: [id]
    );
    print("Itens excluidos: $retorno");
  }

  Future<void> deleteUser(String email) async{
    final db = await _getDatabase();
    int retorno = await db.delete(
        "users",
        where: "email = ?",  //caracter curinga
        whereArgs: [email]
    );
    print("Itens excluidos: $retorno");
  }

  Future<void> decrementIds(int deletedId) async {
    // Decrementar IDs dos usuários com ID maior que o ID excluído
    final db = await _getDatabase();
    await db.rawUpdate('UPDATE users SET id = id - 1 WHERE id > ?', [deletedId]);
  }

  Future<void> updateUser(int id, String email, String password) async {
    final db = await _getDatabase();
    Map<String, dynamic> dadosUsuario = {
      "email": email,
      "password": password,
    };
    int retorno = await db.update(
      "users",
      dadosUsuario,
      where: "id = ?", //caracter curinga
      whereArgs: [id],
    );
    print("Itens atualizados: $retorno");
  }


  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}