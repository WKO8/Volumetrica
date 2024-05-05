import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volumetrica/others/database_manager.dart';

class UsersManagementPage extends StatelessWidget {
  const UsersManagementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFAFD3E9), // Cor final do gradiente
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 65), // Espaçamento para posicionar o botão na parte superior esquerda
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 60,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xFF448AB5),
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Conteúdo da tela de gerenciamento de usuários
                    // Adicionar Usuário
                    const AddUserForm(),
                    const SizedBox(height: 20),
                    // Listar Usuários
                    ElevatedButton(
                      onPressed: () async {
                        await Provider.of<DatabaseManager>(context, listen: false)
                            .listUsers();
                      },
                      child: const Text(
                        'Listar Usuários',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF448AB5)
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Listagem de Usuários
                    Expanded(
                      child: Consumer<DatabaseManager>(
                        builder: (context, databaseManager, _) {
                          final users = databaseManager.userData;
                          return ListView.builder(
                            itemCount: users.length,
                            itemBuilder: (context, index) {
                              final user = users[index];
                              return UserTile(user: user);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddUserForm extends StatefulWidget {
  const AddUserForm({Key? key}) : super(key: key);

  @override
  _AddUserFormState createState() => _AddUserFormState();
}

class _AddUserFormState extends State<AddUserForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 20),
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
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () async {
            await Provider.of<DatabaseManager>(context, listen: false)
                .saveData(emailController.text, passwordController.text);
            emailController.clear();
            passwordController.clear();
            await Provider.of<DatabaseManager>(context, listen: false)
                .listUsers(); // Atualizar a lista de usuários
          },
          child: const Text(
            'Adicionar Usuário',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF448AB5)
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

class UserTile extends StatelessWidget {
  final Map<String, dynamic> user;

  const UserTile({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2, // Adiciona uma sombra ao card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Borda arredondada
      ),
      child: ListTile(
        title: Text(
          'ID: ${user['id']}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF448AB5), // Definindo fontWeight como 400
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email: ${user['email']}',
              style: const TextStyle(
                fontWeight: FontWeight.w400, // Definindo fontWeight como 400
              ),
            ),
            Text(
              'Senha: ${user['password']}',
              style: const TextStyle(
                fontWeight: FontWeight.w400, // Definindo fontWeight como 400
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(
                Icons.edit,
                color: Color(0xFF448AB5),
              ),
              onPressed: () async {
                final newUserData = await showDialog<Map<String, String>>(
                  context: context,
                  builder: (BuildContext context) {
                    return EditUserDialog(
                      currentEmail: user['email'],
                      currentPassword: user['password'],
                    );
                  },
                );

                if (newUserData != null) {
                  final newEmail = newUserData['email'];
                  final newPassword = newUserData['password'];
                  await Provider.of<DatabaseManager>(context, listen: false)
                      .updateUser(user['id'], newEmail!, newPassword!);
                  await Provider.of<DatabaseManager>(context, listen: false)
                      .listUsers(); // Atualizar a lista de usuários
                }
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Confirmar exclusão'),
                      content: const Text('Tem certeza que deseja excluir este usuário?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () async {
                            Provider.of<DatabaseManager>(context, listen: false)
                                .deleteUser(user['id']);
                            Navigator.of(context).pop();
                            await Provider.of<DatabaseManager>(context, listen: false)
                                .listUsers(); // Atualizar a lista de usuários
                          },
                          child: const Text('Confirmar'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class EditUserDialog extends StatefulWidget {
  final String currentEmail;
  final String currentPassword;

  const EditUserDialog({
    Key? key,
    required this.currentEmail,
    required this.currentPassword,
  }) : super(key: key);

  @override
  _EditUserDialogState createState() => _EditUserDialogState();
}

class _EditUserDialogState extends State<EditUserDialog> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(text: widget.currentEmail);
    passwordController = TextEditingController(text: widget.currentPassword);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Editar Usuário'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: emailController,
            decoration: const InputDecoration(labelText: 'Novo Email'),
          ),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(labelText: 'Nova Senha'),
            obscureText: true,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            final newEmail = emailController.text;
            final newPassword = passwordController.text;
            Navigator.of(context).pop({'email': newEmail, 'password': newPassword});
          },
          child: const Text('Salvar'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}