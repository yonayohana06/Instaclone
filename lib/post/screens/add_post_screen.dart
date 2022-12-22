import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclone/app/widgets/camera/camera.dart';
import 'package:instaclone/home/home.dart';
import 'package:instaclone/post/post.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AddPostBloc()..add(Initialize()),
        ),
        BlocProvider(
          create: (context) => UploadImageCubit(),
        ),
      ],
      child: _View(),
    );
  }
}

class _View extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AddPostBloc, AddPostState>(
      listener: (context, state) {
        print(state);
        if (state is AddPostSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Create post data success'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 1),
            ),
          );
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const HomeScreen(),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add post"),
        ),
        body: Form(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextFormField(
                  enabled: false,
                  controller: context.read<AddPostBloc>().uid,
                  decoration: const InputDecoration(hintText: 'UID'),
                ),
                TextFormField(
                  enabled: false,
                  controller: context.read<AddPostBloc>().username,
                  decoration: const InputDecoration(
                    hintText: 'Username / Email',
                  ),
                ),
                TextFormField(
                  enabled: false,
                  controller: context.read<AddPostBloc>().avatarUrl,
                  decoration: const InputDecoration(hintText: 'Avatar'),
                ),
                BlocConsumer<UploadImageCubit, UploadImageState>(
                  listener: (context, state) {
                    print(state);
                    if (state is UploadImageSuccess) {
                      context.read<AddPostBloc>().imageUrl.text = state.fileUrl;
                    }

                    if (state is UploadImageLoading) {
                      context.read<AddPostBloc>().imageUrl.text =
                          'Loading url image...';
                    }
                  },
                  builder: (context, state) {
                    return TextFormField(
                      readOnly: true,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const CameraScreen()),
                        ).then((value) {
                          if (value != null && value is File) {
                            context.read<UploadImageCubit>().upload(value);
                          }
                        });
                      },
                      controller: context.read<AddPostBloc>().imageUrl,
                      decoration: const InputDecoration(
                        hintText: 'Image',
                      ),
                    );
                  },
                ),
                TextFormField(
                  controller: context.read<AddPostBloc>().caption,
                  decoration: const InputDecoration(
                    hintText: 'Caption',
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    context.read<AddPostBloc>().add(SubmitAddPost());
                  },
                  child: const Text("Submit"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
