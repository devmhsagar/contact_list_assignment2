import 'package:flutter/material.dart';

void main() {
  runApp(const ContactApp());
}

class ContactApp extends StatelessWidget {
  const ContactApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ContactListScreen(),
    );
  }
}

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({super.key});

  @override
  State<ContactListScreen> createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  List<Map<String, String>> contacts = [];

  void _addContact() {
    String name = _nameController.text.trim();
    String number = _numberController.text.trim();
    if (name.isNotEmpty && number.isNotEmpty) {
      setState(() {
        contacts.add({'name': name, 'number': number});
      });
      _nameController.clear();
      _numberController.clear();
    }
  }

  void _deleteContact(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirmation"),
        content: const Text("Are you sure for Delete?"),
        actions: [
          IconButton(
            icon: const Icon(Icons.cancel),
            onPressed: () => Navigator.pop(context),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              setState(() {
                contacts.removeAt(index);
              });
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact List"),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(), // Add border to TextField
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _numberController,
              decoration: InputDecoration(
                labelText: "Number",
                border: OutlineInputBorder(), // Add border to TextField
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addContact,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50), // Make button full width
                backgroundColor: Colors.blueGrey, // Set background color
              ),
              child: const Text("Add", style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.person),
                      title: Text(
                        contacts[index]['name']!,
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                      subtitle: Text(contacts[index]['number']!),
                      trailing: const Icon(Icons.phone, color: Colors.blue),
                      onLongPress: () => _deleteContact(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}