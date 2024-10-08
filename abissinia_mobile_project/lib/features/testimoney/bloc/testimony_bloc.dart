import 'package:abissinia_mobile_project/features/testimoney/testimony-entity.dart';
import 'package:abissinia_mobile_project/features/testimoney/testimony-servises.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'testimony_event.dart';
part 'testimony_state.dart';

class TestimonyBloc extends Bloc<TestimonyEvent, TestimonyState> {
  final TestimonyService testimonyService = TestimonyService();

TestimonyBloc() : super(TestimonyInitial()) {
     on<LoadAllTestimonyEvent>((event, emit) async {
      emit(TestimonyLoadingState()); 
      try {
        final List<TestimonyEntity> Testimonys = await testimonyService.getAllTestimonies(); 
        emit(TestimonyLoadedState(loadedTestimonys: Testimonys));
      } catch (error) {
        emit(TestimonyErrorState(message: 'Failed to load Testimonys: $error'));
      }
    });

     on<UpdateTestimonyEvent>((event, emit) async {
      emit(TestimonyUpdateLoadingState()); 
      try {
        final TestimonyModel testimonyModel = await testimonyService.updateTestimony(event.testimonyEntity);
        emit(UpdateTestimonyState (testimonyModel: testimonyModel));
       
      } catch (error) {
        emit(TestimonyErrorState(message: 'Failed to update Testimonys: $error'));
      }
    });

     on<DeleteTestimonyEvent>((event, emit) async {
      emit(TestimonyLoadingState()); 
      try {
        final TestimonyModel testimonyModel = await testimonyService.deleteTestimony(event.id);
        emit(DeleteTestimonyState(testimonyModel: testimonyModel));
       
      } catch (error) {
        emit(TestimonyErrorState(message: 'Failed to Delete Testimony: $error'));
      }
    });
      on<AddTestimonyEvent>((event, emit) async {
      emit(TestimonyAddLoadingState()); 
      try {
        final TestimonyModel testimonyModel = await testimonyService.createTestimony(event.testimonyEntity);
        emit(AddTestimonyState(testimonyModel: testimonyModel));
       
      } catch (error) {
        emit(TestimonyErrorState(message: 'Failed to add Testimony: $error'));
      }
    });
}
}