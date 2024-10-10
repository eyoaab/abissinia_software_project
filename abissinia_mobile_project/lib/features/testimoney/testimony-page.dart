
import 'dart:async';
import 'package:abissinia_mobile_project/core/store.dart';
import 'package:abissinia_mobile_project/features/testimoney/bloc/testimony_bloc.dart';
import 'package:flutter/material.dart';
import 'package:abissinia_mobile_project/features/testimoney/testimony-entity.dart';
import 'package:abissinia_mobile_project/features/testimoney/widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestimonyPage extends StatefulWidget {
  final bool isAdmin;
  const TestimonyPage({Key? key,required this.isAdmin}) : super(key: key);

  @override
  _TestimonyPageState createState() => _TestimonyPageState();
}

class _TestimonyPageState extends State<TestimonyPage> {
  late PageController _pageController;
  Timer? _timer;
  int _currentPage = 0;
  int _totalPages = 0;

  @override
  void initState() {
    super.initState();
    context.read<TestimonyBloc>().add(LoadAllTestimonyEvent());
    _pageController = PageController(initialPage: 0);
  }

  void _startAutoScroll(int totalPages) {
    _timer?.cancel();
    _totalPages = totalPages;

    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < _totalPages - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TestimonyBloc, TestimonyState>(
      listener: (context, state) {
        if (state is DeleteTestimonyState) {
          showCustomSnackBar(
            context,
            state.testimonyModel.responseMessage,
            state.testimonyModel.isRight,
          );
          context.read<TestimonyBloc>().add(LoadAllTestimonyEvent());
        }
      },
      child: Container(
        height: 380,
        child: Column(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: BlocBuilder<TestimonyBloc, TestimonyState>(
                    builder: (context, state) {
                      if (state is TestimonyLoadingState) {
                        return Center(
                          child: CircularProgressIndicator(color: commonColor),
                        );
                      } else if (state is TestimonyLoadedState) {
                        List<TestimonyEntity> dummyTestimonials = state.loadedTestimonys.toList();

                        if (dummyTestimonials.isEmpty) {
                          return const Center(
                            child: Text(
                              'No Testimonys available',
                              style: TextStyle(color: Colors.grey, fontSize: 20),
                            ),
                          );
                        }

                        _startAutoScroll(dummyTestimonials.length);

                        return PageView.builder(
                          controller: _pageController,
                          itemCount: dummyTestimonials.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: TestimonialCard(
                                testimonyEntity: dummyTestimonials[index],
                                isAdmin: widget.isAdmin,
                              ),
                            );
                          },
                        );
                      } else if (state is TestimonyErrorState) {
                        return const Center(
                          child: Text(
                            'somthing went wrong please refresh the screen',
                            textAlign: TextAlign.center,
                          ),
                        );
                      }

                      return const Center(
                        child: Text('No Testimonys available'),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
