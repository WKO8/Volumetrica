import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SignIn extends StatelessWidget {
 const SignIn({super.key});

 @override
 Widget build(BuildContext context) {
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
                    const TextField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          color: Color(0xFF448AB5),
                          fontSize: 18
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          borderSide: BorderSide.none
                        ), // Remove a borda do TextField para evitar conflitos
                        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15), // Adiciona padding interno
                        suffixIcon: Icon(
                          CupertinoIcons.mail_solid,
                          color: Color(0xFF448AB5),
                        )
                      ),
                    ),
                    const SizedBox(height: 20),
                    const TextField(
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        labelStyle: TextStyle(
                          color: Color(0xFF448AB5),
                          fontSize: 18
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          borderSide: BorderSide.none
                        ), // Remove a borda do TextField para evitar conflitos
                        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15), // Adiciona padding interno
                        suffixIcon: Icon(
                          CupertinoIcons.eye_fill,
                          color: Color(0xFF448AB5),
                        )
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextButton(
                      onPressed: () {
                        // Implemente a lógica para recuperação de senha aqui
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
                    TextButton(
                      onPressed: () {
                        // Implemente a lógica para login aqui
                        Navigator.pushNamed(context, '/home');
                      },
                      child: Container(
                        height: 50,
                        width: 1000,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(50))
                        ),
                        child: const Center(
                          child: Text(
                              'Entrar',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue, 
                                fontSize: 18
                              ),
                          ),
                        ),
                      ),
                    ),
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
