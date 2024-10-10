part of 'blog_bloc.dart';

@immutable
sealed class BlogState {}

final class BlogInitial extends BlogState {}
final class BlogLoadingState extends BlogState{}
final class BlogUpdateLoadingState extends BlogState{}
final class BlogAddLoadingState extends BlogState{}
final class BlogDeletingState extends BlogState{}



final class BlogLoadedState extends BlogState{
  final  List<BlogEntity>  loadedBlogs;
    BlogLoadedState({required this.loadedBlogs});
}
 final class BlogErrorState extends BlogState{
      final String message;
      BlogErrorState({required this.message});
  }
  
final class UpdateBlogState extends BlogState{
     final BlogModel blogModel;
     UpdateBlogState({required this.blogModel});

  }

  final class DeleteBlogState extends BlogState{
     final BlogModel blogModel;
     DeleteBlogState({required this.blogModel});

  }

  final class AddBlogState extends BlogState{
    final BlogModel blogModel;
    AddBlogState({required this.blogModel});
  }



