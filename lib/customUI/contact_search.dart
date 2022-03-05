import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:whosapp/customUI/contact_cart.dart';

class ContactSearch extends SearchDelegate<String> {
  Contact? _FilteredContacts;
  List<Contact> _contacts = [];

  Future getSearchData() async {
    _contacts = (await ContactsService.getContacts()).toList();
    for (int i = 0; i < _contacts.length; i++) {
      if (_contacts[i].displayName == query) {
        _FilteredContacts = _contacts[i];
      }
    }
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, '');
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
        future: getSearchData(),
        builder: (BuildContext context, AsyncSnapshot) {
          return ContactCard(contact: _FilteredContacts!);
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var searchList = query.isEmpty
        ? _contacts
        : _contacts
            .where((element) => element.displayName!.startsWith(query))
            .toList();
    return ListView.builder(
        itemCount: searchList.length,
        itemBuilder: (context, i) {
          return ContactCard(
            contact: _contacts[i],
          );
        });
  }
}
