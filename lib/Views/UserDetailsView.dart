import 'package:flutter/material.dart';
import '../Models/UserInformation.dart';

class UserDetailsView extends StatelessWidget {
  final UserInfor user;

  const UserDetailsView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(user.login ?? '')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Login: ${user.login}', style: Theme.of(context).textTheme.headline6),
            Text('ID: ${user.id}', style: Theme.of(context).textTheme.subtitle1),
          ],
        ),
      ),
    );
  }
}
