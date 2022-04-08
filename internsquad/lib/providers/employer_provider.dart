import 'package:flutter/foundation.dart';
import '../models/employer.dart';

class Employers with ChangeNotifier {
  final List<Employer> _employers = [
    Employer(
      id: 'e1',
      companyName: 'AboutFace',
      address: 'California',
      email: 'afbeauty@gmail.com',
      phone: '9378473893',
      image:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/Halsey_September_2019.jpg/220px-Halsey_September_2019.jpg',
      companyProfile:
          'A paragraph is a series of related sentences developing a central idea, called the topic. Try to think about paragraphs in terms of thematic unity: a paragraph is a sentence or a group of sentences that supports one central, unified idea. Paragraphs add one idea at a time to your broader argument.',
    )
  ];

  List<Employer> get employers {
    return [..._employers];
  }

  Employer findById(String id) {
    return _employers.firstWhere((employer) => employer.id == id);
  }
}
