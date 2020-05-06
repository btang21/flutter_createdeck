import 'package:flutter/material.dart';
import 'package:fluttertestapp/Data.dart';


typedef OnDelete();

class UserForm extends StatefulWidget {
  final User user;
  final state = _UserFormState();
  final OnDelete onDelete;

  UserForm({Key key, this.user, this.onDelete}) : super(key: key);
  @override
  _UserFormState createState() => state;

  bool isValid() => state.validate();
}

class _UserFormState extends State<UserForm> {
  final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Material(
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(8),
        child: Form(
          key: form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AppBar(
                leading: Icon(Icons.gradient),
                elevation: 0,
                title: Text('Deck Details'),
                backgroundColor: Theme.of(context).accentColor,
                centerTitle: true,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: widget.onDelete,
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                child: TextFormField(
                  initialValue: widget.user.text,
                  onSaved: (val) => widget.user.text = val,
                  validator: (val) =>
                  val.length > 1 ? null : 'Deck name is invalid',
                  decoration: InputDecoration(
                    labelText: 'Deck Name',
                    hintText: 'Enter your deck name',
                    icon: Icon(Icons.text_fields),
                    isDense: true,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 16,bottom: 16),
                child: TextFormField(
                  initialValue: widget.user.pro,
                  onSaved: (val) => widget.user.pro = val,
                  decoration: InputDecoration(
                    labelText: 'Prompt',
                    hintText: 'Enter a Prompt',
                    icon: Icon(Icons.announcement),
                    isDense: true,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                child: TextFormField(
                  initialValue: widget.user.des,
                  onSaved: (val) => widget.user.des = val,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    hintText: 'Enter a description',
                    icon: Icon(Icons.border_color),
                    isDense: true,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ///form validator
  bool validate() {
    var valid = form.currentState.validate();
    if (valid) form.currentState.save();
    return valid;
  }
}