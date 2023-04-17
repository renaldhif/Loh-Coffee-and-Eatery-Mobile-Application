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

  Future<void> updateTable({
    required String id,
    required int tableNum,
    required int sizeOfPeople,
    required String location,
    required bool isBooked,
  }) async {
    try {
      await _tableCollection.doc(id).update({
        'tableNum' : tableNum,
        'sizeOfPeople' : sizeOfPeople,
        'location' : location,
        'isBooked' : isBooked,
      });
    } catch (e) {
      throw e;
    }
  }

  // Future<void> deleteTable({required String id}) async {
  //   try {
  //     await _tableCollection.doc(id).delete();
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  // Delete table by table num
  Future<void> deleteTable({required int tableNum}) async {
    try {
      QuerySnapshot querySnapshot = await _tableCollection.get();
      List<TableModel> tables = querySnapshot.docs.map((e) {
        return TableModel.fromJson(e.id, e.data() as Map<String, dynamic>);
      }).toList();
      for (var table in tables) {
        if (table.tableNum == tableNum) {
          await _tableCollection.doc(table.id).delete();
        }
      }
    } catch (e) {
      throw e;
    }
  }

  //get the tableNum only
  Future<List<int>> getTableNum() async {
    try {
      QuerySnapshot querySnapshot = await _tableCollection.get();
      List<int> tableNum = querySnapshot.docs.map((e) {
        return TableModel.fromJson(e.id, e.data() as Map<String, dynamic>).tableNum;
      }).toList();
    
      return tableNum;
    } catch (e) {
      throw e;
    }
  }

  // get the table num based on isBooked == false
  Future<List<int>> getAvailableTableNumbers() async {
    try {
      QuerySnapshot querySnapshot = await _tableCollection
      .where('isBooked', isEqualTo: false)
      .orderBy('tableNum', descending: false)
      .get();
      
      List<int> tableNumbers = querySnapshot.docs.map((doc) => TableModel.fromJson(doc.id, doc.data()! as Map<String, dynamic>).tableNum).toList();
      return tableNumbers;

    } catch (e) {
      throw e;
    }
  }


  // get the table size based on tableNum
  Future<int> getTableSizeByTableNumber({required int tableNum}) async {
    try {
      QuerySnapshot querySnapshot = await _tableCollection.get();
      List<TableModel> tables = querySnapshot.docs.map((e) {
        return TableModel.fromJson(e.id, e.data() as Map<String, dynamic>);
      }).toList();
      for (var table in tables) {
        if (table.tableNum == tableNum) {
          return table.sizeOfPeople;
        }
      }
      return 0;
    } catch (e) {
      throw e;
    }
  }

  // get the table location based on tableNum
  Future<String> getTableLocationByTableNumber({required int tableNum}) async {
    try {
      QuerySnapshot querySnapshot = await _tableCollection.get();
      List<TableModel> tables = querySnapshot.docs.map((e) {
        return TableModel.fromJson(e.id, e.data() as Map<String, dynamic>);
      }).toList();
      for (var table in tables) {
        if (table.tableNum == tableNum) {
          return table.location;
        }
      }
      return '';
    } catch (e) {
      throw e;
    }
  }
}