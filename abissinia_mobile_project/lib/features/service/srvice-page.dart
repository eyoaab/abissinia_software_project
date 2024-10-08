import 'package:abissinia_mobile_project/core/store.dart';
import 'package:abissinia_mobile_project/features/service/bloc/service_bloc.dart';
import 'package:abissinia_mobile_project/features/service/service-entity.dart';
import 'package:abissinia_mobile_project/features/service/widge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:abissinia_mobile_project/features/testimoney/testimony-page.dart';

class ServicePage extends StatefulWidget {
  final bool isAdmin;

  const ServicePage({Key? key, required this.isAdmin}) : super(key: key);

  @override
  _ServicePageState createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ServiceBloc>(context).add(LoadAllServiceEvent()); // Load services on init
  }

  void _filterServices(String query, List<ServiceEntity> services) {
    setState(() {
      searchQuery = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height * 0.06),
          child: Container(
            color: Colors.green,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Service Page',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
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
                        _filterServices(value, []);
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
                child: BlocBuilder<ServiceBloc, ServiceState>(
                  builder: (context, state) {
                    if (state is ServiceLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ServiceLoadedState) {
                      List<ServiceEntity> filteredService = state.loadedServices;
                      if (searchQuery.isNotEmpty) {
                        filteredService = state.loadedServices.where((service) {
                          return service.title.toLowerCase().contains(searchQuery.toLowerCase());
                        }).toList();
                      }

                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            TestimonyPage(isAdmin: widget.isAdmin),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: filteredService.length,
                              itemBuilder: (context, index) {
                                return ServiceCard(
                                  serviceEntity: filteredService[index],
                                  isAdmin: widget.isAdmin,
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    } else if (state is ServiceErrorState) {
                      return Center(child: Text(state.message));
                    } else {
                      return const Center(child: Text("Unexpected state"));
                    }
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
