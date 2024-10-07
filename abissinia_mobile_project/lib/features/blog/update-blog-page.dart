import 'package:abissinia_mobile_project/features/blog/blog-entity.dart';
import 'package:abissinia_mobile_project/features/blog/blogpage.dart';
import 'package:flutter/material.dart';
import 'package:abissinia_mobile_project/core/store.dart';
import 'package:abissinia_mobile_project/features/add-page/add-page.dart';
import 'package:abissinia_mobile_project/features/product/widget.dart';

class UpdateBlogPage extends StatefulWidget {
  final BlogEntity blogEntity;

  const UpdateBlogPage({Key? key, required this.blogEntity}) : super(key: key);

  @override
  _UpdateBlogPageState createState() => _UpdateBlogPageState();
}

class _UpdateBlogPageState extends State<UpdateBlogPage> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _catagoryController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.blogEntity.title);
    _descriptionController = TextEditingController(text: widget.blogEntity.description);
    _catagoryController = TextEditingController(text: widget.blogEntity.category);
  }

  void _clearAllFields() {
    setState(() {
      _nameController.clear();
      _descriptionController.clear();
      _catagoryController.clear();
    });
  }

  void _updateBlog() {
    if (_nameController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _catagoryController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    final BlogEntity updatedBlogEntity = BlogEntity(
      id: widget.blogEntity.id, 
      title: _nameController.text.trim(),
      description: _descriptionController.text.trim(),
      category: _catagoryController.text.trim(),
      date: widget.blogEntity.date, 
    );

  

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Blog updated successfully!')),
    );

    _clearAllFields();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.chevron_left, color: commonColor, size: 40),
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Blogpage()),
            ),
          ),
          title: const Text('Update Blog', style: TextStyle(color: Colors.black)),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(25, 20, 25, 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              TextField(
                controller: _nameController,
                decoration: decorateInput('Title'),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _catagoryController,
                decoration: decorateInput('Category'),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _descriptionController,
                decoration: decorateInput('Description'),
                maxLines: 3,
              ),
              const SizedBox(height: 40),
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: OutlinedButton(
                        onPressed: _updateBlog,
                        style: OutlinedButton.styleFrom(
                          backgroundColor: commonColor,
                          side: BorderSide(color: commonColor, width: 2),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        child: const Text('UPDATE', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: OutlinedButton(
                        onPressed: _clearAllFields,
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.red, width: 2),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        child: const Text('CLEAR', style: TextStyle(color: Colors.red)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
