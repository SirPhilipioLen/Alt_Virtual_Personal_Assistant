import 'package:flutter/material.dart';

class Contact {
  final String name;
  final String phoneNumber;
  final String email;
  final String profilePicture;

  Contact({
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.profilePicture,
  });
}

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<Map<String, String>> contacts = [
    {
      'name': 'John Doe',
      'phoneNumber': '(123) 456-7890',
      'email': 'johndoe@example.com',
    },
    {
      'name': 'Jane Smith',
      'phoneNumber': '(987) 654-3210',
      'email': 'janesmith@example.com',
    },
    {
      'name': 'Michael Johnson',
      'phoneNumber': '(555) 123-4567',
      'email': 'michaeljohnson@example.com',
    },
  ];

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  AlertDialog _buildAddContactDialog(BuildContext context) {
    return AlertDialog(
      title: Text('Add Contact'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: phoneNumberController,
            decoration: InputDecoration(labelText: 'Phone Number'),
          ),
          TextField(
            controller: emailController,
            decoration: InputDecoration(labelText: 'Email'),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Save'),
          onPressed: () {
            String name = nameController.text.trim();
            String phoneNumber = phoneNumberController.text.trim();
            String email = emailController.text.trim();

            if (name.isEmpty) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Error'),
                    content: Text('Name field cannot be empty.'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            } else if (phoneNumber.isEmpty || email.isEmpty) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Confirmation'),
                    content: Text('One or more fields are empty. Are you sure you want to save the contact?'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('Save'),
                        onPressed: () {
                          _saveContact(name, phoneNumber, email);
                          Navigator.of(context).pop();
                          Navigator.of(context).pop(); // Close contact popup
                        },
                      ),
                    ],
                  );
                },
              );
            } else {
              _saveContact(name, phoneNumber, email);
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }

  void _addNewContact(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _buildAddContactDialog(context);
      },
    );
  }

  void _saveContact(String name, String phoneNumber, String email) {
    Map<String, String> newContact = {
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
    };

    setState(() {
      contacts.add(newContact);
    });

    nameController.clear();
    phoneNumberController.clear();
    emailController.clear();
  }

  void _deleteContact(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Contact'),
          content: Text('Are you sure you want to delete this contact?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                setState(() {
                  contacts.removeAt(index);
                });
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Close contact popup
              },
            ),
          ],
        );
      },
    );
  }

  void _editContact(int index, BuildContext context) {
    Map<String, String> contact = contacts[index];

    nameController.text = contact['name']!;
    phoneNumberController.text = contact['phoneNumber']!;
    emailController.text = contact['email']!;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Contact'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: phoneNumberController,
                decoration: InputDecoration(labelText: 'Phone Number'),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                String name = nameController.text.trim();
                String phoneNumber = phoneNumberController.text.trim();
                String email = emailController.text.trim();

                if (name.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error'),
                        content: Text('Name field cannot be empty.'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                } else if (phoneNumber.isEmpty || email.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Confirmation'),
                        content: Text('One or more fields are empty. Are you sure you want to save the contact?'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text('Save'),
                            onPressed: () {
                              _saveEditedContact(index, name, phoneNumber, email);
                              Navigator.of(context).pop();
                              Navigator.of(context).pop(); // Close contact popup
                            },
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  _saveEditedContact(index, name, phoneNumber, email);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _saveEditedContact(int index, String name, String phoneNumber, String email) {
    Map<String, String> editedContact = {
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
    };

    setState(() {
      contacts[index] = editedContact;
    });

    nameController.clear();
    phoneNumberController.clear();
    emailController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              _showInformationDialog(context);
            },
            padding: EdgeInsets.only(right: 16.0),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (BuildContext context, int index) {
            Map<String, String> contact = contacts[index];
            return ListTile(
              leading: CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/contact.png'),
              ),
              title: Text(contact['name']!),
              subtitle: Text(contact['phoneNumber']!),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(contact['name']!),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage('assets/contact.png'),
                          ),
                          SizedBox(height: 16),
                          Text('Phone Number: ${contact['phoneNumber']}'),
                          Text('Email: ${contact['email']}'),
                        ],
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Call'),
                          onPressed: () {
                            // Implement call functionality here
                          },
                        ),
                        TextButton(
                          child: Text('Message'),
                          onPressed: () {
                            // Implement message functionality here
                          },
                        ),
                        TextButton(
                          child: Text('Edit'),
                          onPressed: () {
                            _editContact(index, context);
                          },
                        ),
                        TextButton(
                          child: Text('Delete'),
                          onPressed: () {
                            _deleteContact(index);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNewContact(context),
        child: Icon(Icons.add),
      ),
    );
  }
}

void _showInformationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Page Information'),
        content: SingleChildScrollView(
          child: Container(
            width: 400.0, // Adjust the width as needed
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to the Contacts Page!',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
        ],
      );
    },
  );
}