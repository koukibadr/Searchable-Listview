import 'package:example/data/actor.dart';

final List<Actor> actors = [
  Actor(age: 47, name: 'Leonardo', lastName: 'DiCaprio'),
  Actor(age: 58, name: 'Johnny', lastName: 'Depp'),
  Actor(age: 78, name: 'Robert', lastName: 'De Niro'),
  Actor(age: 44, name: 'Tom', lastName: 'Hardy'),
  Actor(age: 66, name: 'Denzel', lastName: 'Washington'),
  Actor(age: 49, name: 'Ben', lastName: 'Affleck'),
  Actor(age: 89, name: 'Morgan', lastName: 'Freeman'),
  Actor(age: 62, name: 'Brad', lastName: 'Pitt'),
  Actor(age: 70, name: 'Tom', lastName: 'Hanks'),
  Actor(age: 77, name: 'Meryl', lastName: 'Streep'),
  Actor(age: 45, name: 'Natalie', lastName: 'Portman'),
  Actor(age: 62, name: 'Keanu', lastName: 'Reeves'),
  Actor(age: 57, name: 'Cate', lastName: 'Blanchett'),
  Actor(age: 52, name: 'Joaquin', lastName: 'Phoenix'),
  Actor(age: 41, name: 'Scarlett', lastName: 'Johansson'),
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
  ],
};
