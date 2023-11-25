import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class DataScreenState {
  final List<QueryDocumentSnapshot<Object?>>? dataList;
  const DataScreenState({
    this.dataList,
  });

  const DataScreenState.initialState() : dataList = null;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DataScreenState && listEquals(other.dataList, dataList);
  }

  @override
  int get hashCode => dataList.hashCode;

  DataScreenState copyWith({
    List<QueryDocumentSnapshot<Object?>>? dataList,
  }) {
    return DataScreenState(
      dataList: dataList ?? this.dataList,
    );
  }
}
