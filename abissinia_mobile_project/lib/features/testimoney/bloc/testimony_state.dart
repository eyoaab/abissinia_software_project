part of 'testimony_bloc.dart';

@immutable
sealed class TestimonyState {}

final class TestimonyInitial extends TestimonyState {}


final class TestimonyLoadingState extends TestimonyState{}
final class TestimonyUpdateLoadingState extends TestimonyState{}
final class TestimonyAddLoadingState extends TestimonyState{}
final class TestimonyDeletingState extends TestimonyState{}



 final class TestimonyErrorState extends TestimonyState{
      final String message;
      TestimonyErrorState({required this.message});
  }
  
final class UpdateTestimonyState extends TestimonyState{
     final TestimonyModel testimonyModel;
     UpdateTestimonyState({required this.testimonyModel});

  }

  final class DeleteTestimonyState extends TestimonyState{
     final TestimonyModel testimonyModel;
     DeleteTestimonyState({required this.testimonyModel});

  }

  final class AddTestimonyState extends TestimonyState{
    final TestimonyModel testimonyModel;
    AddTestimonyState({required this.testimonyModel});
  }

  final class TestimonyLoadedState extends TestimonyState{
    final List<TestimonyEntity> loadedTestimonys;
    TestimonyLoadedState({required this.loadedTestimonys});

  }