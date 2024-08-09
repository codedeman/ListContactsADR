import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../ViewModel/UserViewModel.dart';
import 'UserDetailsView.dart';
import '../UseCases/UseCases.dart';

class UserListView extends StatelessWidget {
  @override
  final ScrollController _scrollController = ScrollController();

  UserListView() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _loadMoreUsers();
      }
    });
  }
  void _loadMoreUsers() {
    final userViewModel = _scrollController.position.context?.findAncestorWidgetOfExactType<ChangeNotifierProvider<UserViewModel>>()?.create;
    userViewModel?.fetchUsers(pageNum: userViewModel.pageNum);
  }
  Widget build(BuildContext context) {

    final userViewModel = Provider.of<UserViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Github Users'),
      ),
      body: userViewModel.isFetching && userViewModel.users.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: userViewModel.users.length,
        itemBuilder: (context, index) {
          final user = userViewModel.users[index];
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 16.0,
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(user.avatarUrl ?? ''),
                ),
                title: Text(
                  user.login ?? 'Unknown User',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  user.htmlUrl ?? '',
                  style: TextStyle(color: Colors.blue),
                ),
                onTap: () {
                  userViewModel.loadMoreUsersIfNeeded(currentUser: user);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserDetailsView(user: user),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}


