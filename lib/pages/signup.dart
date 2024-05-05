import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:volumetrica/others/database_manager.dart';
import 'package:volumetrica/widgets/custom_button.dart';
import 'package:volumetrica/widgets/custom_text_field.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF20A4F3), // Cor inicial do gradiente
                Color(0xFFAFD3E9), // Cor final do gradiente
              ],
            ),
          ),
          child: Column(
            children: [
              // Primeiro container: Header com ícone
              Container(
                height: 190,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(100),
                    bottomRight: Radius.circular(100),
                  ),
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.cube_fill,
                        size: 50,
                        color: Color(0xFF448AB5),
                      ),
                      Text(
                        "Volumetrica",
                        style: TextStyle(
                          color: Color(0xFF448AB5),
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              // Segundo container: Campos de entrada e textos clicáveis
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 55),
                  child: Column(
                    children: [
                      CustomTextField(
                        text: 'Email',
                        editingController: emailController,
                        textStyle: const TextStyle(
                          color: Color(0xFF448AB5),
                          fontSize: 18,
                        ),
                        backgroundColor: Colors.white,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          borderSide: BorderSide.none,
                        ),
                        icon: const Icon(
                          CupertinoIcons.mail_solid,
                          color: Color(0xFF448AB5),
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        text: 'Senha',
                        editingController: passwordController,
                        textStyle: const TextStyle(
                          color: Color(0xFF448AB5),
                          fontSize: 18,
                        ),
                        backgroundColor: Colors.white,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          borderSide: BorderSide.none,
                        ),
                        icon: const Icon(
                          CupertinoIcons.eye_fill,
                          color: Color(0xFF448AB5),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const CustomTextField(
                        text: 'Repetir senha',
                        textStyle: TextStyle(
                          color: Color(0xFF448AB5),
                          fontSize: 18,
                        ),
                        backgroundColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      const SizedBox(height: 60),
                      Consumer<DatabaseManager>(
                        builder: (context, databaseManager, child) {
                          return CustomButton(
                            scaffoldContext: context,
                            content: const Text(
                              'Cadastrar',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                                fontSize: 18,
                              ),
                            ),
                            borderRadius: BorderRadius.circular(50),
                            width: 400,
                            height: 50,
                            color: Colors.white,
                            onPressed: () async {
                              // Verificar se os campos de texto estão preenchidos
                              if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
                                // Salvar dados do novo usuário
                                await Provider.of<DatabaseManager>(context, listen: false)
                                    .saveData(emailController.text, passwordController.text);
                                // Limpar campos de texto
                                emailController.clear();
                                passwordController.clear();
                                Navigator.pushNamed(context, '/signin');
                              } else {
                                // Exibir mensagem de erro se os campos estiverem vazios
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Por favor, preencha todos os campos.'),
                                  ),
                                );
                              }
                            },
                          );
                        },
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/signin');
                        },
                        child: RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: 'Já tem uma conta? ',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              TextSpan(
                                text: 'Entrar',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Terceiro container: Botão de login
              Container(
                height: 90,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(80),
                    topRight: Radius.circular(80),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}