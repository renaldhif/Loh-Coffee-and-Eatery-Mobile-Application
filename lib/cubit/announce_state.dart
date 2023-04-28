part of 'announce_cubit.dart';

abstract class AnnounceState extends Equatable {
  const AnnounceState();

  @override
  List<Object> get props => [];
}

class AnnounceInitial extends AnnounceState {}

class AnnounceLoading extends AnnounceState {}

class AnnounceSuccess extends AnnounceState {
  final List<AnnounceModel> announces;

  AnnounceSuccess(this.announces);

  @override
  List<Object> get props => [announces];
}

class AnnounceFailed extends AnnounceState {
  final String error;

  AnnounceFailed(this.error);

  @override
  List<Object> get props => [error];
}