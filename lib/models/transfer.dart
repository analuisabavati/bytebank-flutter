class Transfer {
  final double value;
  final int accountNumber;

  const Transfer({this.value, this.accountNumber});

  @override
  String toString() {
    return 'Transfer{value: $value, accountNumber: $accountNumber}';
  }
}
