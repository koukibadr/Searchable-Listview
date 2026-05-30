import 'package:example/data/actor.dart';

final List<Actor> actors = [
  Actor(age: 47, name: 'Leonardo', lastName: 'DiCaprio'),
  Actor(age: 58, name: 'Johnny', lastName: 'Depp'),
  Actor(age: 78, name: 'Robert', lastName: 'De Niro'),
  Actor(age: 44, name: 'Tom', lastName: 'Hardy'),
  Actor(age: 66, name: 'Denzel', lastName: 'Washington'),
  Actor(age: 49, name: 'Ben', lastName: 'Affleck'),
  Actor(age: 47, name: 'Leonardo', lastName: 'DiCaprio'),
  Actor(age: 58, name: 'Johnny', lastName: 'Depp'),
  Actor(age: 78, name: 'Robert', lastName: 'De Niro'),
  Actor(age: 44, name: 'Tom', lastName: 'Hardy'),
  Actor(age: 66, name: 'Denzel', lastName: 'Washington'),
  Actor(age: 49, name: 'Ben', lastName: 'Affleck'),
];

final Map<String, List<Actor>> mapOfActors = {
  'test 1': [
    Actor(age: 47, name: 'Leonardo', lastName: 'DiCaprio'),
    Actor(age: 66, name: 'Denzel', lastName: 'Washington'),
    Actor(age: 49, name: 'Ben', lastName: 'Affleck'),
  ],
  'test 2': [
    Actor(age: 58, name: 'Johnny', lastName: 'Depp'),
    Actor(age: 78, name: 'Robert', lastName: 'De Niro'),
    Actor(age: 44, name: 'Tom', lastName: 'Hardy'),
  ]
};
