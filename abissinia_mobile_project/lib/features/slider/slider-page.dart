import 'dart:async';
import 'package:abissinia_mobile_project/features/slider/bloc/slider_bloc.dart';
import 'package:abissinia_mobile_project/features/slider/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SliderPage extends StatefulWidget {
  final bool isAdmin;
  const SliderPage({Key? key,required this.isAdmin}) : super(key: key);

  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  late PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    
    BlocProvider.of<SliderBloc>(context).add(LoadAllSliderEvent());

    _pageController = PageController(initialPage: 0);

    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (context.read<SliderBloc>().state is SliderLoadedState) {
        final sliders = (context.read<SliderBloc>().state as SliderLoadedState).loadedSliders;
        if (_currentPage < sliders.length - 1) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SliderBloc, SliderState>(
      builder: (context, state) {
        if (state is SliderLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SliderLoadedState) {
          final sliders = state.loadedSliders;

          if (sliders.isEmpty) {
            return const Center(child: Text('No Sliders Available'));
          }

          return Column(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: sliders.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: SizedBox(
                            height: 100,
                            child: SliderCard(
                              sliderEntity: sliders[index],
                              isAdmin: widget.isAdmin, 
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          );
        } else if (state is SliderErrorState) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const Center(child: Text('Something went wrong.'));
        }
      },
    );
  }
}
