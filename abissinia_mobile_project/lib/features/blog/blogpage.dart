import 'package:abissinia_mobile_project/core/store.dart';
import 'package:abissinia_mobile_project/features/blog/bloc/blog_bloc.dart';
import 'package:abissinia_mobile_project/features/blog/blog-entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:abissinia_mobile_project/features/blog/widgets.dart';

class BlogPage extends StatefulWidget {
  final bool isAdmin;
  const BlogPage({Key? key,required this.isAdmin}) : super(key: key);

  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(LoadAllBlogEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height * 0.06), 
          child: Container(
            color: Colors.green,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
             
                Text(
                  'Blog Page',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        // appBar: AppBar(
        //   toolbarHeight: 40.0,
        // ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: commonSerchDecoration,
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value; 
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.menu,
                    color: Colors.green,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: BlocListener<BlogBloc, BlogState>(
                  listener: (context, state) {
                    if (state is DeleteBlogState) {
                      showCustomSnackBar(
                        context,
                        state.blogModel.responseMessage,
                        state.blogModel.isRight,
                      );
                       context.read<BlogBloc>().add(LoadAllBlogEvent());
                    }
                  },
                  child: BlocBuilder<BlogBloc, BlogState>(
                    builder: (context, state) {
                      if (state is BlogLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is BlogLoadedState) {
                        List<BlogEntity> filteredBlogs = state.loadedBlogs
                            .where((blog) =>
                                blog.title.toLowerCase().contains(searchQuery.toLowerCase()))
                            .toList();

                        if (filteredBlogs.isEmpty) {
                          return const Center(
                            child: Text(
                              'No blogs available',
                              style: TextStyle(color: Colors.grey, fontSize: 20),
                            ),
                          );
                        }

                        return ListView.builder(
                          itemCount: filteredBlogs.length,
                          itemBuilder: (context, index) {
                            return BlogCard(
                              blog: filteredBlogs[index],
                              isAdmin: widget.isAdmin,
                            );
                          },
                        );
                      } else if (state is BlogErrorState) {
                        return Center(
                          child: Text(
                            state.message,
                            style: const TextStyle(color: Colors.red, fontSize: 20),
                          ),
                        );
                      }

                      return const Center(
                        child: Text('No blogs available'),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
