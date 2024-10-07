import 'dart:math';
import 'package:abissinia_mobile_project/features/blog/blog-entity.dart';
import 'package:abissinia_mobile_project/features/blog/update-blog-page.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatefulWidget {
  final BlogEntity blog;
  final bool isAdmin;

  const BlogCard({Key? key, required this.blog, required this.isAdmin}) : super(key: key);

  @override
  _BlogCardState createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.blog.title,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    widget.blog.date,
                    style: const TextStyle(fontSize: 14, color: Colors.green),
                  ),
                ],
              ),
              const SizedBox(height: 1),
              const Divider(
                thickness: 1.5,
                color: Colors.grey,
              ),
              const SizedBox(height: 10),
              Text(
                isExpanded
                    ? widget.blog.description
                    : '${widget.blog.description.substring(0, min(widget.blog.description.length, 100))}...',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround, 
                children: [
                  if (widget.isAdmin) 
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) =>  UpdateBlogPage(blogEntity: widget.blog,)),
            );
                      },
                    ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: Icon(
                      isExpanded ? Icons.expand_less : Icons.expand_more,
                      color: Colors.green,
                      size: 30,
                    ),
                  ),
                  if (widget.isAdmin) 
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                      },
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
