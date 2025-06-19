import 'package:example/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class VcloudHomeUi extends StatelessWidget {
  final VCloudHomeState state;

  const VcloudHomeUi({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('V.cloud Room Management'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Settings'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: state.projectIDController,
                          decoration: InputDecoration(labelText: 'Project ID'),
                        ),
                        TextField(
                          controller: state.moderatorIdController,
                          decoration:
                              InputDecoration(labelText: 'Moderator ID'),
                        ),
                        TextField(
                          controller: state.clientRoomIdController,
                          decoration: InputDecoration(
                              labelText: 'Client Room ID (optional)'),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('Close'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Room Creation Section
            Text('Room Creation',
                style: Theme.of(context).textTheme.titleMedium),
            SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                ElevatedButton(
                  onPressed:
                      state.isLoading ? null : state.createQuickAudioRoom,
                  child: Text('Create Quick Audio Room'),
                ),
                ElevatedButton(
                  onPressed:
                      state.isLoading ? null : state.createQuickVideoRoom,
                  child: Text('Create Quick Video Room'),
                ),
                ElevatedButton(
                  onPressed:
                      state.isLoading ? null : state.createScheduledAudioRoom,
                  child: Text('Create Scheduled Audio Room'),
                ),
                ElevatedButton(
                  onPressed:
                      state.isLoading ? null : state.createScheduledVideoRoom,
                  child: Text('Create Scheduled Video Room'),
                ),
              ],
            ),

            SizedBox(height: 16),

            // Room Management Section
            Text('Room Management',
                style: Theme.of(context).textTheme.titleMedium),
            SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                ElevatedButton(
                  onPressed: state.isLoading ? null : state.startScheduledRoom,
                  child: Text('Start Scheduled Room'),
                ),
                ElevatedButton(
                  onPressed: state.isLoading ? null : state.joinRoom,
                  child: Text('Join Room'),
                ),
                ElevatedButton(
                  onPressed:
                      state.isLoading ? null : state.createInvitationLink,
                  child: Text('Create Invitation Link'),
                ),
                ElevatedButton(
                  onPressed: state.isLoading ? null : state.endRoom,
                  child: Text('End Room'),
                ),
                ElevatedButton(
                  onPressed: state.isLoading ? null : state.checkRoomStatus,
                  child: Text('Check Room Status'),
                ),
              ],
            ),

            SizedBox(height: 24),

            // Room Management Sectionasdas
            Text('Room Information',
                style: Theme.of(context).textTheme.titleMedium),
            SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                ElevatedButton(
                  onPressed: state.isLoading ? null : state.getActiveRoom,
                  child: Text('get active room'),
                ),
                ElevatedButton(
                  onPressed: state.isLoading ? null : state.getActiveRooms,
                  child: Text('get active rooms'),
                ),
                ElevatedButton(
                  onPressed: state.isLoading ? null : state.fetchPastRooms,
                  child: Text('fetch past rooms'),
                ),
                ElevatedButton(
                  onPressed: state.isLoading ? null : state.getRecording,
                  child: Text('get recording'),
                ),
                ElevatedButton(
                  onPressed: state.isLoading ? null : state.getAnalytics,
                  child: Text('get analytics'),
                ),
              ],
            ),
            SizedBox(height: 24),

            ///change server configuration like api key and base url
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: OutlinedButton(
                child: Text('change api key and base url'),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Change API Key and Base URL'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: state.apiKeyController,
                              decoration: InputDecoration(labelText: 'API Key'),
                              onChanged: (value) {
                                client.setApiKey(value);
                              },
                            ),
                            TextField(
                              controller: state.baseUrlController,
                              decoration:
                                  InputDecoration(labelText: 'Base URL'),
                              onChanged: (value) {
                                client.setBaseUrl(value);
                              },
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text('Close'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 24),
            // Status and Information Section
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Status and Information',
                        style: Theme.of(context).textTheme.titleMedium),
                    SizedBox(height: 8),
                    if (state.isLoading)
                      Center(child: CircularProgressIndicator()),
                    SizedBox(height: 8),
                    Text('Current Room ID:'),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: state.currentRoomIdController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                hintText: 'Enter room ID',
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.copy),
                                onPressed: () {
                                  final text =
                                      state.currentRoomIdController.text;
                                  if (text.isNotEmpty) {
                                    Clipboard.setData(
                                        ClipboardData(text: text));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Room ID copied to clipboard')),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text('No Room ID to copy')),
                                    );
                                  }
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.paste),
                                onPressed: () async {
                                  final clipboardData =
                                      await Clipboard.getData('text/plain');
                                  if (clipboardData?.text != null) {
                                    state.currentRoomIdController.text =
                                        clipboardData!.text!;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Room ID pasted from clipboard')),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text('No Room ID to paste')),
                                    );
                                  }
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  state.currentRoomIdController.clear();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Room ID cleared')),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 4),
                    SelectableText('Status: ${state.statusMessage}'),
                    if (state.joinUrl != null) ...[
                      SizedBox(height: 8),
                      Text('Join URL:'),
                      SelectableText(state.joinUrl!),
                      SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () async {
                          final Uri url = Uri.parse(state.joinUrl!);
                          if (!await launchUrl(url)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Could not launch $url')),
                            );
                          }
                        },
                        child: Text('Open Join URL'),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
