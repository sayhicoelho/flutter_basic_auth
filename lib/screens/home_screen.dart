import 'package:flutter/material.dart';
import 'package:flutter_basic_auth/screens/login_screen.dart';
import 'package:flutter_basic_auth/services/auth_service.dart';

enum Menu {
  logout,
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (Menu menu) {
              switch (menu) {
                case Menu.logout:
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Are you sure?'),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          textColor: Colors.grey,
                          child: Text('CANCEL'),
                        ),
                        FlatButton(
                          onPressed: () {
                            AuthService.logout();
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                              (route) => false,
                            );
                          },
                          textColor: Theme.of(context).primaryColor,
                          child: Text('LOGOUT'),
                        ),
                      ],
                    )
                  );
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: Menu.logout,
                child: Text('Logout'),
              )
            ],
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Hello ${AuthService.currentUser.name}!',
          style: Theme.of(context).textTheme.headline,
        ),
      ),
    );
  }
}
