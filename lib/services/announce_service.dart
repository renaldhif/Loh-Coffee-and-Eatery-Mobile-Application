import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/announce_model.dart';

class AnnounceService {
  final CollectionReference _announceCollection =
      FirebaseFirestore.instance.collection('announces');

  // add Announce from add Announce page
  Future<AnnounceModel> addAnnounce({
    required String title,
    required String announce,
    required String dateAvail,
    required String? image,
    required Timestamp timestamp,
  }) async {
    try {
      _announceCollection.add({
        'title': title,
        'announce': announce,
        'dateAvail': dateAvail,
        'image': image,
        'timestamp': timestamp,
      });
      return AnnounceModel(
        id: '',
        title: title,
        announce: announce,
        dateAvail: dateAvail,
        image: image,
        timestamp: timestamp,
      );
    } catch (e) {
      throw e;
    }
  }

  // get Announce from Announce page
  Future<List<AnnounceModel>> getAnnounces() async {
    try {
      QuerySnapshot querySnapshot = await _announceCollection.get();
      List<AnnounceModel> announces = querySnapshot.docs.map((e) {
        return AnnounceModel.fromJson(e.id, e.data() as Map<String, dynamic>);
      }).toList();

      return announces;
    } catch (e) {
      throw e;
    }
  }

  Future<AnnounceModel> getAnnounceById(String id) async {
    try {
      DocumentSnapshot docSnapshot = await _announceCollection.doc(id).get();
      if (docSnapshot.exists) {
        AnnounceModel announce = AnnounceModel.fromJson(
            id, docSnapshot.data() as Map<String, dynamic>);
        return announce;
      } else {
        throw Exception('Announce with ID $id not found');
      }
    } catch (e) {
      throw e;
    }
  }

  // get title announce
  Future<String> getPromoTitleById(String promoId) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await FirebaseFirestore.instance
              .collection('announces')
              .doc(promoId)
              .get();
      final Map<String, dynamic> data = documentSnapshot.data()!;
      final String title = data['title'];
      return title;
    } catch (e) {
      throw e;
    }
  }

  //get list announce length
  Future<int> getAnnounceLength() async {
    try {
      QuerySnapshot querySnapshot = await _announceCollection.get();
      List<AnnounceModel> announces = querySnapshot.docs.map((e) {
        return AnnounceModel.fromJson(e.id, e.data() as Map<String, dynamic>);
      }).toList();
      return announces.length;
    } catch (e) {
      throw e;
    }
  }

  //get new list announce that is ordered by timestamp
  Future<List<AnnounceModel>> getOrderedAnnounces() async {
    try {
      QuerySnapshot querySnapshot = await _announceCollection
          .orderBy('timestamp', descending: true)
          .get();
      List<AnnounceModel> announces = querySnapshot.docs.map((e) {
        return AnnounceModel.fromJson(e.id, e.data() as Map<String, dynamic>);
      }).toList();
      return announces;
    } catch (e) {
      throw e;
    }
  }

  //get list announce that is ordered by timestamp length
  Future<int> getOrderedAnnounceLength() async {
    try {
      List<AnnounceModel> announces = await getOrderedAnnounces();
      return announces.length;
    } catch (e) {
      throw e;
    }
  }

  //get string 'announce' from list of new announce based on index
  Future<String> getOrderedAnnounceString(int index) async {
    try {
      List<AnnounceModel> announces = await getOrderedAnnounces();
      return announces[index].announce;
    } catch (e) {
      throw e;
    }
  }

  //get string 'title' from list of new announce based on index
  Future<String> getOrderedAnnounceTitle(int index) async {
    try {
      List<AnnounceModel> announces = await getOrderedAnnounces();
      return announces[index].title;
    } catch (e) {
      throw e;
    }
  }

  //get string 'dateAvail' from list of new announce based on index
  Future<String> getOrderedAnnounceDateAvail(int index) async {
    try {
      List<AnnounceModel> announces = await getOrderedAnnounces();
      return announces[index].dateAvail;
    } catch (e) {
      throw e;
    }
  }

  //get string 'image' from list of new announce based on index
  Future<String?> getOrderedAnnounceImage(int index) async {
    try {
      List<AnnounceModel> announces = await getOrderedAnnounces();
      return announces[index].image;
    } catch (e) {
      throw e;
    }
  }

  //get timestamp from list of new announce based on index
  Future<Timestamp> getOrderedAnnounceTimestamp(int index) async {
    try {
      List<AnnounceModel> announces = await getOrderedAnnounces();
      return announces[index].timestamp;
    } catch (e) {
      throw e;
    }
  }
}
