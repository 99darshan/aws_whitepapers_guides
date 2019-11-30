import 'dart:io';

import 'package:aws_whitepapers_guides/services/download_service.dart';
import 'package:flutter/material.dart';

class DownloadsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Downloads'),
        ),
        body: Container(
          color: Colors.grey[200],
          child: FutureBuilder(
              future: DownloadService.getDownloadedFilesName(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.hasError) {
                    // TODO: Error Card
                    return Text(snapshot.error.toString());
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {},
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero),
                            margin: EdgeInsets.symmetric(vertical: 4.0),
                            elevation: 2.0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                leading: null,
                                title: Text(snapshot.data[index]),
                                trailing: IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                }
              }),
        ),
      ),
    );
  }
}
