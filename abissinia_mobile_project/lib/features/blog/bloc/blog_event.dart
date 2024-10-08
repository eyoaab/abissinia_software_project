part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

class LoadAllBlogEvent extends BlogEvent{}
class InitialBLogEvent extends BlogEvent{}
class DeleteBlogEvent extends BlogEvent{
  int id;
  DeleteBlogEvent({required this.id});
}

class AddBlogEvent extends BlogEvent{
  BlogEntity blogEntity;
  AddBlogEvent({required this.blogEntity});
}

class UpdateBlogEvent extends BlogEvent{
  BlogEntity blogEntity;
  UpdateBlogEvent({required this.blogEntity});
}
