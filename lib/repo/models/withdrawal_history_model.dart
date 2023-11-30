import '../utils/constants.dart';

class WithdrawalHistoryModel {
  final String id;
  final int user;
  final int amountWithdrawn;
  final String bankName;
  final String bankHolder;
  final String bankAccountNumber;
  final String created;

  WithdrawalHistoryModel({
    required this.id,
    required this.user,
    required this.amountWithdrawn,
    required this.bankName,
    required this.bankHolder,
    required this.bankAccountNumber,
    required this.created,
  });

  factory WithdrawalHistoryModel.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return WithdrawalHistoryModel(
      id: json['id'] ?? notAvailable,
      user: json['user_id'] ?? 0,
      amountWithdrawn: json['amount'] ?? 0,
      bankName: json['bank_name'] ?? notAvailable,
      bankHolder: json['bank_holder'] ?? notAvailable,
      bankAccountNumber: json['account_number'] ?? notAvailable,
      created: json['date_time'] ?? notAvailable,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'amount_withdrawed': amountWithdrawn,
      'bank_name': bankName,
      'bank_holder': bankHolder,
      'bank_account_number': bankAccountNumber,
      'created': created,
    };
  }
}
