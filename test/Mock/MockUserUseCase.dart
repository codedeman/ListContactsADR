import 'package:list_contacts/Models/UserInformation.dart';
import 'package:list_contacts/UseCases/UseCases.dart';
import 'package:mockito/mockito.dart';


class MockUserUseCase extends UserUseCase {
  List<UserInfor> users = [];
  bool shouldThrowError = false;

  @override
  Future<UserInfor> fetchUser(String userName) async {
    if (shouldThrowError) {
      throw Exception('Failed to fetch user');
    }
    return users.firstWhere((user) => user.login == userName);
  }

  @override
  Future<List<UserInfor>> fetchUsers(int page, int limit) async {
    if (shouldThrowError) {
      throw Exception('Failed to fetch users');
    }
    // Mocking pagination by returning a sublist
    int start = (page - 1) * limit;
    int end = start + limit;
    return users.sublist(start, end > users.length ? users.length : end);
  }

  // You can use this method to populate mock data
  void populateUsers(List<UserInfor> mockUsers) {
    users = mockUsers;
  }

  // You can use this method to simulate errors
  void simulateError(bool shouldThrow) {
    shouldThrowError = shouldThrow;
  }
}
