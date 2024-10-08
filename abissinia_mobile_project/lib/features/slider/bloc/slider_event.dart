part of 'slider_bloc.dart';

@immutable
sealed class SliderEvent {}


class LoadAllSliderEvent extends SliderEvent{}
class InitialSliderEvent extends SliderEvent{}
class DeleteSliderEvent extends SliderEvent{
  int id;
  DeleteSliderEvent({required this.id});
}


class AddSliderEvent extends SliderEvent{
  SlidersSend sliderEntity;
  AddSliderEvent({required this.sliderEntity});
}

class UpdateSliderEvent extends SliderEvent{
  SlidersSend sliderEntity;
  UpdateSliderEvent({required this.sliderEntity});
}
