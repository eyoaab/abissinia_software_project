import 'package:abissinia_mobile_project/features/faq/faq-entity.dart';
import 'package:abissinia_mobile_project/features/faq/faq-service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'faq_event.dart';
part 'faq_state.dart';

class FaqBloc extends Bloc<FaqEvent, FaqState> {
  final FaqService faqService = FaqService();

  FaqBloc() : super(FaqInitial()) {
     on<LoadAllFaqEvent>((event, emit) async {
      emit(FaqLoadingState()); 
      try {
        final List<FaqEntity> Faqs = await faqService.getAllFaqs(); 
        emit(FaqLoadedState(loadedFaqs: Faqs));
      } catch (error) {
        emit(FaqErrorState(message: 'Failed to load Faqs: $error'));
      }
    });

     on<UpdateFaqEvent>((event, emit) async {
      emit(FaqUpdateLoadingState()); 
      try {
        final FaqModel faqModel = await faqService.updateFaq(event.faqEntity);
        emit(UpdateFaqState (faqModel: faqModel));
       
      } catch (error) {
        emit(FaqErrorState(message: 'Failed to update Faqs: $error'));
      }
    });

     on<DeleteFaqEvent>((event, emit) async {
      emit(FaqDeletingState()); 
      try {
        final FaqModel faqModel = await faqService.deleteFaq(event.id.toString());
        emit(DeleteFaqState(faqModel: faqModel));
       
      } catch (error) {
        emit(FaqErrorState(message: 'Failed to Delete Faq: $error'));
      }
    });
      on<AddFaqEvent>((event, emit) async {
      emit(FaqAddLoadingState()); 
      try {
        final FaqModel faqModel = await faqService.createFaq(event.faqEntity);
        emit(AddFaqState(faqModel: faqModel));
       
      } catch (error) {
        emit(FaqErrorState(message: 'Failed to add Faq: $error'));
      }
    });
  }
}
