// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:list_contacts/ViewModel/UserViewModel.dart';
import 'package:list_contacts/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:list_contacts/Models/UserInformation.dart';
import 'package:mockito/mockito.dart';
import 'Mock/MockUserUseCase.dart'; // Your mock file

void main() {
  late MockUserUseCase mockUserUseCase;
  late UserViewModel viewModel;

  setUp(() {
    mockUserUseCase = MockUserUseCase();
    viewModel = UserViewModel(useCases: mockUserUseCase);
  });

  test('Initial state is correct', () {
    expect(viewModel.users, []);
    expect(viewModel.isFetching, false);
    expect(viewModel.error, isNull);
  });

  test('fetchUsers adds new users when successful', () async {
    // Arrange
    final user = UserInfor(
      login: 'kevin',
      id: 1,
      nodeId: 'node123',
      avatarUrl: 'avatarUrl',
      gravatarId: 'gravatarId',
      url: 'url',
      htmlUrl: 'htmlUrl',
      followersUrl: 'followersUrl',
      followingUrl: 'followingUrl',
      gistsUrl: 'gistsUrl',
      starredUrl: 'starredUrl',
      subscriptionsUrl: 'subscriptionsUrl',
      organizationsUrl: 'organizationsUrl',
      reposUrl: 'reposUrl',
      eventsUrl: 'eventsUrl',
      receivedEventsUrl: 'receivedEventsUrl',
      type: 'type',
      isAdmin: false,
      name: 'Kevin',
      company: 'Company',
      blog: 'Blog',
      location: 'Location',
      email: 'Email',
      hireable: false,
      bio: 'Bio',
      twitterUsername: 'Twitter',
      publicRepos: 10,
      publicGists: 5,
      followers: 100,
      following: 50,
      createdAt: 'createdAt',
      updatedAt: 'updatedAt',
    );

    // Ensure you're correctly mocking the fetchUsers method
    print("Setting up mock for fetchUsers");
    when(mockUserUseCase.fetchUsers(1, 20)).thenAnswer((_) async {
      print("Mock fetchUsers called with pageNum: 1, limit: 20");
      return [user];
    });
    print("Mock setup complete for fetchUsers");

    // Act
    print("Calling fetchUsers on viewModel");
    await viewModel.fetchUsers(pageNum: 1);
    print("fetchUsers call complete");
    print("Users in viewModel: ${viewModel.users.length}");

    // Assert
    expect(viewModel.users.length, 1);
    expect(viewModel.users[0], user);
    verify(mockUserUseCase.fetchUsers(1, 20)).called(1);
  });

  test('loadMoreUsersIfNeeded calls fetchUsers if currentUser is null',
      () async {
    // Act
    // await viewModel.loadMoreUsersIfNeeded(currentUser: null);

    // Assert
    verify(mockUserUseCase.fetchUsers(1, 20)).called(1);
  });

  test('loadMoreUsersIfNeeded loads more users if close to end', () async {
    // Arrange
    final user = UserInfor(
      login: 'kevin',
      id: 1,
      nodeId: 'node123',
      avatarUrl: 'avatarUrl',
      gravatarId: 'gravatarId',
      url: 'url',
      htmlUrl: 'htmlUrl',
      followersUrl: 'followersUrl',
      followingUrl: 'followingUrl',
      gistsUrl: 'gistsUrl',
      starredUrl: 'starredUrl',
      subscriptionsUrl: 'subscriptionsUrl',
      organizationsUrl: 'organizationsUrl',
      reposUrl: 'reposUrl',
      eventsUrl: 'eventsUrl',
      receivedEventsUrl: 'receivedEventsUrl',
      type: 'type',
      isAdmin: false,
      name: 'Kevin',
      company: 'Company',
      blog: 'Blog',
      location: 'Location',
      email: 'Email',
      hireable: false,
      bio: 'Bio',
      twitterUsername: 'Twitter',
      publicRepos: 10,
      publicGists: 5,
      followers: 100,
      following: 50,
      createdAt: 'createdAt',
      updatedAt: 'updatedAt',
    );

    viewModel.users = List.generate(20, (_) => user);

    // Act
    viewModel.loadMoreUsersIfNeeded(currentUser: user);

    // Assert
    verify(mockUserUseCase.fetchUsers(2, 20)).called(1);
  });
}
