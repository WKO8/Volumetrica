import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volumetrica/others/database_manager.dart';

class UsersManagementPage extends StatelessWidget {
  const UsersManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciamento de Usuários'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Adicionar Usuário
            const AddUserForm(),
            const SizedBox(height: 20),
            // Listar Usuários
            ElevatedButton(
              onPressed: () async {
                await Provider.of<DatabaseManager>(context, listen: false)
                    .listUsers();
              },
              child: const Text('Listar Usuários'),
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
        TextField(
          controller: emailController,
          decoration: const InputDecoration(labelText: 'Email do Usuário'),
        ),
        TextField(
          controller: passwordController,
          decoration: const InputDecoration(labelText: 'Senha do Usuário'),
          obscureText: true,
        ),
        ElevatedButton(
          onPressed: () async {
            await Provider.of<DatabaseManager>(context, listen: false)
                .saveData(emailController.text, passwordController.text);
            emailController.clear();
            passwordController.clear();
            await Provider.of<DatabaseManager>(context, listen: false)
                .listUsers(); // Atualizar a lista de usuários
          },
          child: const Text('Adicionar Usuário'),
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
    return ListTile(
      title: Text('ID: ${user['id']}'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Email: ${user['email']}'),
          Text('Senha: ${user['password']}'),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
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
            icon: const Icon(Icons.delete),
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