import 'package:flutter/material.dart';
import 'package:flutter_cod3r_chat/models/auth_form_data.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _formData = AuthFormData();

  void _submit() {
    _formKey.currentState?.validate();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (_formData.isSignup)
                TextFormField(
                  key: ValueKey('name'),
                  onChanged: (name) => _formData.name = name,
                  initialValue: _formData.name,
                  decoration: InputDecoration(
                    labelText: 'Nome',
                  ),
                ),
              TextFormField(
                key: ValueKey('email'),
                onChanged: (email) => _formData.email = email,
                initialValue: _formData.email,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                ),
              ),
              TextFormField(
                key: ValueKey('password'),
                onChanged: (password) => _formData.password = password,
                initialValue: _formData.password,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha',
                ),
              ),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: _submit,
                child: Text(
                  _formData.isLogin ? 'Entrar' : 'Cadastrar',
                ),
              ),
              TextButton(
                child: Text(
                  _formData.isLogin
                      ? 'Criar uma nova conta?'
                      : 'Já possui conta?',
                ),
                onPressed: () {
                  setState(() {
                    _formData.togleAuthMode();
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
