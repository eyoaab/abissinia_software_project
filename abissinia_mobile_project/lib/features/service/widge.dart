import 'package:abissinia_mobile_project/features/service/service-detail.dart';
import 'package:abissinia_mobile_project/features/service/service-entity.dart';
import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  final ServiceEntity serviceEntity;
  final bool isAdmin;

  ServiceCard({required this.serviceEntity, required this.isAdmin});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: GestureDetector(
        onTap: (){
            Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  ServiceDetailPage(serviceEntity: serviceEntity,isAdmin:isAdmin),
                    ));
        },
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
                child: Image.network(
                  serviceEntity.image,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Container(
                        height: 130,
                        width: double.infinity,
                        color: Colors.grey.shade200,
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                          ),
                        ),
                      );
                    }
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 130,
                      width: double.infinity,
                      color: Colors.grey.shade200,
                      child: const Center(
                        child: Icon(
                          Icons.error,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                    );
                  },
                ),
              ),
        
              Padding(
                padding: const EdgeInsets.only(left: 10.0,bottom:10),
                child: Text(
                  serviceEntity.title,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
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
