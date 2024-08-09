import 'package:flutter/material.dart';
import 'package:list_contacts/Models/UserInformation.dart';
import 'package:list_contacts/models/user.dart';
import '../UseCases/UseCases.dart';

class IdentifiableError {
  final String id = UniqueKey().toString();
  final String message;

  IdentifiableError({required this.message});
}

class UserViewModel with ChangeNotifier {
  List<UserInfor> users = [];
  int pageNum = 1;
  IdentifiableError? error;
  bool isFetching = false;
  // UserInformation? userInfor;

  final UserUseCase useCases;

  UserViewModel({required this.useCases}) {
    // users = useCases.loadCachedUsers();
    fetchUsers(pageNum: pageNum);
  }

  Future<void> fetchUsers({required int pageNum}) async {
    if (isFetching) {
      print("Fetch already in progress");
      return;
    }

    isFetching = true;
    notifyListeners();

    try {
      final newUsers = await useCases.fetchUsers(pageNum, 20);
      final currentUserIds = users.map((u) => u.id).toSet();
      final filteredNewUsers =
      newUsers.where((u) => !currentUserIds.contains(u.id)).toList();
      users.addAll(filteredNewUsers as Iterable<UserInfor>);
      // useCases.cacheUsers(users);
      print("Fetched ${filteredNewUsers.length} new users");
    } catch (e) {
      error = IdentifiableError(message: e.toString());
      print("Error fetching users: ${e.toString()}");
    } finally {
      isFetching = false;
      notifyListeners();
    }
  }

  void loadMoreUsersIfNeeded({required UserInfor? currentUser}) {
    if (currentUser == null) {
      fetchUsers(pageNum: pageNum);
      return;
    }

    final thresholdIndex = users.length - 5;
    final userIndex = users.indexWhere((u) => u.id == currentUser.id);

    if (userIndex >= thresholdIndex) {
      print("Current user index $userIndex, threshold index $thresholdIndex. Loading more users.");
      pageNum += 1;
      fetchUsers(pageNum: pageNum);
    } else {
      print("Current user index $userIndex, threshold index $thresholdIndex. No need to load more users.");
    }
  }

}
