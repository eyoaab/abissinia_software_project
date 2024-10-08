import 'package:abissinia_mobile_project/core/store.dart';
import 'package:abissinia_mobile_project/features/blog/bloc/blog_bloc.dart';
import 'package:abissinia_mobile_project/features/blog/blog-entity.dart';
import 'package:abissinia_mobile_project/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:abissinia_mobile_project/features/add-page/add-page.dart';
import 'package:abissinia_mobile_project/features/product/widget.dart';

class AddBlogPage extends StatefulWidget {
  @override
  _AddBlogPageState createState() => _AddBlogPageState();
}

class _AddBlogPageState extends State<AddBlogPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController(); 

  void _clearAllFields() {
    setState(() {
      _nameController.clear();
      _descriptionController.clear();
      _categoryController.clear(); 
    });
  }
    void _showLoadingDialog(String message) {
  showDialog(
    context: context,
    barrierDismissible: false, 
    builder: (context) {
      return AlertDialog(
        content: Container(
          width: 300, 
          padding: const EdgeInsets.all(16.0), 
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [
               CircularProgressIndicator(color: commonColor,),
              const SizedBox(width: 16),
              Expanded(child: Text(message, textAlign: TextAlign.center)), 
            ],
          ),
        ),
      );
    },
  );
}


  void _saveBlog() {
    if (_nameController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _categoryController.text.isEmpty) {
      showCustomSnackBar(context, 'Please fill all the fields', false);
      return;
    }

    final BlogEntity blogEntity  = BlogEntity(
      id: 0,
      title: _nameController.text.trim(),
      description: _descriptionController.text.trim(),
      category: _categoryController.text.trim(),
      date: DateTime.now().toString(),
    );
    
    BlocProvider.of<BlogBloc>(context).add(AddBlogEvent(blogEntity: blogEntity));
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
              MaterialPageRoute(builder: (context) =>  MainPage(isAdmin: true,selectedIndex: 4,)),
            ),
          ),
          title: const Text('Add Blog', style: TextStyle(color: Colors.black)),
        ),
        body: BlocListener<BlogBloc, BlogState>(
          listener: (context, state) {
            if (state is BlogAddLoadingState) {
              _showLoadingDialog('Creating a Blog');
               
            }

            if (state is AddBlogState) {
              Navigator.pop(context); 
              showCustomSnackBar(context, state.blogModel.responseMessage, state.blogModel.isRight);
              _clearAllFields();
            }

            if (state is BlogErrorState) {
              Navigator.pop(context);
              showCustomSnackBar(context, state.message, false);
            }
          },
          child: SingleChildScrollView(
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
                  controller: _categoryController,
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
                          onPressed: _saveBlog,
                          style: OutlinedButton.styleFrom(
                            backgroundColor: commonColor,
                            side: BorderSide(color: commonColor, width: 2),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          child: const Text('ADD', style: TextStyle(color: Colors.white)),
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
      ),
    );
  }
}
