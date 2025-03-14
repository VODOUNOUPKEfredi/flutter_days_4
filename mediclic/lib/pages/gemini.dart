import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GeminiChatPage extends StatefulWidget {
  const GeminiChatPage({super.key});

  @override
  State<GeminiChatPage> createState() => _GeminiChatPageState();
}

class _GeminiChatPageState extends State<GeminiChatPage> {
  final TextEditingController _symptomsController = TextEditingController();
  final List<ChatMessage> _messages = [];
  bool _isSending = false;

  Future<void> _sendMessage() async {
    final symptoms = _symptomsController.text;

    if (symptoms.isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(text: symptoms, isUser: true));
      _symptomsController.clear();
      _isSending = true;
    });

    try {
      final response = await getGeminiResponse(symptoms,
          'AIzaSyDu3FQ3_raY5z-BFeLJ2cxCUmjVah0puyg'); // Utilisation directe des symptômes
      setState(() {
        _messages.add(ChatMessage(text: response, isUser: false));
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur : $e')),
      );
    } finally {
      setState(() {
        _isSending = false;
      });
    }
  }

  Future<String> getGeminiResponse(String symptoms, String apiKey) async {
    final url = Uri.parse(
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=AIzaSyDu3FQ3_raY5z-BFeLJ2cxCUmjVah0puyg');
    final headers = {
      'Content-Type': 'application/json',
      'x-goog-api-key': apiKey,
    };
    final body = jsonEncode({
      'contents': [
        {
          'parts': [
            {
              'text':
                  'L\'utilisateur souffre de: $symptoms. Quel ou quelles spécialiste (s) lui conseillerais tu ?'
            }
          ]
        }
      ],
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      return decodedResponse['candidates'][0]['content']['parts'][0]['text'];
    } else {
      throw Exception('Failed to get Gemini response: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Discussion avec Gemini')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _messages[index];
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _symptomsController,
                    decoration: const InputDecoration(
                        hintText:
                            'Hello,Que ressentez vous?'), // Utilisation comme champ de saisie principal
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _isSending ? null : _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;

  const ChatMessage({super.key, required this.text, required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isUser ? Colors.blue[100] : Colors.grey[300],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(text),
      ),
    );
  }
}
