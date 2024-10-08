part of 'slider_bloc.dart';

@immutable
sealed class SliderState {}

final class SliderInitial extends SliderState {}


final class SliderLoadingState extends SliderState{}
final class SliderUpdateLoadingState extends SliderState{}
final class SliderAddLoadingState extends SliderState{}

 final class SliderErrorState extends SliderState{
      final String message;
      SliderErrorState({required this.message});
  }
  
final class UpdateSliderState extends SliderState{
     final SliderModel sliderModel;
     UpdateSliderState({required this.sliderModel});

  }

  final class DeleteSliderState extends SliderState{
     final SliderModel sliderModel;
     DeleteSliderState({required this.sliderModel});

  }

  final class AddSliderState extends SliderState{
    final SliderModel sliderModel;
    AddSliderState({required this.sliderModel});
  }

  final class SliderLoadedState extends SliderState{
    final List<SliderEntity> loadedSliders;
    SliderLoadedState({required this.loadedSliders});

  }


