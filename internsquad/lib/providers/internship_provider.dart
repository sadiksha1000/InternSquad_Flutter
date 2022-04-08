import 'package:flutter/material.dart';
import 'package:internsquad/models/employer.dart';
import '../models/internship.dart';
import 'package:provider/provider.dart';
import '../providers/employer_provider.dart';

class Internships with ChangeNotifier {
  // final employer = Employers();
  List<Internship> _internships = [
    Internship(
      id: 'i1',
      title: 'React Developer',
      workEnvironment: 'Work from Home',
      startDate: '2021 - 01 - 01',
      duration: '3',
      stipend: '20000',
      deadline: '2021 - 01 - 01',
      internshipDetails:
          'Selected intern\'s day-to-day responsibilities include:\n 1. Contributing to the phase of the development lifecycle\n 2. Providing well designed and efficient code\n 3. Designing high volume, low latency application',
      skills: 'skills',
      whoCanApply:
          'Only those candidates can apply who:\n 1. are available for the work from home job/internship\n 2. can start the work from home job/internship between 18th Jan\'22 and 22nd Feb\'22\n 3. are available for duration of 3 months\n 4. have relevant skills and interests',
      perks: 'certificates,salary',
      numberOfOpenings: '2',
      eid: Employer(
        id: 'e1',
        companyName: 'About Face',
        address: 'LA',
        email: 'afbeauty@gmail.com',
        phone: '9378473893',
        image:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/Halsey_September_2019.jpg/220px-Halsey_September_2019.jpg',
        companyProfile:
            'A paragraph is a series of related sentences developing a central idea, called the topic. Try to think about paragraphs in terms of thematic unity: a paragraph is a sentence or a group of sentences that supports one central, unified idea. Paragraphs add one idea at a time to your broader argument.A paragraph is a series of related sentences developing a central idea, called the topic. Try to think about paragraphs in terms of thematic unity: a paragraph is a sentence or a group of sentences that supports one central, unified idea. Paragraphs add one idea at a time to your broader argument.',
      ),
    ),
    // Internship(
    //   id: 'i2',
    //   title: 'Flutter Developer',
    //   workEnvironment: 'Office',
    //   startDate: DateTime(2021 - 01 - 01),
    //   duration: 3,
    //   stipend: 20000,
    //   deadline: DateTime(2021 - 01 - 01),
    //   internshipDetails: 'Workrkkrk',
    //   skills: ['programming', 'working'],
    //   whoCanApply: 'Anyone',
    //   perks: ['programming', 'working'],
    //   numberOfOpenings: 2,
    //   emp: Employer(
    //     id: 'e2',
    //     companyName: 'AF',
    //     address: 'LA',
    //     email: 'afbeauty@gmail.com',
    //     phone: '9378473893',
    //     image:
    //         'https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/Halsey_September_2019.jpg/220px-Halsey_September_2019.jpg',
    //     companyProfile: 'Classic cult beautyich',
    //   ),
    // ),
    // Internship(
    //   id: 'i3',
    //   title: 'Flutter Developer',
    //   workEnvironment: 'Office',
    //   startDate: DateTime(2021 - 01 - 01),
    //   duration: 3,
    //   stipend: 20000,
    //   deadline: DateTime(2021 - 01 - 01),
    //   internshipDetails: 'Workrkkrk',
    //   skills: ['programming', 'working'],
    //   whoCanApply: 'Me',
    //   perks: ['programming', 'working'],
    //   numberOfOpenings: 2,
    //   emp: Employer(
    //     id: 'e2',
    //     companyName: 'AF',
    //     address: 'LA',
    //     email: 'afbeauty@gmail.com',
    //     phone: '9378473893',
    //     image:
    //         'https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/Halsey_September_2019.jpg/220px-Halsey_September_2019.jpg',
    //     companyProfile: 'Classic cult beautyich',
    //   ),
    // ),
  ];

  List<Internship> get internships {
    return [..._internships];
  }

  Internship findById(String id) {
    return _internships.firstWhere((internship) => internship.id == id);
  }
}
