part of 'service_bloc.dart';

@immutable
sealed class ServiceEvent {}



class LoadAllServiceEvent extends ServiceEvent{}
class InitialServiceEvent extends ServiceEvent{}
class DeleteServiceEvent extends ServiceEvent{
  int id;
  DeleteServiceEvent({required this.id});
}


class AddServiceEvent extends ServiceEvent{
  ServiceSend serviceSend;
  AddServiceEvent({required this.serviceSend});
}

class UpdateServiceEvent extends ServiceEvent{
  ServiceSend serviceSend;
  UpdateServiceEvent({required this.serviceSend});
}
