import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:volumetrica/others/auth_shared_preference.dart';
import 'package:volumetrica/others/database.dart';
import 'package:volumetrica/widgets/custom_button.dart';
// import 'package:volumetrica/widgets/custom_text_field.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    void _login() async {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      const database = Database();
      final isValidUser = await database.validateUser(email, password);

      if (isValidUser) {
        // Login bem-sucedido, altere o estado de isLoggedIn para true
        await AuthSharedPreferences.saveLoggedInState(true);
        // Navegue para a próxima tela, por exemplo, a tela inicial
        Navigator.pushNamed(context, '/home');
      } else {
        // Exibir mensagem de erro ou toast informando que o login falhou
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email ou senha incorretos.'),
          ),
        );
      }
    }

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
              height: 230,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(200),
              ),
              ),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 50),
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
                          fontWeight: FontWeight.w600
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            // Segundo container: Campos de entrada e textos clicáveis
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 55),
                child: Column(
                  children: [   
                    // const CustomTextField(
                    //   text: 'Email',
                    //   textStyle: TextStyle(
                    //     color: Color(0xFF448AB5),
                    //     fontSize: 18
                    //   ),
                    //   backgroundColor: Colors.white,
                    //   border: OutlineInputBorder(
                    //     borderRadius: BorderRadius.all(Radius.circular(50)),
                    //     borderSide: BorderSide.none
                    //   ),
                    //   icon: Icon(
                    //     CupertinoIcons.mail_solid,
                    //     color: Color(0xFF448AB5),
                    //   )
                    // ),
                    TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: const TextStyle(color: Color(0xFF448AB5)), // Define a cor do rótulo para branco
                          hintStyle: const TextStyle(color: Colors.white), // Define a cor do texto de dica para branco
                          fillColor: Colors.white, // Define a cor de fundo do TextField para branco
                          filled: true, // Define para preencher o TextField com a cor de fundo
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white), // Define a cor da borda quando o TextField está habilitado
                            borderRadius: BorderRadius.circular(10), // Define a borda circular
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white), // Define a cor da borda quando o TextField está em foco
                            borderRadius: BorderRadius.circular(10), // Define a borda circular
                          ),
                        ),
                    ),
                    const SizedBox(height: 20),
                    // const CustomTextField(
                    //   text: 'Senha',
                    //   textStyle: TextStyle(
                    //     color: Color(0xFF448AB5),
                    //     fontSize: 18
                    //   ),
                    //   backgroundColor: Colors.white,
                    //   border: OutlineInputBorder(
                    //     borderRadius: BorderRadius.all(Radius.circular(50)),
                    //     borderSide: BorderSide.none
                    //   ),
                    //   icon: Icon(
                    //     CupertinoIcons.eye_fill,
                    //     color: Color(0xFF448AB5),
                    //   )
                    // ),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                          labelText: 'Senha',
                          labelStyle: const TextStyle(color: Color(0xFF448AB5)), // Define a cor do rótulo para branco
                          hintStyle: const TextStyle(color: Colors.white), // Define a cor do texto de dica para branco
                          fillColor: Colors.white, // Define a cor de fundo do TextField para branco
                          filled: true, // Define para preencher o TextField com a cor de fundo
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white), // Define a cor da borda quando o TextField está habilitado
                            borderRadius: BorderRadius.circular(10), // Define a borda circular
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white), // Define a cor da borda quando o TextField está em foco
                            borderRadius: BorderRadius.circular(10), // Define a borda circular
                          ),
                        ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 5),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/recovery');
                      },
                      child: const Text(
                        'Esqueci minha senha',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Builder(builder: (BuildContext context) {
                      return CustomButton(
                        scaffoldContext: context,
                        content: const Text(
                          'Entrar',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue, 
                            fontSize: 18
                          ),
                        ),
                        borderRadius: BorderRadius.circular(50),
                        width: 400,
                        height: 50,
                        color: Colors.white,
                        onPressed: () => {
                          _login()
                        },
                      );
                    }),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'Não tem conta? ',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white
                              )
                            ),
                            TextSpan(
                              text: 'Cadastre-se',
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
