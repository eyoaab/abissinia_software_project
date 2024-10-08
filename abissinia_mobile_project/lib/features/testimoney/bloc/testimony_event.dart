part of 'testimony_bloc.dart';

@immutable
sealed class TestimonyEvent {}


class LoadAllTestimonyEvent extends TestimonyEvent{}
class InitialTestimonyEvent extends TestimonyEvent{}
class DeleteTestimonyEvent extends TestimonyEvent{
  int id;
  DeleteTestimonyEvent({required this.id});
}


class AddTestimonyEvent extends TestimonyEvent{
  TestimonyEntity testimonyEntity;
  AddTestimonyEvent({required this.testimonyEntity});
}

class UpdateTestimonyEvent extends TestimonyEvent{
  TestimonyEntity testimonyEntity;
  UpdateTestimonyEvent({required this.testimonyEntity});
}