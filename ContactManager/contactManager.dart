import 'dart:io';

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

class ContactManager {
  List<Contact> _contacts = [];
  final String fileName = "contacts.txt";

  void addContact(Contact contact) {
    _contacts.add(contact);
    print(
        "${contact.name[0].toUpperCase() + contact.name.substring(1)}'s contact saved successfully");
  }

  void displayAllContacts() {
    if (_contacts.isEmpty) {
      print("No contacts found");
    } else {
      print("All contacts");
      for (var contact in _contacts) {
        contact.display();
        print("-----------");
      }
    }
  }

  void deleteContact(String name) {
    _contacts.removeWhere(
        (contact) => contact.name.toLowerCase() == name.toLowerCase());
    print("Contact deleted successfully");
  }

  void searchContacts(String keyword) {
    var results = _contacts
        .where((contact) =>
            contact.name.toLowerCase().contains(keyword.toLowerCase()) ||
            contact.phone.contains(keyword) ||
            contact.email.toLowerCase().contains(keyword.toLowerCase()))
        .toList();

    if (results.isEmpty) {
      print("No contacts matched your search");
    } else {
      for (var contact in results) {
        contact.display();
        print("-----------");
      }
    }
  }

  void saveToFile() {
    File file = File(fileName);
    var sink = file.openWrite();

    for (var contact in _contacts) {
      sink.writeln(contact.toFileFormat());
    }
    sink.close();

    print("Contacts saved to file");
  }

  void loadFromFile() {
    File file = File(fileName);
    if (file.existsSync()) {
      var lines = file.readAsLinesSync();
      _contacts = lines.map((line) => Contact.fromFileFormat(line)).toList();
      for (var contact in _contacts) {
        contact.display();
        print("-----------");
      }
      print("Contacts loaded from file");
    } else {
      print("No saved file found");
    }
  }
}

void main() {
  ContactManager manager = ContactManager();

  manager.addContact(Contact(
      name: "Daniel",
      phone: "08139925961",
      email: "dani@gmail.com",
      address: "Umuisor Ibusa"));

  manager.addContact(
      Contact(name: "Emmanuel", phone: "08063084341", email: "emma@gmail.com"));

  manager.addContact(
      Contact(name: "Favour", phone: "08163084361", email: "fav@gmail.com"));

  // manager.displayAllContacts();

  // manager.searchContacts("emma");

  // manager.saveToFile();

  // manager.loadFromFile();

  // manager = ContactManager();

  // manager.loadFromFile();
  // manager.displayAllContacts();
}
