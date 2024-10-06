import 'dart:async';
import 'package:flutter/material.dart';
import 'package:abissinia_mobile_project/features/testimoney/testimony-entity.dart';
import 'package:abissinia_mobile_project/features/testimoney/widget.dart';

class TestimonyPage extends StatefulWidget {
  const TestimonyPage({Key? key}) : super(key: key);

  @override
  _TestimonyPageState createState() => _TestimonyPageState();
}

class _TestimonyPageState extends State<TestimonyPage> {
  final List<TestimonyEntity> dummyTestimonials = [
    TestimonyEntity(
      id: 1,
      description:
          'Testimonial 1: The team at ACM Technology provided exceptional web development services. They paid great attention to detail and delivered on time. Their expertise in creating responsive and user-friendly websites helped my company grow significantly.',
      service: 'Web Development',
      company: 'ACM Technology',
    ),
    TestimonyEntity(
      id: 2,
      description:
          'Testimonial 2: XYZ Solutions went above and beyond to create a mobile app that exceeded my expectations. Their design team was very creative and worked closely with us to ensure the app met all our needs. Highly recommend!',
      service: 'App Design',
      company: 'XYZ Solutions',
    ),
    TestimonyEntity(
      id: 3,
      description:
          'Testimonial 3: Tech Corp provided excellent customer support throughout our project. They were always available to assist us with any questions or concerns and resolved issues promptly. Their commitment to customer satisfaction was outstanding.',
      service: 'Customer Support',
      company: 'Tech Corp',
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
      if (_currentPage < dummyTestimonials.length - 1) {
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
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: dummyTestimonials.isEmpty
                  ? const Center(
                      child: Text(''),
                    )
                  : PageView.builder(
                      controller: _pageController,
                      itemCount: dummyTestimonials.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TestimonialCard(
                            testimonyEntity: dummyTestimonials[index],
                            isAdmin: true,
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
