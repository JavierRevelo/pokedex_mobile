import 'package:flutter/material.dart';

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
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(size: 200, Icons.person),
              TextFormField(
                //controller: _emailController,
                decoration: const InputDecoration(labelText: 'Usuario'),
              ),
              TextFormField(
                //controller: _passwordController,
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
}