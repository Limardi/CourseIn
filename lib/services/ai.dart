import 'dart:convert';
import 'package:assistant_openai/openaiassistant.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:project_ss/data/dummy_data.dart';
import 'package:project_ss/model/courses.dart';
import 'package:project_ss/pages/AI_detail.dart';
import 'package:project_ss/services/navigation.dart';
import 'package:provider/provider.dart';

Future<void> createCompletion(BuildContext context, String credit,
    String semester, List<List<Course>> taken) async {
  List<String> takenCourses = [];
  print(taken);
  for (var i in taken) {
    for (var j in i) {
      takenCourses.insert(0, j.title);
    }
  }
  String res = takenCourses.join(", ");
  print(res);
  generateSemester = int.parse(semester);
  String season = (int.parse(semester) & 2 == 0) ? 'Spring' : 'Fall';

  String prompt = 'short answer only: I have already taken these courses: ' +
      res +
      '. please give me exactly ' +
      credit +
      ' credits to take on semester ' +
      semester +
      ' as an EECS students during ' +
      season +
      ' semester It have to be other courses that I havent take yet and start searching from recommended course semester 1 to 2 to 3 and so on. make the output absolutely look like this coursenum = "the number"';
  final nav = Provider.of<NavigationService>(context, listen: false);
  nav.goToLoadingPage();
  final _apiKey =
      ''; // Replace with your OpenAI API key

  final _assistantId = 'asst_ZEygT9WuQls0UbW4HEzYazty';

  const String _baseUrl = 'https://api.openai.com/v1';

  final openAI = OpenAI.instance.build(
      token: _apiKey,
      baseOption: HttpSetup(
          receiveTimeout: const Duration(seconds: 5),
          connectTimeout: const Duration(seconds: 60)),
      enableLog: true);

  final thread = await openAI.threads.createThread(request: ThreadRequest());
  String _threadId = thread.id;
  String _messagesUrl = '$_baseUrl/threads/$_threadId/messages';
  String _runsUrl = '$_baseUrl/threads/$_threadId/runs';

  var promptResponse = await http.post(
    Uri.parse(_messagesUrl),
    headers: {
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization': 'Bearer $_apiKey',
      'OpenAI-Beta': 'assistants=v2',
    },
    body: jsonEncode({
      'role': 'user',
      'content': prompt,
    }),
  );

  if (promptResponse.statusCode != 200) {
    throw Exception('Failed to add prompt: ${promptResponse.statusCode}');
  }
  var data = json.decode(promptResponse.body);
  print(data);

  var runResponse = await http.post(
    Uri.parse(_runsUrl),
    headers: {
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization': 'Bearer $_apiKey',
      'OpenAI-Beta': 'assistants=v2',
    },
    body: jsonEncode({
      'assistant_id': _assistantId,
      // Additional instructions can be passed here if needed
    }),
  );

  // Check if run was successfully created
  if (runResponse.statusCode != 200) {
    throw Exception('Failed to create a run: ${runResponse.statusCode}');
  }
  //print(runResponse);

  var runData = json.decode(runResponse.body);
  print(runData);
  var runId = runData['id'];
  String runStatusUrl = '$_baseUrl/threads/$_threadId/runs/$runId';
  while (true) {
    // Wait for a short period before checking again
    await Future.delayed(Duration(seconds: 10));

    var runStatusResponse = await http.get(
      Uri.parse(runStatusUrl),
      headers: {
        'Authorization': 'Bearer $_apiKey',
        'Content-Type': 'application/json; charset=utf-8',
        'OpenAI-Beta': 'assistants=v2',
      },
    );
    if (runStatusResponse.statusCode != 200) {
      throw Exception(
          'Failed to query run status: ${runStatusResponse.statusCode}');
    }
    var runStatusData = json.decode(runStatusResponse.body);
    print(runStatusData);
    var runStatus = runStatusData['status'];
    if (runStatus == 'cancelled' ||
        runStatus == 'failed' ||
        runStatus == 'expired') {
      throw Exception('Run failed: ${runStatusData['status']}');
    }
    // Indicate that Function Calling is used (see: https://platform.openai.com/docs/assistants/tools/function-calling)

    if (runStatus == 'completed') {
      break;
    }
  }

  print("OIOIOIOIOI");
  var response = await http.get(
    Uri.parse(_messagesUrl),
    headers: {
      'Authorization': 'Bearer $_apiKey',
      'OpenAI-Beta': 'assistants=v2',
    },
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to fetch messages: ${response.statusCode}');
  }

  var responseData = json.decode(utf8.decode(response.bodyBytes));
  for (var message in responseData['data']) {
    print("HMMMMM");
    print(message['content'][0]['text']['value']);
    RegExp regExp = RegExp(r'coursenum = "(\w+ \d+)"');
    Iterable<RegExpMatch> matches =
        regExp.allMatches(message['content'][0]['text']['value']);
    courseNums = matches.map((match) => match.group(1)!).toList();

    print(courseNums);
    break;
  }
  nav.goToResultPage();
  //print(responseData[0]['content'][0]['text']['value']);
}

Future<void> askAIabt(String prompt) async {
  titleC = prompt;
  String text = 'What is the pros and cons taking ' +
      prompt +
      ' course. Answer with around 200 words only';
  final apiKey =
      ''; // Replace with your OpenAI API key
  final url = 'https://api.openai.com/v1/chat/completions';
  final String _assistantId = 'asst_ZEygT9WuQls0UbW4HEzYazty';

  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $apiKey',
    'OpenAI-Beta': 'assistants=v1'
  };
  final body = jsonEncode({
    'model': 'gpt-4o',
    'messages': [
      {
        'role': 'user',
        'content': text,
      }
    ],
  });

  final response =
      await http.post(Uri.parse(url), headers: headers, body: body);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print('Response:');
    print(data['choices'][0]['message']['content']);
    aiResponse = data['choices'][0]['message']['content'];
  } else {
    print('Request failed with status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}
