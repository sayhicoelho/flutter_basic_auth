import 'package:flutter/material.dart';
import 'package:flutter_basic_auth/screens/home_screen.dart';
import 'package:flutter_basic_auth/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _submitting = false;

  Future<void> _submit() async {
    setState(() {
      _submitting = true;
    });

    try {
      bool authenticated = await AuthService.authenticate(
        _emailController.text,
        _passwordController.text
      );

      if (authenticated) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
          (route) => false,
        );
      } else {
        _showSnackbar('Login or password incorrect.');
      }
    } catch (e) {
      _showSnackbar('We were unable to complete your request. Please try again.');
    } finally {
      setState(() {
        _submitting = false;
      });
    }
  }

  void _showSnackbar(String text, [Color color = Colors.red]) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: color,
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Login',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.title.copyWith(color: Theme.of(context).primaryColor),
              ),
              Divider(),
              const SizedBox(height: 8.0,),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                enabled: !_submitting,
                decoration: InputDecoration(
                  hintText: 'E-mail',
                ),
              ),
              const SizedBox(height: 8.0,),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                enabled: !_submitting,
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
              ),
              const SizedBox(height: 8.0,),
              RaisedButton(
                onPressed: _submitting ? null : _submit,
                child: _submitting
                  ? const SizedBox(
                    width: 16.0,
                    height: 16.0,
                    child: const CircularProgressIndicator(
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.black54),
                      strokeWidth: 2.0,
                    ),
                  )
                  : Text('Enter'),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
