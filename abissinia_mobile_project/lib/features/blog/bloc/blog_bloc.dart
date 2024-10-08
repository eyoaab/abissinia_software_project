import 'package:abissinia_mobile_project/features/blog/blog-entity.dart';
import 'package:abissinia_mobile_project/features/blog/blog-servise.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final BlogService blogService = BlogService();


  BlogBloc() : super(BlogInitial()) {
    on<LoadAllBlogEvent>((event, emit) async {
      emit(BlogLoadingState()); 
      try {
        final List<BlogEntity> blogs = await blogService.getAllBlogs(); 
        emit(BlogLoadedState(loadedBlogs: blogs));
      } catch (error) {
        emit(BlogErrorState(message: 'Failed to load blogs: $error'));
      }
    });
      on<UpdateBlogEvent>((event, emit) async {
      emit(BlogUpdateLoadingState()); 
      try {
        final BlogModel blogModel = await blogService.updateBlog(event.blogEntity);
        emit(UpdateBlogState(blogModel: blogModel));
       
      } catch (error) {
        emit(BlogErrorState(message: 'Failed to update blogs: $error'));
      }
    });
      on<DeleteBlogEvent>((event, emit) async {
      emit(BlogLoadingState()); 
      try {
        final BlogModel blogModel = await blogService.deleteBlog(event.id);
        emit(DeleteBlogState(blogModel: blogModel));
       
      } catch (error) {
        emit(BlogErrorState(message: 'Failed to Delete blog: $error'));
      }
    });

      on<AddBlogEvent>((event, emit) async {
      emit(BlogAddLoadingState()); 
      try {
        final BlogModel blogModel = await blogService.createBlog(event.blogEntity);
        emit(AddBlogState(blogModel: blogModel));
       
      } catch (error) {
        emit(BlogErrorState(message: 'Failed to add blog: $error'));
      }
    });
  }
  
}
