import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/table_model.dart';

class TableService{
  final CollectionReference _tableCollection = FirebaseFirestore.instance.collection('tables');

  Future<TableModel> addTable({
    required int tableNum,
    required int sizeOfPeople,
    required String location,
    bool isBooked = false,
  }) async {
    try {
      _tableCollection.add({
        'tableNum' : tableNum,
        'sizeOfPeople' : sizeOfPeople,
        'location' : location,
        'isBooked' : isBooked,
      });
      return TableModel(
        id: '',
        sizeOfPeople: sizeOfPeople,
        tableNum: tableNum,
        location: location,
        isBooked: isBooked,
      );
    } catch (e) {
      throw e;
    }
  }

  Future<List<TableModel>> getTables() async {
    try {
      QuerySnapshot querySnapshot = await _tableCollection.get();
      List<TableModel> tables = querySnapshot.docs.map((e) {
        return TableModel.fromJson(e.id, e.data() as Map<String, dynamic>);
      }).toList();
    
      return tables;
    } catch (e) {
      throw e;
    }
  }
}