import 'package:shared_preferences/shared_preferences.dart';

class AuthSharedPreferences {
  static const String isLoggedInKey = 'isLoggedIn';

  static Future<void> saveLoggedInState(bool isLoggedIn) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool(isLoggedInKey, isLoggedIn);
      print('Valor salvo com sucesso: $isLoggedIn');
    } catch (error) {
      print('Erro ao salvar o valor: $error');
    }
  }

  static Future<bool> loadLoggedInState() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getBool(isLoggedInKey) ?? false;
    } catch (error) {
      print('Erro ao carregar o valor: $error');
      return false;
    }
  }
}