part of 'faq_bloc.dart';

@immutable
sealed class FaqEvent {}

class LoadAllFaqEvent extends FaqEvent{}
class InitialFaqEvent extends FaqEvent{}
class DeleteFaqEvent extends FaqEvent{
  int id;
  DeleteFaqEvent({required this.id});
}


class AddFaqEvent extends FaqEvent{
  FaqEntity faqEntity;
  AddFaqEvent({required this.faqEntity});
}

class UpdateFaqEvent extends FaqEvent{
  FaqEntity faqEntity;
  UpdateFaqEvent({required this.faqEntity});
}