
import 'dart:math';

class Contact {
  final String name;
  final String phoneNumber;

  Contact({required this.name, required this.phoneNumber});


  static List<Contact> generateRandomContacts(int count) {
    List<Contact> contacts = [];
    Random random = Random();
    contacts.add(
      Contact(
        name: 'chris',
        phoneNumber: '+250${random.nextInt(100000000)}', // Generate random 9-digit phone number
      ),
    );
    contacts.add(
      Contact(
        name: 'ben',
        phoneNumber: '+250${random.nextInt(100000000)}', // Generate random 9-digit phone number
      ),
    );
    return contacts;
  }
}
