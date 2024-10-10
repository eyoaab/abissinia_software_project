part of 'faq_bloc.dart';

@immutable
sealed class FaqState {}

final class FaqInitial extends FaqState {}
final class FaqLoadingState extends FaqState{}
final class FaqUpdateLoadingState extends FaqState{}
final class FaqAddLoadingState extends FaqState{}
final class FaqDeletingState extends FaqState{}




 final class FaqErrorState extends FaqState{
      final String message;
      FaqErrorState({required this.message});
  }
  
final class UpdateFaqState extends FaqState{
     final FaqModel faqModel;
     UpdateFaqState({required this.faqModel});

  }

  final class DeleteFaqState extends FaqState{
     final FaqModel faqModel;
     DeleteFaqState({required this.faqModel});

  }

  final class AddFaqState extends FaqState{
    final FaqModel faqModel;
    AddFaqState({required this.faqModel});
  }

  final class FaqLoadedState extends FaqState{
    final List<FaqEntity> loadedFaqs;
    FaqLoadedState({required this.loadedFaqs});

  }