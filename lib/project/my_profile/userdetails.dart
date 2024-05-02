class UsrDetails {
  final String id;
  final String name;
  final String userEmail;
  final String userNumber;

  UsrDetails({
    this.id = "",
    this.name = "",
    this.userEmail = "",
    this.userNumber = "",
  });
  factory UsrDetails.fromSnapshot(Map<String, dynamic> snapshot) {
    return UsrDetails(
      id: snapshot['id'],
      name: snapshot['name'],
      userEmail: snapshot['email'],
      userNumber: snapshot['contactNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': userEmail,
      'contactNumber': userNumber,
    };
  }

  /* static Future<List<UsrDetails>> getNeeds() async {
    Query needsSnapshot = await FirebaseDatabase.instance
        .reference()
        .child("needs-posts")
        .orderByKey();

    print(needsSnapshot); // to debug and see if data is returned

    List<UsrDetails>? needs;

    Map<dynamic, dynamic> values = needsSnapshot.;
    values.forEach((key, values) {
    needs!.add(values);
    });

    return needs!;
  }*/
}
