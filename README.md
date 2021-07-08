# Gigih

Re-learning Object-oriented Programming Fundamentals.

## Object vs Class

**Object** is the instance which represents entities existing in the real world.

**Class** is the blueprint of the object, which describe its data (state) and behavior.

A class contains of _State_ that stores data and _Behavior_ that describes actions in the form of methods.

| Class                 |
|-----------------------|
| State<br><br>         |
| Behaviour<br><br><br> |
|                       |

## Modules
OOP has four principles.

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

_Why do we need polymorphism?_
- Allows us to treat some objects from different classes in the same manner (for efficiency), as long as the objects follow the same rule.

    > Polymorphism allows us to perform a single action in different ways. In other words, polymorphism allows you to define one interface and have multiple implementations. _-GeeksforGeeks_

**Inheritance vs Polymorphism**

Polymorphism use the concept of inheritance to make it happen.
