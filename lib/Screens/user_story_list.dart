import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:story_app/utils/colors.dart';
import 'package:story_app/Screens/full_story.dart';
import 'package:story_app/utils/get_api.dart';

class Story extends StatefulWidget {
  final String userId;
  final String firstName;

  const Story({Key? key, required this.userId, required this.firstName})
      : super(key: key);

  @override
  _StoryState createState() => _StoryState();
}

class _StoryState extends State<Story> {
  List<Map<String, dynamic>> allStories = [];
  List<Map<String, dynamic>> filteredStories = [];
  DateTime selectedDate = DateTime.now(); // Initialize with the current date
  StoryService storyService = StoryService();

  @override
  void initState() {
    super.initState();
    // Fetch stories when the widget is initialized
    fetchStories();
  }
   Future<void> fetchStories() async {
    // Call the fetchStories method from the StoryService instance
    List<Map<String, dynamic>> stories = await storyService.fetchStories(widget.userId);

    setState(() {
      allStories = stories;
      filterStories();
    });
  }

  void filterStories() {
    setState(() {
      filteredStories = allStories.where((story) {
        DateTime storyDate = DateTime.parse(story['createdDate']).toLocal();
        DateTime selectedDateWithoutTime =
            DateTime(selectedDate.year, selectedDate.month, selectedDate.day)
                .toLocal();
        return storyDate.year == selectedDateWithoutTime.year &&
            storyDate.month == selectedDateWithoutTime.month &&
            storyDate.day == selectedDateWithoutTime.day;
      }).toList();
    });
  }

  Future<void> refreshData() async {
    await fetchStories(); // Refresh the stories
    // Add any other refresh logic here if needed
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => refreshData(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(10),
          child: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
          ),
        ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('images/face.png'),
                  radius: 30.0,
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Good Afternoon,',
                      style: GoogleFonts.nunitoSans(
                          fontSize: 16.0, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '${widget.firstName}!',
                      style: GoogleFonts.nunitoSans(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: colors.btnColor),
                    )
                  ],
                ),
              ],
            ),
          ),
          // Horizontal date list view
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EasyDateTimeLine(
                  initialDate: DateTime.now(),
                  onDateChange: (selectedDate) {
                    setState(() {
                      this.selectedDate = selectedDate;
                      filterStories();
                    });
                    //[selectedDate] the new date selected.
                  },
                  activeColor: colors.btnColor,
                  headerProps: const EasyHeaderProps(
                    showHeader: false,
                  ),
                  dayProps: EasyDayProps(
                      todayHighlightStyle: TodayHighlightStyle.withBackground,
                      todayHighlightColor: const Color(0xffE1ECC8),
                      todayStyle: DayStyle(
                          decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                        border: Border.all(
                            color: const Color.fromRGBO(232, 178, 166, 1),
                            width: 2.0),
                      )),
                      // ignore: deprecated_member_use
                      inactiveDayDecoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                        border: Border.all(
                            color: const Color.fromRGBO(232, 178, 166, 1),
                            width: 2.0),
                      ),

                      // ignore: deprecated_member_use
                      activeBorderRadius: 25.0,
                      // ignore: deprecated_member_use
                      activeDayNumStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                      // ignore: deprecated_member_use
                      activeDayStrStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                      // ignore: deprecated_member_use
                      activeMothStrStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),

                      // ignore: deprecated_member_use
                      inactiveDayNumStyle: const TextStyle(
                          color: Color.fromRGBO(232, 178, 166, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                      // ignore: deprecated_member_use
                      inactiveDayStrStyle: const TextStyle(
                          color: Color.fromRGBO(232, 178, 166, 1),
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                      // ignore: deprecated_member_use
                      inactiveMothStrStyle: const TextStyle(
                          color: Color.fromRGBO(232, 178, 166, 1),
                          fontWeight: FontWeight.w500,
                          fontSize: 16),

                      // ignore: deprecated_member_use
                      todayNumStyle: const TextStyle(
                          color: Color.fromRGBO(232, 178, 166, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                      // ignore: deprecated_member_use
                      todayStrStyle: const TextStyle(
                          color: Color.fromRGBO(232, 178, 166, 1),
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                      // ignore: deprecated_member_use
                      todayMonthStrStyle: const TextStyle(
                          color: Color.fromRGBO(232, 178, 166, 1),
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                      dayStructure: DayStructure.dayStrDayNumMonth),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 0.9,
                ),
                itemCount: filteredStories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              FullStoryScreen(story: filteredStories[index]),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: colors
                            .storyTextColor, // Set the background color here
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Align(
                          alignment: Alignment
                              .topLeft, // Adjust the alignment as needed
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                filteredStories[index]['title'] ?? 'Untitled',
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                filteredStories[index]['description'] ??
                                    'No description available',
                                style: const TextStyle(
                                  fontSize: 14.0,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {});
        },
        backgroundColor: colors.btnColor,
        child: const Icon(Icons.add),
      ),
    )
    );
  }
}

