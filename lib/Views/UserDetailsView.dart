import 'package:flutter/material.dart';
import '../Models/UserInformation.dart';
import 'package:url_launcher/url_launcher.dart';

class UserDetailsView extends StatelessWidget {
  final UserInfor? user;

  UserDetailsView({this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: user != null
            ? Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage(user!.avatarUrl ?? ''),
                ),
                SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user?.login ?? '',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      user?.bio ?? '',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Spacer(),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Icon(Icons.person, size: 30),
                    SizedBox(height: 8.0),
                    Text(
                      '${user!.followers ?? 0}+\nFollowers',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.person_add, size: 30),
                    SizedBox(height: 8.0),
                    Text(
                      '${user!.following ?? 0}+\nFollowing',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 32.0),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Blog",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8.0),
            user!.blog != null && user!.blog!.isNotEmpty
                ? InkWell(
              onTap: () {
                if (user!.blog != null) {
                  launchUrl(user!.blog!);
                }
              },
              child: Text(
                user!.blog!,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
            )
                : Text(
              "Blog information not available",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            Spacer(),
          ],
        )
            : Center(
          child: Text(
            "User information not available",
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }

  void launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url); // This is the function you were asking about.
    } else {
      print("Could not launch $url");
    }
  }
}
