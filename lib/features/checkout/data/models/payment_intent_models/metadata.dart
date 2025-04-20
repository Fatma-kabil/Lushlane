class Metadata {
  // لو ليه فيلدز، اكتبيهم هنا

  Metadata();

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(); // مؤقتًا بيرجع فاضي
  }

  Map<String, dynamic> toJson() {
    return {}; // مؤقتًا فاضي
  }
}
