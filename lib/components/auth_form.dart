import 'package:flutter/material.dart';
import 'package:flutter_cod3r_chat/models/auth_form_data.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthFormData) onSubmit;
  const AuthForm({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _formData = AuthFormData();

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    widget.onSubmit(_formData);
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
                  validator: (name) {
                    final nameToValidate = name ?? '';

                    if (nameToValidate.trim().length < 5) {
                      return 'Nome deve ter no mínimo 5 caracteres';
                    }

                    return null;
                  },
                ),
              TextFormField(
                key: ValueKey('email'),
                onChanged: (email) => _formData.email = email,
                initialValue: _formData.email,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                ),
                validator: (email) {
                  final emailToValidate = email ?? '';

                  if (!emailToValidate.contains('@')) {
                    return 'E-mail informado não é valido';
                  }

                  return null;
                },
              ),
              TextFormField(
                key: ValueKey('password'),
                onChanged: (password) => _formData.password = password,
                initialValue: _formData.password,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha',
                ),
                validator: (password) {
                  final passwordToValidate = password ?? '';

                  if (passwordToValidate.length < 6) {
                    return 'Senha deve ter no mínimo 6 caracteres';
                  }

                  return null;
                },
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
