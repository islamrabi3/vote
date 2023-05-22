class Candidate {
  String? name;
  int? votes;
  int? id;

  Candidate({this.name, this.votes, this.id});

  Map<String, dynamic> toJson() => {
        'name': name,
        'votes': votes,
        'id': id,
      };
}

List<Candidate> candiates = [
  Candidate(name: 'Ahmed Hesham', votes: 0, id: 1),
  Candidate(name: 'Omar Ahmed', votes: 0, id: 2),
  Candidate(name: 'Osama Mohamed', votes: 0, id: 3),
  Candidate(name: 'Farah Hany', votes: 0, id: 4),
  Candidate(name: 'Ahmed Walid', votes: 0, id: 5),
];
