import 'package:abissinia_mobile_project/core/store.dart';
import 'package:abissinia_mobile_project/features/blog/blog-entity.dart';
import 'package:abissinia_mobile_project/features/blog/widgets.dart';
import 'package:flutter/material.dart';

class Blogpage extends StatefulWidget {
  const Blogpage({Key? key}) : super(key: key);

  @override
  _BlogpageState createState() => _BlogpageState();
}

class _BlogpageState extends State<Blogpage> {
  final List<BlogEntity> dammyBlog = [
    BlogEntity(id: 1, title: 'Now, if there are', description: 'Now, if there are no matching blog entries after a search, the user will see a message in the center of the screen indicating that no blogs were found. This enhances the user experience by providing clear feedback.', date: 'jun-32-2025', category: ''),
    BlogEntity(id: 2, title: 'Another Blog Title', description: 'This is another blog post description that provides insights.', date: 'jun-30-2025', category: ''),
    BlogEntity(id: 3, title: 'Third Blog Example', description: 'Yet another example of a blog post for demonstration purposes.', date: 'jun-29-2025', category: ''),
  ];

  List<BlogEntity> filteredBlog = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredBlog = dammyBlog;
  }

  void _filterBlogs(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredBlog = dammyBlog; 
      });
    } else {
      setState(() {
        filteredBlog = dammyBlog.where((blog) {
          return blog.title.toLowerCase().contains(query.toLowerCase());
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 40.0
          
        ),
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
                      searchQuery = value;
                      _filterBlogs(searchQuery);
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
              filteredBlog.isEmpty 
                  ? const Center(
                      child: Text(
                        'No blogs found',
                        style: TextStyle(color: Colors.grey, fontSize: 20), 
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: filteredBlog.length,
                        itemBuilder: (context, index) {
                          return BlogCard(blog: filteredBlog[index],isAdmin: true,);
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
