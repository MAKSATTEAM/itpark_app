import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ContactOrganizerPage extends StatefulWidget {
  const ContactOrganizerPage({Key? key}) : super(key: key);

  @override
  _ContactOrganizerPageState createState() => _ContactOrganizerPageState();
}

class _ContactOrganizerPageState extends State<ContactOrganizerPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSubmitting = false;
  bool _isSubmitted = false;
  String? eventId;
  String? participantId;
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _loadParticipantAndEventId();
  }

  Future<void> _loadParticipantAndEventId() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    participantId = await secureStorage.read(key: 'participantId');
    eventId = sharedPreferences.getString('eventId');
    setState(() {});
  }

  Future<void> _submitFeedback() async {
    if (!_formKey.currentState!.validate() || eventId == null || participantId == null) return;

    setState(() {
      _isSubmitting = true;
    });

    final queryParameters = {
      'Title': _titleController.text,
      'Message': _messageController.text,
    };
    
    final uri = Uri.https(
      'sprouts.maksat.pro',
      '/api/events/$eventId/participants/$participantId/feedback',
      queryParameters,
    );

    Map<String, String> headers = {'Content-Type': 'application/json'};
    String? accessToken = await secureStorage.read(key: 'accessToken');

    if (accessToken != null && accessToken.isNotEmpty) {
      headers['Authorization'] = 'Bearer $accessToken';
    }

    final response = await http.post(
      uri,
      headers: headers,
    );

    print('Отправка запроса на $uri');
    print('Код ответа: ${response.statusCode}');

    setState(() {
      _isSubmitting = false;
      _isSubmitted = response.statusCode == 200;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    if (_isSubmitted) {
      return Scaffold(
        appBar: AppBar(
          title: Text(localizations?.contactOrganizer ?? 'Связь с организатором'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, color: Colors.blue, size: 80),
              SizedBox(height: 20),
              Text(
                localizations?.thankYou ?? 'Спасибо!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(localizations?.feedbackReceived ?? 'Спасибо, что поделились своим мнением. Мы скоро вам ответим!'),
              SizedBox(height: 20),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  localizations?.returnToMain ?? 'Вернуться на главную',
                  style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations?.contactOrganizer ?? 'Связь с организатором'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: eventId == null || participantId == null
            ? Center(child: CircularProgressIndicator())
            : Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: localizations?.subject ?? 'Тема',
                        labelStyle: TextStyle(fontSize: 18, color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return localizations?.enterSubject ?? 'Пожалуйста, введите тему';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        labelText: localizations?.comment ?? 'Ваш комментарий',
                        labelStyle: TextStyle(fontSize: 18, color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      maxLines: 6,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return localizations?.enterComment ?? 'Пожалуйста, введите ваш комментарий';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: _isSubmitting ? null : _submitFeedback,
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50),
                          backgroundColor: _isSubmitting ? Colors.grey : Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: _isSubmitting
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text(
                                localizations?.send ?? 'Отправить',
                                style: TextStyle(fontSize: 18, color: Colors.white),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
