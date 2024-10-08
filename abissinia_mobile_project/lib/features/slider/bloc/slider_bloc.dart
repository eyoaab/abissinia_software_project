import 'package:abissinia_mobile_project/features/slider/slider-entity.dart';
import 'package:abissinia_mobile_project/features/slider/slider-services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'slider_event.dart';
part 'slider_state.dart';

class SliderBloc extends Bloc<SliderEvent, SliderState> {
  final SliderService sliderService = SliderService();

SliderBloc() : super(SliderInitial()) {
     on<LoadAllSliderEvent>((event, emit) async {
      emit(SliderLoadingState()); 
      try {
        final List<SliderEntity> Sliders = await sliderService.getAllSliders(); 
        emit(SliderLoadedState(loadedSliders: Sliders));
      } catch (error) {
        emit(SliderErrorState(message: 'Failed to load Sliders: $error'));
      }
    });

     on<UpdateSliderEvent>((event, emit) async {
      emit(SliderUpdateLoadingState()); 
      try {
        final SliderModel sliderModel = await sliderService.updatesliders(event.sliderEntity);
        emit(UpdateSliderState (sliderModel: sliderModel));
       
      } catch (error) {
        emit(SliderErrorState(message: 'Failed to update Sliders: $error'));
      }
    });

     on<DeleteSliderEvent>((event, emit) async {
      emit(SliderLoadingState()); 
      try {
        final SliderModel sliderModel = await sliderService.deleteSlider(event.id);
        emit(DeleteSliderState(sliderModel: sliderModel));
       
      } catch (error) {
        emit(SliderErrorState(message: 'Failed to Delete Slider: $error'));
      }
    });
      on<AddSliderEvent>((event, emit) async {
      emit(SliderAddLoadingState()); 
      try {
        final SliderModel sliderModel = await sliderService.addsliders(event.sliderEntity);
        emit(AddSliderState(sliderModel: sliderModel));
       
      } catch (error) {
        emit(SliderErrorState(message: 'Failed to add Slider: $error'));
      }
    });
}
}