import 'package:flutter/material.dart';
import 'package:volumetrica/others/auth_shared_preference.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final Icon firstIcon;
  final Icon secondIcon;
  final Text firstText;
  final Text secondText;
  final Color? backgroundColor;
  final LinearGradient? linearGradient;
  final BorderRadius? borderRadius;
  final MainAxisAlignment mainAxisAlignment;
  final VoidCallback? onPressed;

  const CustomBottomNavigationBar({
    Key? key,
    required this.firstIcon,
    required this.secondIcon,
    this.firstText = const Text(""),
    this.secondText = const Text(""),
    this.backgroundColor = Colors.grey,
    this.linearGradient,
    this.borderRadius,
    this.mainAxisAlignment = MainAxisAlignment.spaceEvenly,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<CustomBottomNavigationBar> createState() =>
      CustomBottomNavigationBarState();
}

class CustomBottomNavigationBarState
    extends State<CustomBottomNavigationBar> {
  late final BorderRadius borderRadius;
  late final bool hasLinearGradient;
  bool isExpanded = false; // Adicionado estado para controlar a expansão
  bool isLoggedIn = false; // Adicionado estado para controlar o login

  @override
  void initState() {
    super.initState();
    borderRadius = widget.borderRadius ??
        const BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15));
    hasLinearGradient = widget.linearGradient != null;
    _loadLoginState(); // Carrega o estado de login ao inicializar o widget
  }

  void toggleExpansion() {
    setState(() {
      isExpanded = !isExpanded; // Alterna o estado de expansão
    });
  }

  Future<void> _loadLoginState() async {
    final bool loggedInState = await AuthSharedPreferences.loadLoggedInState();
    setState(() {
      isLoggedIn = loggedInState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isExpanded) {
          toggleExpansion(); // Fecha o widget expandido se já estiver expandido
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300), // Animação de expansão
        height: isExpanded ? MediaQuery.of(context).size.height / 2 : 70, // Ajusta a altura com base no estado de expansão
        decoration: hasLinearGradient
            ? BoxDecoration(
                gradient: widget.linearGradient,
                borderRadius: widget.borderRadius)
            : BoxDecoration(color: widget.backgroundColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end, // Alinha os filhos na parte inferior
          children: [
            if (isExpanded) ...[
              // Tabela
              Expanded(
                child: DataTable(
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Text(
                        'Data',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Recipiente',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Volume',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                  rows: const <DataRow>[
                    DataRow(
                      cells: <DataCell>[
                        DataCell(
                            Text('01/01/2023', style: TextStyle(color: Colors.white))),
                        DataCell(
                            Text('Recipiente 1', style: TextStyle(color: Colors.white))),
                        DataCell(
                            Text('100 ml', style: TextStyle(color: Colors.white))),
                      ],
                    ),
                    // Adicione mais DataRows conforme necessário
                  ],
                ),
              ),
              // Texto clicável
              if (!isLoggedIn) // Mostra o texto apenas se não estiver logado
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: InkWell(
                    onTap: () => Navigator.pushNamed(context, '/signin'),
                    child: const Text.rich(
                      TextSpan(
                        text: 'Faça ',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'login',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.white,
                            ),
                          ),
                          TextSpan(
                            text: ' para salvar o histórico',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
            // Botões
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: widget.mainAxisAlignment,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(widget.firstIcon.icon,
                          color: isExpanded
                              ? Colors.white
                              : const Color(0xFF20A4F3)),
                      Text(widget.firstText.data ?? "",
                          style: TextStyle(
                              color: isExpanded
                                  ? Colors.white
                                  : const Color(0xFF20A4F3)))
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      toggleExpansion(); // Chama o método para alternar a expansão
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(widget.secondIcon.icon,
                            color: isExpanded
                                ? const Color(0xFF20A4F3)
                                : Colors.white),
                        Text(widget.secondText.data ?? "",
                            style: TextStyle(
                                color: isExpanded
                                    ? const Color(0xFF20A4F3)
                                    : Colors.white))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}