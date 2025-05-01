class Contact {
  String name;
  String phone;
  String email;
  String? address;

  Contact({
    required this.name,
    required this.phone,
    required this.email,
    this.address,
  });

  void display() {
    print("Name: $name");
    print("Phone Number: $phone");
    print("Email: $email");
    print("Address: ${address ?? "N/A"}");
  }

  String toFileFormat() {
    return '$name,$phone,$email,${address ?? "N/A"}';
  }

  static Contact fromFileFormat(String line) {
    var parts = line.split(',');

    return Contact(
        name: parts[0],
        phone: parts[1],
        email: parts[2],
        address: parts[3] == "N/A" ? null : parts[3]);
  }
}