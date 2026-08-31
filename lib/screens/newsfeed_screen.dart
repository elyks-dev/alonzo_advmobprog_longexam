import 'package:alonzo_advmobprog_longexam1/models.dart';
import 'package:alonzo_advmobprog_longexam1/services/post_service.dart';
import 'package:alonzo_advmobprog_longexam1/widgets/post_card.dart';
import 'package:flutter/material.dart';

class NewsfeedScreen extends StatefulWidget {
  const NewsfeedScreen({super.key});

  @override
  State<NewsfeedScreen> createState() => _NewsfeedScreenState();
}

class _NewsfeedScreenState extends State<NewsfeedScreen> {
  late Future<List<PostModel>> _postsFuture;

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  void _loadPosts() {
    _postsFuture = PostService().getPostModels();
  }

  Future<void> _refreshPosts() async {
    setState(() {
      _loadPosts();
    });

    await _postsFuture;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PostModel>>(
      future: _postsFuture,
      builder: (context, snapshot) {
        // Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        // Error
        if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 60,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Failed to load posts.",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    snapshot.error.toString(),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _loadPosts();
                      });
                    },
                    child: const Text("Try Again"),
                  ),
                ],
              ),
            ),
          );
        }

        // Empty list
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text("No posts available."),
          );
        }

        final posts = snapshot.data!;

        return RefreshIndicator(
          onRefresh: _refreshPosts,
          child: ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return PostCard(post: posts[index]);
            },
          ),
        );
      },
    );
  }
}