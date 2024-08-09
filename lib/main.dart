import 'package:flutter/material.dart';
import 'Views/UserListView.dart';
import 'package:provider/provider.dart';
import 'ViewModel/UserViewModel.dart';
import 'UseCases/UseCases.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserViewModel(useCases: DBUseCase(baseUrl: 'https://api.github.com')),
      child: MaterialApp(
        title: 'Github Users',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: UserListView(),
      ),
    );
  }
}