// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CreditCardModel {
  final String id;
  String? date;
  String? nameHolder;
  String? cvv;
  String? bankName;

  CreditCardModel({
    required this.id,
    this.date,
    this.nameHolder,
    this.cvv,
    this.bankName,
  });

  CreditCardModel copyWith({
    String? id,
    String? date,
    String? nameHolder,
    String? cvv,
    String? bankName,
  }) {
    return CreditCardModel(
      id: id ?? this.id,
      date: date ?? this.date,
      nameHolder: nameHolder ?? this.nameHolder,
      cvv: cvv ?? this.cvv,
      bankName: bankName ?? this.bankName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'date': date,
      'nameHolder': nameHolder,
      'cvv': cvv,
      'bankName': bankName,
    };
  }

  factory CreditCardModel.fromMap(Map<String, dynamic> map) {
    return CreditCardModel(
      id: map['id'] as String,
      date: map['date'] != null ? map['date'] as String : null,
      nameHolder:
          map['nameHolder'] != null ? map['nameHolder'] as String : null,
      cvv: map['cvv'] != null ? map['cvv'] as String : null,
      bankName: map['bankName'] != null ? map['bankName'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreditCardModel.fromJson(String source) =>
      CreditCardModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CreditCardModel(id: $id, date: $date, nameHolder: $nameHolder, cvv: $cvv, bankName: $bankName)';
  }

  @override
  bool operator ==(covariant CreditCardModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.date == date &&
        other.nameHolder == nameHolder &&
        other.cvv == cvv &&
        other.bankName == bankName;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        date.hashCode ^
        nameHolder.hashCode ^
        cvv.hashCode ^
        bankName.hashCode;
  }
}
