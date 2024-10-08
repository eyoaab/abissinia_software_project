import 'package:abissinia_mobile_project/features/service/service-entity.dart';
import 'package:abissinia_mobile_project/features/service/services-service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'service_event.dart';
part 'service_state.dart';


class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  final ServicesServise serviceService = ServicesServise();

ServiceBloc() : super(ServiceInitial()) {
     on<LoadAllServiceEvent>((event, emit) async {
      emit(ServiceLoadingState()); 
      try {
        final List<ServiceEntity> services = await serviceService.getAllServices(); 
        emit(ServiceLoadedState(loadedServices: services));
      } catch (error) {
        emit(ServiceErrorState(message: 'Failed to load Services: $error'));
      }
    });

     on<UpdateServiceEvent>((event, emit) async {
      emit(ServiceUpdateLoadingState()); 
      try {
        final ServiceModel serviceModel = await serviceService.updateServices(event.serviceSend);
        emit(UpdateServiceState (serviceModel: serviceModel));
       
      } catch (error) {
        emit(ServiceErrorState(message: 'Failed to update Services: $error'));
      }
    });

     on<DeleteServiceEvent>((event, emit) async {
      emit(ServiceLoadingState()); 
      try {
        final ServiceModel serviceModel = await serviceService.deleteServic(event.id);
        emit(DeleteServiceState(serviceModel: serviceModel));
       
      } catch (error) {
        emit(ServiceErrorState(message: 'Failed to Delete Service: $error'));
      }
    });
      on<AddServiceEvent>((event, emit) async {
      emit(ServiceAddLoadingState()); 
      try {
        final ServiceModel serviceModel = await serviceService.addServices(event.serviceSend);
        emit(AddServiceState(serviceModel: serviceModel));
       
      } catch (error) {
        emit(ServiceErrorState(message: 'Failed to add Service: $error'));
      }
    });
}
}

