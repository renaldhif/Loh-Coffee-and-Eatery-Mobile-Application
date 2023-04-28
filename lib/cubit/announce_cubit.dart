import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import '../models/announce_model.dart';
import '../services/announce_service.dart';
part 'announce_state.dart';

class AnnounceCubit extends Cubit<AnnounceState> {
  AnnounceCubit() : super(AnnounceInitial());

  void addAnnounce({
    required String title,
    required String announce,
    required String dateAvail,
    required String? image,
    required Timestamp timestamp,
  }) async {
    try {
      emit(AnnounceLoading());
      AnnounceModel announces = await AnnounceService().addAnnounce(
        title: title,
        announce: announce,
        dateAvail: dateAvail,
        image: image,
        timestamp: timestamp,
      );
      emit(AnnounceSuccess([announces]));
    } catch (e) {
      emit(AnnounceFailed(e.toString()));
    }
  }

  void getAnnounces() async {
    try {
      emit(AnnounceLoading());
      List<AnnounceModel> announces = await AnnounceService().getAnnounces();
      emit(AnnounceSuccess(announces));
    } catch (e) {
      emit(AnnounceFailed(e.toString()));
    }
  }

  void getAnnounceById(String id) async {
    try {
      emit(AnnounceLoading());
      AnnounceModel announce = await AnnounceService().getAnnounceById(id);
      emit(AnnounceSuccess([announce]));
    } catch (e) {
      emit(AnnounceFailed(e.toString()));
    }
  }

  Future<int> getAnnounceLength() async {
    try {
      emit(AnnounceLoading());
      int length = await AnnounceService().getAnnounceLength();
      // emit(AnnounceSuccess());
      return length;
    } catch (e) {
      emit(AnnounceFailed(e.toString()));
      return 0;
    }
  }

  Future<List<AnnounceModel>> getOrderedAnnounces() async {
    try {
      emit(AnnounceLoading());
      List<AnnounceModel> announces = await AnnounceService().getOrderedAnnounces();
      emit(AnnounceSuccess(announces));
      return announces;
    } catch (e) {
      emit(AnnounceFailed(e.toString()));
      return [];
    }
  }

  Future<int> getOrderedAnnounceLength() async {
    try {
      emit(AnnounceLoading());
      int length = await AnnounceService().getOrderedAnnounceLength();
      // emit(AnnounceSuccess());
      return length;
    } catch (e) {
      emit(AnnounceFailed(e.toString()));
      return 0;
    }
  }

  Future<String> getOrderedAnnounceString(int index) async {
    try {
      emit(AnnounceLoading());
      String announces = await AnnounceService().getOrderedAnnounceString(index);
      // emit(AnnounceSuccess(an));
      return announces;
    } catch (e) {
      emit(AnnounceFailed(e.toString()));
      return '';
    }
  }

  Future<String> getOrderedAnnounceTitle(int index) async {
    try {
      emit(AnnounceLoading());
      String announces = await AnnounceService().getOrderedAnnounceTitle(index);
      // emit(AnnounceSuccess(an));
      return announces;
    } catch (e) {
      emit(AnnounceFailed(e.toString()));
      return '';
    }
  }

  Future<String> getOrderedAnnounceDateAvail(int index) async {
    try {
      emit(AnnounceLoading());
      String announces = await AnnounceService().getOrderedAnnounceDateAvail(index);
      // emit(AnnounceSuccess(an));
      return announces;
    } catch (e) {
      emit(AnnounceFailed(e.toString()));
      return '';
    }
  }

  Future<String?> getOrderedAnnounceImage(int index) async {
    try {
      emit(AnnounceLoading());
      String? announces = await AnnounceService().getOrderedAnnounceImage(index);
      // emit(AnnounceSuccess(an));
      return announces;
    } catch (e) {
      emit(AnnounceFailed(e.toString()));
      return '';
    }
  }

  Future<Timestamp> getOrderedAnnounceTimestamp(int index) async {
    try {
      emit(AnnounceLoading());
      Timestamp announces =
          await AnnounceService().getOrderedAnnounceTimestamp(index);
      return announces;
    } catch (e) {
      emit(AnnounceFailed(e.toString()));
      return Timestamp.now();
    }
  }
}
