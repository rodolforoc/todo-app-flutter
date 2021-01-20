import 'package:flutter/material.dart';
import 'package:todo_app/model/auth_data.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthData authData) onSubmit;

  AuthForm(this.onSubmit);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final AuthData _authData = AuthData();

  void _submit() {
    bool isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      widget.onSubmit(_authData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Card(
            margin: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      if (_authData.isSignup)
                        TextFormField(
                          autocorrect: true,
                          textCapitalization: TextCapitalization.words,
                          enableSuggestions: false,
                          key: ValueKey('name'),
                          decoration: InputDecoration(
                            labelText: 'Nome',
                          ),
                          onChanged: (value) => _authData.name = value,
                          validator: (value) {
                            if (value == null || value.trim().length < 4) {
                              return 'Nome deve ter no mínimo 4 caracteres';
                            }

                            return null;
                          },
                        ),
                      TextFormField(
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        enableSuggestions: false,
                        key: ValueKey('email'),
                        decoration: InputDecoration(
                          labelText: 'E-mail',
                        ),
                        onChanged: (value) => _authData.email = value,
                        validator: (value) {
                          if (value == null || !value.contains('@')) {
                            return 'Forneça um e-mail válido';
                          }

                          return null;
                        },
                      ),
                      TextFormField(
                        key: ValueKey('password'),
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Senha',
                        ),
                        onChanged: (value) => _authData.password = value,
                        validator: (value) {
                          if (value == null || value.trim().length < 7) {
                            return 'Senha deve ter no mínimo 7 caracteres';
                          }

                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      RaisedButton(
                        child: Text(_authData.isLogin ? 'Entrar' : 'Cadastrar'),
                        onPressed: _submit,
                      ),
                      FlatButton(
                        child: Text(
                          _authData.isLogin
                              ? 'Criar uma nova conta'
                              : 'Já possui uma conta?',
                          style: TextStyle(
                            color: Color.fromRGBO(233, 79, 55, 1),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _authData.toggleMode();
                          });
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
