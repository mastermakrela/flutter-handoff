import 'package:flutter/material.dart';
import 'package:handoff/handoff.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _urlController = TextEditingController(
    text: 'https://flutter.dev',
  );
  final TextEditingController _titleController = TextEditingController(
    text: 'Browse URL from Flutter',
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Handoff Plugin Example')),
        body: Builder(
          builder: (context) {
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _urlController,
                    decoration: InputDecoration(
                      labelText: 'URL to handoff',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        await Handoff.setHandoffUrl(
                          _urlController.text,
                          title: _titleController.text,
                        );
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Handoff URL set successfully'),
                            ),
                          );
                        }
                      } catch (e) {
                        if (mounted) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text('Error: $e')));
                        }
                      }
                    },
                    child: Text('Set Handoff URL'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        HandoffPageRoute<void>(
                          handoffUrl: _urlController.text,
                          handoffTitle: _titleController.text,
                          builder: (context) => SecondPage(
                            url: _urlController.text,
                            title: _titleController.text,
                          ),
                        ),
                      );
                    },
                    child: Text('Navigate with Handoff Route'),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        await Handoff.clearHandoff();
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Handoff cleared')),
                          );
                        }
                      } catch (e) {
                        if (mounted) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text('Error: $e')));
                        }
                      }
                    },
                    child: Text('Clear Handoff'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  final String url;
  final String title;

  const SecondPage({
    super.key,
    required this.url,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Handoff Route Example'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'This route automatically set the handoff URL when entered:',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'URL: $url',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'Title: $title',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              Text(
                'When you go back, the handoff will be automatically cleared.',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Go Back (Clear Handoff)'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
