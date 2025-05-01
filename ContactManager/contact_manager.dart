import 'dart:io';
import 'contact.dart';

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

  while (true) {
    print('''
      📇 Contact Manager - Menu:
      1. Add Contact
      2. View All Contacts
      3. Search Contact
      4. Delete Contact
      5. Save Contacts to File
      6. Load Contacts from File
      7. Exit
      Choose an option (1-7): 
    ''');

    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        print("Enter name: ");
        String? name = stdin.readLineSync();

        print("Enter phone number: ");
        String? phone = stdin.readLineSync();

        print("Enter email address: ");
        String? email = stdin.readLineSync();

        print("Enter address: ");
        String? address = stdin.readLineSync();

        if (name != null && email != null && phone != null) {
          String? refinedAddress = address == "" ? "N/A" : address;
          manager.addContact(Contact(
              name: name, phone: phone, email: email, address: refinedAddress));
        } else {
          print("Invalid input. Try again.");
        }

        break;
      case "2":
        manager.displayAllContacts();
        break;
      case "3":
        print("Enter a search keyword: ");
        String? keyword = stdin.readLineSync();

        if (keyword != null) {
          manager.searchContacts(keyword);
        }
        break;
      case "4":
        print("Enter a name to delete: ");
        String? name = stdin.readLineSync();

        if (name != null) {
          manager.deleteContact(name);
        }
        break;
      case "5":
        manager.saveToFile();
        break;
      case "6":
        manager.loadFromFile();
        break;
      case "7":
        print("Exiting.... goodbye.");
        exit(0);
      default:
        print("Invalid option. Please choose between 1-7.");
    }

    print("\n\n");
  }

  // manager.displayAllContacts();

  // manager.searchContacts("emma");

  // manager.saveToFile();

  // manager.loadFromFile();

  // manager = ContactManager();

  // manager.loadFromFile();
  // manager.displayAllContacts();
}
