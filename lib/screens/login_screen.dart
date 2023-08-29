/*import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {

  static const routeName = 'pokemon-login';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pokedex Login'),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              const Icon(size: 200, Icons.person),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Usuario'),
              ),
              TextFormField(
                decoration: const  InputDecoration(labelText: 'Clave'),
                obscureText: true,
              ),
              ElevatedButton(
                onPressed: (){},
                child: const Text('Iniciar Sesión'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pokedex_mobile/providers/login_provider.dart'; // Importa el provider de inicio de sesión

class LoginScreen extends StatelessWidget {
  static const routeName = 'pokemon-login';
  
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthenticationRepository>(context); // Obtén una instancia del LoginProvider

    // Controladores para los campos de usuario y contraseña
    final TextEditingController userController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Pokedex Login'),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              const Icon(size: 200, Icons.person),
              TextFormField(
                controller: userController, // Asigna el controlador al campo de usuario
                decoration: const InputDecoration(labelText: 'Usuario'),
              ),
              TextFormField(
                controller: passwordController, // Asigna el controlador al campo de contraseña
                decoration: const  InputDecoration(labelText: 'Clave'),
                obscureText: true,
              ),
              ElevatedButton(
                onPressed: () {
                  // Aquí puedes llamar al método de inicio de sesión del provider
                  loginProvider.logInWithEmailAndPassword(email: userController.text, password: passwordController.text );
                },
                child: const Text('Iniciar Sesión'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
