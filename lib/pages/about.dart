import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volumetrica/widgets/custom_button.dart';
import 'package:volumetrica/widgets/custom_developer_info.dart';

class AboutPage extends StatelessWidget {
 const AboutPage({super.key});
 static const colorButton = Color(0xFF448AB5);
 static const colorLogo = Color(0xFF1E3C4F);

 @override
 Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
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
          ),
          Builder(
            builder: (BuildContext context) {
              return Container(
                margin: const EdgeInsets.only(
                  top: 65,
                  left: 30
                ),
                child: CustomButton(
                  scaffoldContext: context,
                  content: const Icon(
                    Icons.arrow_back_ios_sharp,
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  width: 60,
                  height: 40,
                  color: colorButton,
                  onPressed: () => {
                    Navigator.pushNamed(context, '/home')
                  },
                ),
              );
            }
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 80),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                         CupertinoIcons.cube_fill,
                         color: colorLogo,
                         size: 45,
                        ),
                        Text(
                         'Volumetrica',
                         style: TextStyle(
                            color: colorLogo,
                            fontFamily: 'Inter',
                            fontSize: 36,
                            fontWeight: FontWeight.bold
                         ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 18),
                  SizedBox(
                    height: 250,
                    width: 350,
                    child: Text(
                      'É um projeto realizado por estudantes do curso de Ciência da Computação da Pontifícia Universidade Católica de Minas Gerais (PUC-MG), na disciplina chamada Laboratório de Desenvolvimento para Dispositivos Móveis, ministrada pelo professor Ilo Amy Saldanha Rivero.',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: colorLogo
                      ),
                    )
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    child: Column(
                      children: [
                        SizedBox(
                          child: Text(
                            "Desenvolvedores",
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: colorLogo,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        CustomDeveloperInfo(
                          photo: AssetImage('assets/images/joao.jpg'),
                          name: 'João Paulo de Castro Markiewicz',
                          responsibility: '(Back-end)',
                          textColor: colorLogo,
                        ),
                        SizedBox(height: 20),
                        CustomDeveloperInfo(
                          photo: AssetImage('assets/images/lara.jpg'),
                          name: 'Lara Brígida Rezende Souza',
                          responsibility: '(Front-end e back-end)',
                          textColor: colorLogo,
                        ),
                        SizedBox(height: 20),
                        CustomDeveloperInfo(
                          photo: AssetImage('assets/images/matheus.jpeg'),
                          name: 'Matheus Moreira Sorrentino',
                          responsibility: '(Front-end e back-end)',
                          textColor: colorLogo,
                        ),
                        SizedBox(height: 20),
                        CustomDeveloperInfo(
                          photo: AssetImage('assets/images/thiago.jpg'),
                          name: 'Thiago Cedro Silva de Souza',
                          responsibility: '(Back-end)',
                          textColor: colorLogo,
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
 }
}
