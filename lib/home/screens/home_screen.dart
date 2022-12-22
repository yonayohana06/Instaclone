import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclone/app/app.dart';
import 'package:instaclone/home/bloc/post_list_bloc.dart';
import 'package:instaclone/login/login.dart';
import 'package:instaclone/post/post.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostListBloc()..add(GetPosts()),
      child: _View(),
    );
  }
}

class _View extends StatelessWidget {
  final bool isLiked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AddPostScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.add_box_outlined,
              size: 24.0,
            ),
          ),
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthLoggedOut) {
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LoginScreen(),
                  ),
                );
              }
            },
            child: IconButton(
              onPressed: () {
                context.read<AuthBloc>().add(LogOut());
              },
              icon: const Icon(
                Icons.logout_outlined,
                size: 24.0,
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<PostListBloc, PostListState>(
        builder: (context, state) {
          if (state is PostListLoaded) {
            if (state.posts.isEmpty) {
              return const Center(
                child: Text('No Posts'),
              );
            }
            return ListView(
              padding: const EdgeInsets.all(0),
              children: [
                Column(
                  children: state.posts
                      .map(
                        (e) => Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: NetworkImage(e.avatarUrl),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Text(e.username),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Image.network(
                                e.imageUrl,
                                fit: BoxFit.fitWidth,
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {},
                                      child: const Icon(
                                        CupertinoIcons.heart,
                                        size: 24.0,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    GestureDetector(
                                      child: const Icon(
                                        CupertinoIcons.chat_bubble,
                                        size: 24.0,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    GestureDetector(
                                      child: const Icon(
                                        CupertinoIcons.paperplane,
                                        size: 24.0,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    const Expanded(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Icon(
                                          CupertinoIcons.bookmark,
                                          size: 24.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text.rich(
                                  TextSpan(
                                    text: e.username,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: [
                                      const TextSpan(text: ' '),
                                      TextSpan(
                                        text: e.caption,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
