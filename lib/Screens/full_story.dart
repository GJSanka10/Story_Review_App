
import 'package:flutter/material.dart';
import 'package:story_app/utils/colors.dart';


class FullStoryScreen extends StatelessWidget {
  final Map<String, dynamic> story;

  const FullStoryScreen({Key? key, required this.story}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final createdDate = DateTime.parse(story['createdDate']).toLocal();
    final formattedDate =
        "${createdDate.day}, ${_getMonthAbbreviation(createdDate.month)}, ${createdDate.year}";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(10),
        child: AppBar(
          elevation: 0.0,
          backgroundColor: colors.back,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          //borderRadius: BorderRadius.circular(2.0),
          borderRadius: BorderRadius.all(Radius.circular(0)),
          color: Color.fromRGBO(233, 215, 208, 1),

        
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 249, 249, 249),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0,left: 20.0,top: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: colors
                            .btnColor, // You can set your desired color here
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(0), // Add your desired padding here
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),

                  Padding(
                    padding: const EdgeInsets.only(right: 20.0,left: 20.0,top: 20.0),
                    child: Text(
                      formattedDate,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Color.fromARGB(255, 32, 31, 33),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0,left: 20.0,top: 20.0),
                    child: Text(
                      story['title'] ?? 'Untitled',
                      style: TextStyle(fontSize: 20.0, color: colors.date),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0,left: 20.0,top: 20.0),
                    child: Text(
                      story['description'] ?? 'No content available',
                      style: const TextStyle(fontSize: 18.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _getMonthAbbreviation(int month) {
    switch (month) {
      case 1:
        return 'JAN';
      case 2:
        return 'FEB';
      case 3:
        return 'MAR';
      case 4:
        return 'APR';
      case 5:
        return 'MAY';
      case 6:
        return 'JUN';
      case 7:
        return 'JUL';
      case 8:
        return 'AUG';
      case 9:
        return 'SEP';
      case 10:
        return 'OCT';
      case 11:
        return 'NOV';
      case 12:
        return 'DEC';
      default:
        return '';
    }
  }
}

