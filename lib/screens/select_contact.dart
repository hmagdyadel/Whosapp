import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whosapp/customUI/button_card.dart';
import 'package:whosapp/customUI/contact_cart.dart';
import 'package:whosapp/screens/create_group.dart';

class SelectContact extends StatefulWidget {
  const SelectContact({Key? key}) : super(key: key);

  @override
  _SelectContactState createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  List<Contact> contacts = [];
  List<Contact> contactsFiltered = [];
  TextEditingController _controller = TextEditingController();

  @override
  initState() {
    super.initState();
    getAllContacts();
    _controller.addListener(() {
      filterContacts();
    });
  }

  getAllContacts() async {
    List<Contact> _contacts = (await ContactsService.getContacts()).toList();
    setState(() {
      contacts = _contacts;
    });
  }

  filterContacts() {
    List<Contact> _contacts = [];
    _contacts.addAll(contacts);
    if (_controller.text.isNotEmpty) {
      _contacts.retainWhere((contact) {
        String searchTerm = _controller.text.toLowerCase();
        String contactName = contact.displayName!.toLowerCase();
        return contactName.contains(searchTerm);
      });
      setState(() {
        contactsFiltered = _contacts;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isSearching = _controller.text.isNotEmpty;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF075E54),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Contact',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            isSearching == true
                ? Text(
                    '${contactsFiltered.length.toString()}',
                    style: const TextStyle(fontSize: 13),
                  )
                : Text(
                    '${contacts.length.toString()} contacts',
                    style: const TextStyle(fontSize: 13),
                  ),
          ],
        ),
        actions: [
          // IconButton(
          //   icon: Icon(Icons.search),
          //   onPressed: () {
          //     showSearch(context: context, delegate: ContactSearch());
          //   },
          // ),
          PopupMenuButton(
            onSelected: (value) {},
            itemBuilder: (context) {
              return const [
                PopupMenuItem(
                  child: Text('Invite a friend'),
                  value: 'Invite a friend',
                ),
                PopupMenuItem(
                  child: Text('Contacts'),
                  value: 'Contacts',
                ),
                PopupMenuItem(
                  child: Text('Refresh'),
                  value: 'Refresh',
                ),
                PopupMenuItem(
                  child: Text('Help'),
                  value: 'Help',
                ),
              ];
            },
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style: TextStyle(color: Colors.teal),
                controller: _controller,
                cursorColor: Colors.teal,
                decoration: InputDecoration(
                  labelText: 'Search',
                  labelStyle: TextStyle(color: Colors.teal),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal)),
                  prefixIcon: Icon(Icons.search, color: Colors.teal),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: isSearching == true
                    ? contactsFiltered.length
                    : contacts.length + 2,
                itemBuilder: (context, index) {
                  if (index == 0 && isSearching != true) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => const CreateGroup()));
                      },
                      child: const ButtonCard(
                        icon: Icons.group,
                        name: 'New group',
                      ),
                    );
                  } else if (index == 1 && isSearching != true) {
                    return const ButtonCard(
                      icon: Icons.person_add,
                      name: 'New Contact',
                    );
                  }
                  return ContactCard(
                    contact: isSearching == true
                        ? contactsFiltered[index]
                        : contacts[index - 2],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
