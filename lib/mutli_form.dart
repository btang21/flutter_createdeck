import 'package:flutter/material.dart';
import 'package:fluttertestapp/Data.dart';
import 'package:fluttertestapp/DeckForm.dart';
import 'package:fluttertestapp/empty_state.dart';

class MultiForm extends StatefulWidget {
  @override
  _MultiFormState createState() => _MultiFormState();
}

class _MultiFormState extends State<MultiForm> {
  List<UserForm> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: .0,
        leading: Icon(
          Icons.format_align_justify,
        ),
        title: Text('Create a Deck'),
        actions: <Widget>[
          FlatButton(
            child: Text('Save'),
            textColor: Colors.white,
            onPressed: onSave,
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue[400],
              Colors.white,
              //Color(0xFF2AA7DC),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: users.length <= 0
            ? Center(
          child: EmptyState(
            title: 'Whoops! No Decks Found',
            message: 'Create a deck by tapping the plus button below',
          ),
        )
            : ListView.builder(
          addAutomaticKeepAlives: true,
          itemCount: users.length,
          itemBuilder: (_, i) => users[i],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: onAddForm,
        foregroundColor: Colors.white,
      ),
    );
  }

  ///on form user deleted
  void onDelete(User _user) {
    setState(() {
      var find = users.firstWhere(
            (it) => it.user == _user,
        orElse: () => null,
      );
      if (find != null) users.removeAt(users.indexOf(find));
    });
  }

  ///on add form
  void onAddForm() {
    setState(() {
      var _user = User();
      users.add(UserForm(
        user: _user,
        onDelete: () => onDelete(_user),
      ));
    });
  }

  ///on save forms
  void onSave() {
    if (users.length > 0) {
      var allValid = true;
      users.forEach((form) => allValid = allValid && form.isValid());
      if (allValid) {
        var data = users.map((it) => it.user).toList();
        Navigator.push(
          context,
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (_) => Scaffold(
              appBar: AppBar(
                title: Text('List of Decks'),
              ),
              body: ListView.builder(
                itemCount: data.length,
                itemBuilder: (_, i) => ListTile(
                  leading: CircleAvatar(
                    child: Text(data[i].text.substring(0, 1)),
                  ),
                  title: Text(data[i].text),
                  subtitle: Text(data[i].des),
                    trailing:
                    FlatButton(
                      child: Text('Edit'),
                      textColor: Colors.white,
                      color: Colors.orange,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Edit(data:data[i] )),
                        );
                      },
                    ),
                ),
              ),
            ),
          ),
        );
      }
    }
  }
}

class Edit extends StatelessWidget {

  final User data;

  Edit({this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Deck Editor"),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                  'Name',
                  style: TextStyle(
                      color: Colors.blue,
                      letterSpacing: 2.0
                  )
              ),
              SizedBox(height: 10.0),
              Text(
                //'joe',
                  data.text,
                  style: TextStyle(
                    color: Colors.orange,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold,
                    fontSize: 28.0,
                  )
              ),
              SizedBox(height: 30.0),
              Text(
                  'Add a Question ',
                  style: TextStyle(
                      color: Colors.blue,
                      letterSpacing: 2.0
                  )
              ),
              SizedBox(height: 10.0),
              TextFormField(

                style: TextStyle(
                  color: Colors.orange,
                  decorationColor: Colors.orange,

                ),
                decoration: const InputDecoration(
                  fillColor: Colors.orange,
                  icon: Icon(Icons.text_fields),
                  hintText: 'Make a Prompt Card',
                  //hoverColor:Colors.orange
                  //labelText: 'Prompt',
                ),
                onSaved: (String value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
                validator: (String value) {
                  return value.contains('@') ? 'Do not use the @ char.' : null;
                },
              ),
              SizedBox(height: 30.0),
              Text(
                  'Description',
                  style: TextStyle(
                      color: Colors.blue,
                      letterSpacing: 2.0
                  )
              ),
              SizedBox(height: 10.0),
              Text(
                //'joe',
                  data.des,
                  style: TextStyle(
                    color: Colors.orange,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  )
              ),
              SizedBox(height: 30.0),
            ],
          ),
        )
    );
  }
}
