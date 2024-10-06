import 'package:abissinia_mobile_project/features/service/widge.dart';
import 'package:flutter/material.dart';
import 'package:abissinia_mobile_project/features/service/service-entity.dart';
import 'package:abissinia_mobile_project/features/testimoney/testimony-page.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({Key? key}) : super(key: key);

  @override
  _ServicePageState createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  final List<ServiceEntity> dummyService = [
    ServiceEntity(
      id: 1,
      title: 'First Service',
      description:
          'In Flutter, navigating between pages (or screens) is commonly done using the Navigator class.',
      image:
          'https://hips.hearstapps.com/hmg-prod/images/2022-ford-mustang-stealth-edition-02-1633475393.jpg?crop=0.671xw:1.00xh;0.125xw,0&resize=1200',
      pricing: 4000.0,
      category: 'no Category',
      time: 'time of saved',
    ),
    ServiceEntity(
      id: 1,
      title: 'First Service',
      description:
          'In Flutter, navigating between pages (or screens) is commonly done using the Navigator class.',
      image:
          'https://hips.hearstapps.com/hmg-prod/images/2022-ford-mustang-stealth-edition-02-1633475393.jpg?crop=0.671xw:1.00xh;0.125xw,0&resize=1200',
      pricing: 4000.0,
      category: 'no Category',
      time: 'time of saved',
    ),ServiceEntity(
      id: 1,
      title: 'First Service',
      description:
          'In Flutter, navigating between pages (or screens) is commonly done using the Navigator class.',
      image:
          'https://hips.hearstapps.com/hmg-prod/images/2022-ford-mustang-stealth-edition-02-1633475393.jpg?crop=0.671xw:1.00xh;0.125xw,0&resize=1200',
      pricing: 4000.0,
      category: 'no Category',
      time: 'time of saved',
    ),
  ];

  List<ServiceEntity> filteredService = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredService = dummyService;
  }

  void _filterServices(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredService = dummyService;
      } else {
        filteredService = dummyService.where((service) {
          return service.title.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 20.0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Search services',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        searchQuery = value;
                        _filterServices(searchQuery);
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.menu,
                    color: Colors.green,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const TestimonyPage(), 
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredService.length,
                        itemBuilder: (context, index) {
                          return ServiceCard(
                            serviceEntity: filteredService[index],
                            isAdmin: true,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
