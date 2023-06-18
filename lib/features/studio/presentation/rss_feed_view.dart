import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sonic_mobile/features/studio/presentation/widgets/copyable.dart';
import 'package:sonic_mobile/features/studio/repository/http_studio_repository.dart';
import 'package:http/http.dart' as http;

class PodcastDetail {
  final String podcastId;
  final String rssFeedUrl;
  final String atomFeedUrl;

  PodcastDetail(
      {required this.podcastId,
      required this.rssFeedUrl,
      required this.atomFeedUrl});

  factory PodcastDetail.fromJson(Map<String, dynamic> json) {
    return PodcastDetail(
      podcastId: json['podcast']['id'],
      rssFeedUrl: json['rss_feed_url'],
      atomFeedUrl: json['atom_feed_url'],
    );
  }
}

class RssView extends StatelessWidget {
  final String podcastId;
  final HttpStudioRepository httpStudioRepository;
  const RssView(
      {required this.podcastId, required this.httpStudioRepository, super.key});

  Future<dynamic> _fetchPodcastDetail() async {
    try {
      // Use the HttpStudioRepository to fetch the podcast detail
      final podcast = await httpStudioRepository.getPodcastDetail(podcastId);
      final rurl = podcast['rss_feed_url'];

      // Fetch additional information using the RSS feed URL (rurl)
      final response = await http.get(Uri.parse(rurl));
      final rssData = response.body;

      // Parse the RSS data and extract the desired information
      // Modify this part according to your specific RSS parsing requirements
      // For example, you could use an XML parser library like 'xml' or 'xml2json'
      // to parse the XML data and extract relevant fields.

      // Return the fetched podcast detail along with the additional information
      return {
        'podcast': podcast,
        'rssData': rurl,
      };
    } catch (error) {
      // Handle any errors that occur during the API request
      // You can display an error message or take appropriate action
      print('Failed to fetch podcast detail: $error');
      rethrow; // Rethrow the error to be handled higher up the widget tree
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RSS Feed Response'),
      ),
      body: FutureBuilder<dynamic>(
        future: _fetchPodcastDetail(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Display a loading indicator while fetching the podcast detail
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Display an error message if an error occurred during the API request
            return Center(child: Text('Failed to fetch podcast detail'));
          } else if (snapshot.hasData) {
            // Display the podcast detail once it's fetched successfully
            final podcast = snapshot.data!;

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Text('Podcast Name: ${podcast.rss_feed_url}'),
                Text(
                  'This is your generated RSS response. Copy the following piece of information and give it to your desired hosting platform to have your podcast accessible online',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 18),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Long Press the text to Copy',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 10,
                ),
                // Text(
                //   '${podcast['rssData']}',
                //   style: TextStyle(color: Colors.white),
                // ),
                Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: CopyableText(text: podcast['rssData']))
                // Add more widget to display other podcast details
              ],
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
