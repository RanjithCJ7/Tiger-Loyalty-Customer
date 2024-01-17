import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tl_customer/const/Image.dart';

// ignore: must_be_immutable
class ViewProfile extends StatefulWidget {
  Uint8List? bytes;

  ViewProfile({super.key, this.bytes});

  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  late Socket socket;
  late String serverResponse;

  @override
  void initState() {
    super.initState();
    createServer();
    connectToServer();
  }

  createServer() async {
    try {
      // Create a server socket that listens on a specific port
      var serverSocket = await ServerSocket.bind(
        '127.0.0.1',
        12345,
        shared: true,
      ); // Replace with your server IP and port

      print('Server listening on port ${serverSocket.port}');

      // Listen for incoming connections
      await for (var socket in serverSocket) {
        handleClient(socket);
      }
    } catch (e) {
      print('Error starting server: $e');
    }
  }

  void handleClient(Socket socket) {
    print('Client connected: ${socket.remoteAddress}:${socket.remotePort}');

    // Handle communication with the client here

    socket.listen(
      (List<int> data) {
        String message = String.fromCharCodes(data);
        print('Received from client: $message');
        // Handle the received message
      },
      onDone: () {
        print('Client disconnected');
      },
      onError: (error) {
        print('Error with client: $error');
      },
      cancelOnError: true,
    );
  }

  Future<void> connectToServer() async {
    try {
      // Connect to the server
      socket = await Socket.connect(
          '127.0.0.1', 12345); // Replace with your server IP and port
      print('Connected to server');
      socket.listen(
        (List<int> data) {
          String response = utf8.decode(data);
          print('Received from server: $response');
          setState(() {
            serverResponse = response;
          });
        },
        onDone: () {
          print('Connection closed by server');
        },
        onError: (error) {
          print('Error with connection: $error');
        },
        cancelOnError: true,
      );

      // Send a message to the server
      sendMessage(socket, 'Hello, server!');
    } catch (e) {
      print('Error connecting to server: $e');
    } finally {}
  }

  void sendMessage(Socket socket, String message) {
    socket.write(message);
    print('Sent to server: $message');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            widget.bytes != null
                ? SizedBox(
                    height: Get.height,
                    child: Image.memory(widget.bytes!),
                  )
                : CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage(
                      Images.profile,
                    ),
                    radius: Get.height * 0.06,
                  ),
            Positioned(
              right: 10,
              top: 10,
              child: InkWell(
                onTap: () {
                  Get.back();
                  // sendMessage(socket, "message");
                },
                child: Image.asset('assets/close.png'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
