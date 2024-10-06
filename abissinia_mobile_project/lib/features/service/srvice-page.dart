import 'package:abissinia_mobile_project/core/store.dart';
import 'package:abissinia_mobile_project/features/service/service-entity.dart';
import 'package:abissinia_mobile_project/features/service/widge.dart';
import 'package:flutter/material.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({Key? key}) : super(key: key);

  @override
  _ServicePageState createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  final List<ServiceEntity> dammyService = [

    ServiceEntity(id: 1, title: 'First Service', description: 'In Flutter, navigating between pages (or screens) is commonly done using the Navigator class. Pages in Flutter are usually widgets, and you can push a new page onto the stack (navigate to another page) or pop a page off the stack (go back to the previous page).', 
    image:  'https://hips.hearstapps.com/hmg-prod/images/2022-ford-mustang-stealth-edition-02-1633475393.jpg?crop=0.671xw:1.00xh;0.125xw,0&resize=1200',
     pricing: 4000.0,
      category: 'no Catagory', 
      time: 'time of saved'),

          ServiceEntity(id: 1, title: 'First Service', description: 'In Flutter, navigating between pages (or screens) is commonly done using the Navigator class. Pages in Flutter are usually widgets, and you can push a new page onto the stack (navigate to another page) or pop a page off the stack (go back to the previous page).', 
    image:  'https://hips.hearstapps.com/hmg-prod/images/2022-ford-mustang-stealth-edition-02-1633475393.jpg?crop=0.671xw:1.00xh;0.125xw,0&resize=1200',
     pricing: 4000.0,
      category: 'no Catagory', 
      time: 'time of saved'),

          ServiceEntity(id: 1, title: 'First Service', description: 'In Flutter, navigating between pages (or screens) is commonly done using the Navigator class. Pages in Flutter are usually widgets, and you can push a new page onto the stack (navigate to another page) or pop a page off the stack (go back to the previous page).', 
    image:  'https://hips.hearstapps.com/hmg-prod/images/2022-ford-mustang-stealth-edition-02-1633475393.jpg?crop=0.671xw:1.00xh;0.125xw,0&resize=1200',
     pricing: 4000.0,
      category: 'no Catagory', 
      time: 'time of saved'),

          ServiceEntity(id: 1, title: 'First Service', description: 'In Flutter, navigating between pages (or screens) is commonly done using the Navigator class. Pages in Flutter are usually widgets, and you can push a new page onto the stack (navigate to another page) or pop a page off the stack (go back to the previous page).', 
    image:  'https://hips.hearstapps.com/hmg-prod/images/2022-ford-mustang-stealth-edition-02-1633475393.jpg?crop=0.671xw:1.00xh;0.125xw,0&resize=1200',
     pricing: 4000.0,
      category: 'no Catagory', 
      time: 'time of saved'),

          ServiceEntity(id: 1, title: 'First Service', description: 'In Flutter, navigating between pages (or screens) is commonly done using the Navigator class. Pages in Flutter are usually widgets, and you can push a new page onto the stack (navigate to another page) or pop a page off the stack (go back to the previous page).', 
    image:  'https://hips.hearstapps.com/hmg-prod/images/2022-ford-mustang-stealth-edition-02-1633475393.jpg?crop=0.671xw:1.00xh;0.125xw,0&resize=1200',
     pricing: 4000.0,
      category: 'no Catagory', 
      time: 'time of saved'),
  ];

  List<ServiceEntity> filteredService = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredService = dammyService;
  }

  void _filterServices(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredService = dammyService; 
      });
    } else {
      setState(() {
        filteredService = dammyService.where((blog) {
          return blog.title.toLowerCase().contains(query.toLowerCase());
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 20.0
          
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            children: [
              Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: commonSerchDecoration,
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
              filteredService.isEmpty 
                  ? const Center(
                      child: Text(
                        'No Services found',
                        style: TextStyle(color: Colors.grey, fontSize: 20), 
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: filteredService.length,
                        itemBuilder: (context, index) {
                          return ServiceCard(serviceEntity: filteredService[index],isAdmin:true);
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
