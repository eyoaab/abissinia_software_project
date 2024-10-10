part of 'service_bloc.dart';

@immutable
sealed class ServiceState {}

final class ServiceInitial extends ServiceState {}




final class ServiceLoadingState extends ServiceState{}
final class ServiceUpdateLoadingState extends ServiceState{}
final class ServiceAddLoadingState extends ServiceState{}
final class ServiceDeletingState extends ServiceState{}



 final class ServiceErrorState extends ServiceState{
      final String message;
      ServiceErrorState({required this.message});
  }
  
final class UpdateServiceState extends ServiceState{
     final ServiceModel serviceModel;
     UpdateServiceState({required this.serviceModel});

  }

  final class DeleteServiceState extends ServiceState{
     final ServiceModel serviceModel;
     DeleteServiceState({required this.serviceModel});

  }

  final class AddServiceState extends ServiceState{
    final ServiceModel serviceModel;
    AddServiceState({required this.serviceModel});
  }

  final class ServiceLoadedState extends ServiceState{
    final List<ServiceEntity> loadedServices;
    ServiceLoadedState({required this.loadedServices});

  }