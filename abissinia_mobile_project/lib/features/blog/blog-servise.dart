import 'dart:convert';
import 'dart:developer';

import 'package:abissinia_mobile_project/core/constants/Urls.dart';
import 'package:http/http.dart' as http;

import 'package:abissinia_mobile_project/features/blog/blog-entity.dart';

class BlogService{
  // final urls = Url();

Future<BlogModel> createBlog(BlogEntity blog) async {
  try {
    final response = await http.post(
      Uri.parse(Url.blogUrl()), 
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "title": blog.title,
        "description": blog.description,
        "date": blog.date,
        "category": blog.category
      }),
    );

    if (response.statusCode == 201) {
      var blogModel = const BlogModel(responseMessage: 'Blog created successfully',isRight:true );
      return blogModel;
    } else {
      var blogModel = BlogModel(responseMessage: 'Failed to create Blog: ${response.statusCode}',isRight:false );
      return blogModel;
    }
  } catch (error) {
      var blogModel = BlogModel(responseMessage: 'Error occurred: $error',isRight:false );
      return blogModel;
  }
}

Future<List<BlogEntity>> getAllBlogs() async {
  try {
    final response = await http.get(
      Uri.parse(Url.blogUrl()), 
      headers: {'Content-Type': 'application/json'},
    );
    log(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['blogs'];
      List<BlogEntity> blogs = [];
      
      for (var blogJson in data) {
        blogs.add(BlogEntity.fromJson(blogJson));
      }
      return blogs;
    } else {
      return [];
    }
  } catch (error) {
    return [];
  }
}

Future<BlogModel> updateBlog(BlogEntity blog) async {
  try {
    final response = await http.put(
      Uri.parse(Url.blogUrlById(blog.id.toString())),  
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(blog.toJson()),
    );
    if (response.statusCode == 200) {
         var blogModel = const BlogModel(responseMessage: 'Blog updated successfully',isRight:true );
          return blogModel;
    } else {
      var blogModel = BlogModel(responseMessage: 'Failed to create Blog: ${response.statusCode}',isRight:false );
      return blogModel;
    }
  } catch (error) {
      var blogModel = BlogModel(responseMessage: 'Error occurred: $error',isRight:false );
      return blogModel;
  }
}

Future<BlogModel> deleteBlog(int id) async {
  try {
    final response = await http.delete(
      Uri.parse(Url.blogUrlById(id.toString())),  
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 204 || response.statusCode == 200) {
      var blogModel = const BlogModel(responseMessage: 'Blog deleted successfully',isRight:true );
      return blogModel;


    } else {
       var blogModel = BlogModel(responseMessage: 'Failed to delete Blog: ${response.statusCode}',isRight:false );
      return blogModel;

    }
  } catch (error) {
      var blogModel = BlogModel(responseMessage: 'Error occurred: $error',isRight:false );
      return blogModel;
  }
}

}