# Gigih

Re-learning Object-oriented Programming Fundamentals, demonstrated in Ruby.

## Dependencies
1. Ruby <=2.7.3

## How to Run
1. Go straight to one of the folder.
2. Execute by running

        ruby app.rb

## Concepts

## Object vs Class

**Object** is the instance which represents entities existing in the real world.

**Class** is the blueprint of the object, which describe its data (state) and behavior.

A class contains of _State_ that stores data and _Behavior_ that describes actions in the form of methods.

| Class                     |
|---------------------------|
| State<br><br>             |
| Behaviour<br><br><br><br> |

## OOP Principles
OOP has four principles—Abstraction, Encapsulation, Inheritance, Polymorphism, and Composition.

### 01. Abstraction & Encapsulation

**Abstraction** is handling complexity by hiding _unnecessary details_ to be known by other entities.

For example, in a Rectangle geometry, we don't need to know the calculation of area (length x width), so we better to hide it by wrapping it as a _method_.

_Why do we need to hide complexities?_
- Better control over your code (which means easier debugging!).

**Encapsulation** is restricting direct access to object's states, by wrapping the actions to access states as methods in the class.

_Why do we need to restrict direct access?_
- To prevent illegal change of object state
- Minimize dependency with other class or module (_coupling_), because when we put the action in another class/module, our class depend on it. Lower dependency means lower coupling.
- Again, those leads to better control over your code.

**Abstaction vs Encapsulation**

Abstraction is the process in conceptual or design level, meanwhile Encapsulation is the process in implementation level. Encapsulation supports Abstraction.

### 02. Inheritance & Polymorphism

**Inheritance** enables a class to inherit their behaviour or state to another class.

_Why do we need inheritance?_
- Rather than defining separated classes that have commonalities, it's more efficient to reuse a class which inherits other.

Inheritance can be _multilevel_ (a class can inherit a class which inherit another class) or _multiple_ (a class can be derived from more than one class).

**Polymorphism** enables an object to have many form of classes in the runtime. The form of an object is destined in the runtime.

_Why do we need Polymorphism?_

It Allows us to treat some objects from different classes in the same manner (for efficiency), as long as the objects follow the same rule.

    > Polymorphism allows us to perform a single action in different ways. In other words, polymorphism allows you to define one interface and have multiple implementations. _-GeeksforGeeks_

Polymorphism can be formed through _abstract class_ and _duck typing_.

_Duck Typing_ is a type system used in dynamic typing (as we know, implemented in Ruby and Python).
With normal typing, suitability is determined by an object's type.

> "If it walks like a duck and it quacks like a duck, then it must be a duck" -Duck Typing principle

Just like in Ruby, we don't define nor restrict any variables to be a type we want. If it has particular behaviors we expected, then it will also run as we expected. If it don't, it just simply raise error—all destined in the _runtime_.

**Inheritance vs Polymorphism**

Polymorphism use the concept of inheritance to make it happen.

### 03. Composition

**Composition** is building a class by combining multiple classes. It's on par with _Inheritance_ which is categorized as relation between classes.

**Dependency Injection** is making a class independent of its dependencies.

In other words, DI means referring the dependency classes through parameter, rather than incorporating the concrete implementation of those dependency classes.

It helps client to be isolated from the impact of design change.

_Why do we need Composition, (since we have Inheritance already)?_

In some classes, if we use inheritance, exposing parent's methods and attributes to the child class is unnecessary, and it might break encapsulation. For example: 

> Inheritance creates dependency between child and parent, when a class inherit another class, we include all methods and attributes from parent class and expose to the child class, therefore we break the encapsulation, the child object can access all the methods in parent object and overwrite them. -_https://neethack.com/2017/04/Why-inheritance-is-bad/_

So better to _compose_ some classes in a single class. E.g. Car is composed of Engine, CarFrame, CarInterior, etc.

## Contribute

Feel free to add another explanation, make correction, or rephrase my words to make it more understandable. :)