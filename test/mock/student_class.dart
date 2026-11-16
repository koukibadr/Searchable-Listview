class Student {
  String name = "";
  String lastname = "";
  String address = "";
  int age = 0;

  Student(this.name, this.age, this.address, this.lastname);
}

final List<Student> students = [
  Student('Zelin', 20, '14 Moonlight Alley, Brightvale', 'Marrowind'),
  Student('Torvik', 22, '7 Copperleaf Road, Ashenford', 'Quillfeather'),
  Student('Elowen', 19, '92 Starfall Terrace, Mistral Bay', 'Thistledown'),
  Student('Brannic', 21, '3 Lantern Hill, Oakhaven', 'Stormwhisper'),
  Student('Isolde', 23, '58 Silverbrook Lane, Willowmere', 'Fairweather'),
  Student('Cassian', 20, '21 Emberstone Way, Dunmore', 'Hollowtree'),
  Student('Nyra', 18, '40 Driftwood Court, Seaglass Point', 'Ravenscroft'),
  Student('Fenwick', 24, '66 Thornberry Close, Greycliff', 'Underhill'),
  Student('Maeve', 22, '9 Cobblestone Square, Lakemont', 'Wildermoor'),
  Student('Orin', 21, '35 Hazelwood Gate, Frostmere', 'Ashgrove'),
];
