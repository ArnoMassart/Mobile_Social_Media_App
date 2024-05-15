import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/components/my_drawer.dart';
import 'package:social_media_app/components/my_list_tile.dart';
import 'package:social_media_app/components/my_post_button.dart';
import 'package:social_media_app/components/my_textfield.dart';
import 'package:social_media_app/db/firestore.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // firestore access
  final FirestoreDatabase db = FirestoreDatabase();

  final TextEditingController newPostController = TextEditingController();

  // post message
  void postMessage() {
    if (newPostController.text.isNotEmpty) {
      db.addPost(newPostController.text);
    }

    // clear the controller
    newPostController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("S O C I O U S"),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      drawer: MyDrawer(),
      body: Column(
        children: [
          // textfield box for users to type
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                Expanded(
                  child: MyTextField(
                    hintText: "Say something...",
                    controller: newPostController,
                  ),
                ),

                // post button
                PostButton(
                  onTap: postMessage,
                ),
              ],
            ),
          ),

          // posts
          StreamBuilder(
            stream: db.getPostsStream(),
            builder: (context, snapshot) {
              // show loading circle
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              // get all posts
              final posts = snapshot.data!.docs;

              // no data
              if (snapshot.data == null || posts.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(23),
                    child: Text("No Posts.. Post something!"),
                  ),
                );
              }

              // return as a list
              return Expanded(child: ListView.builder(
                itemBuilder: (context, index) {
                  // get each individual post
                  if (index < posts.length) {
                    final post = posts[index];
                    // get data from each post
                    String message = post["PostMessage"];
                    String userEmail = post["UserEmail"];
                    Timestamp timeStamp = post["TimeStamp"];

                    // return as a list tile
                    return MyListTile(
                      title: message,
                      subtitle: userEmail,
                    );
                  }
                },
              ));
            },
          )
        ],
      ),
    );
  }
}
