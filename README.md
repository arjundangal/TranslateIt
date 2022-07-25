# TranslateIt
> An ios app that allows you to learn languages by playing games.

### Requirements

* ios 13 + 
* xcode 13.2 +
* cocoapods 1.11.2 

### Installation
Please clone the project and open **TranslateItApp.xcworkspace** to run the project.

### Dependencies

Following Third-party dependencies are added via cocoa pods.

* RxSwift (reactive programming)
* RxTests (unit testing)
 
### Design Pattern
The MVVM Design pattern is used. It helps us to separate business logic from UI and makes testing easier.
 
### Testing 
Unit Testing and Basic UI Tests are done


### How much time was invested
 Around 8 hours, 2 hours for Milestone1, 3 for Milestone2 and 3 for Milestone3

### How was the time distributed (concept, model layer, view(s), game mechanics)
Around 30 minutes for understanding projects, around 2 hour for model layer, around 2 hour for game Mechanics, 1 hour for result view and around 2.5 hours for testing


### Decisions made to solve certain aspects of the game
Game Data Provider provides 25 % of the correct pairs where as rest 75% can be either correct or wrong

### Decisions made because of restricted time
Didn't focus on UI part
Didn't unit test timer part

● What would be the first thing to improve or add if there had been more time
Increase Test Coverage

### Future Plans
* Improve UI
* More test coverage (UI Tests, Snapshot Tests, Integration Tests)
* CI/CD
