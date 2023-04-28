import 'package:flutter/material.dart';
import '../models/photo.dart';
import '../views/photosScreen.dart';

class AddPhotoForm extends StatefulWidget {
  @override
  _AddPhotoFormState createState() => _AddPhotoFormState();
}

class _AddPhotoFormState extends State<AddPhotoForm> {
  final _formKey = GlobalKey<FormState>();
  final _albumIdController = TextEditingController();
  final _titleController = TextEditingController();
  final _thumbnailUrlController = TextEditingController();
  final _urlController = TextEditingController();

  @override
  void dispose() {
    _albumIdController.dispose();
    _titleController.dispose();
    _thumbnailUrlController.dispose();
    _urlController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        final photo = await Photo.createPhoto(
          title: _titleController.text,
          thumbnailUrl: _thumbnailUrlController.text,
          albumId: int.tryParse(_albumIdController.text),
          url: _urlController.text,
        );
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PhotoScreen()));
      } catch (e) {
        throw Exception('Failed to create photo');
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Photo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _thumbnailUrlController,
                decoration: InputDecoration(
                  labelText: 'Thumbnail URL',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a thumbnail URL';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _albumIdController,
                decoration: InputDecoration(
                  labelText: 'Album ID',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _urlController,
                decoration: InputDecoration(
                  labelText: 'URL',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
