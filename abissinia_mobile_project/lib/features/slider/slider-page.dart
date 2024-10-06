import 'dart:async';
import 'package:abissinia_mobile_project/features/slider/slider-entity.dart';
import 'package:abissinia_mobile_project/features/slider/widget.dart';
import 'package:flutter/material.dart';

class SliderPage extends StatefulWidget {
  const SliderPage({Key? key}) : super(key: key);

  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  final List<SliderEntity> dummySliders = [
    SliderEntity(
      id: 1,
      description:
          'Testiyeir commitment to customer satisfaction was outstanding.',
      title: 'Tech Corp',
      image: 'https://hips.hearstapps.com/hmg-prod/images/2022-ford-mustang-stealth-edition-02-1633475393.jpg?crop=0.671xw:1.00xh;0.125xw,0&resize=1200',
    ),
    SliderEntity(
      id: 2,
      description:
          'Testiyeir commitment to customer satisfaction was outstanding.',
      title: 'Tech Corp',
      image: 'https://hips.hearstapps.com/hmg-prod/images/2022-ford-mustang-stealth-edition-02-1633475393.jpg?crop=0.671xw:1.00xh;0.125xw,0&resize=1200',
    ),
    SliderEntity(
      id: 3,
      description:
          'Testiyeir commitment to customer satisfaction was outstanding.',
      title: 'Tech Corp',
      image: 'https://hips.hearstapps.com/hmg-prod/images/2022-ford-mustang-stealth-edition-02-1633475393.jpg?crop=0.671xw:1.00xh;0.125xw,0&resize=1200',
    ),
    SliderEntity(
      id: 4,
      description:
          'Testiyeir commitment to customer satisfaction was outstanding.',
      title: 'Tech Corp',
      image: 'https://hips.hearstapps.com/hmg-prod/images/2022-ford-mustang-stealth-edition-02-1633475393.jpg?crop=0.671xw:1.00xh;0.125xw,0&resize=1200',
    ),
  ];

  late PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);

    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPage < dummySliders.length - 1) {
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
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
              child: dummySliders.isEmpty
                  ? const Center(
                      child: Text('No Sliders Available'),
                    )
                  : PageView.builder(
                      controller: _pageController,
                      itemCount: dummySliders.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: SizedBox(
                            height: 100, 
                            child: SliderCard(
                              sliderEntity: dummySliders[index],
                              isAdmin: true,
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
  }
}
