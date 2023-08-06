class AppUser {
  final String? id;
  final String firstName;
  final String lastName;
  final int amountAccrued;
  final String email;
  final int walletBalance;
  final int loanBalance;
  final String imageUrl;
  final int? employerNumber;
  final List<dynamic>? cooler;
  final DateTime accountCreated;

  AppUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.amountAccrued,
    required this.email,
    required this.walletBalance,
    required this.loanBalance,
    required this.imageUrl,
    required this.accountCreated,
    required this.cooler,
    required this.employerNumber,
  });

  static AppUser fromJson(json) => AppUser(
        id: json['id'] ?? '',
        firstName: json['firstName'] ?? '',
        lastName: json['lastName'] ?? '',
        amountAccrued: json['amountAccrued'] ?? json['accruedBalance'] ?? 0,
        email: json['email'] ?? '',
        walletBalance: json['walletBalance'] ?? 0,
        loanBalance: json['loanBalance'] ?? 0,
        imageUrl: json['imageUrl'] ?? '',
        cooler: json['cooler'] ?? [],
        accountCreated: DateTime.now(),
        employerNumber: json['employerNumber'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "amountAccrued": amountAccrued,
        "email": email,
        "walletBalance": walletBalance,
        "loanBalance": loanBalance,
        "imageUrl": imageUrl,
        "coolers": cooler,
        "employerNumber": employerNumber,
      };
}
