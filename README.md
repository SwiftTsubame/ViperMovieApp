# ViperMovieApp

This is a demo Movie Browsing app written with VIPER Architecture.

## About VIPER

### Viper Components

Each VIPER module consists of the following parts:

- View (View, ViewController) 
- Interactor (Business Logic, Use Cases) 
- Presenter (Prepare Business logic for presentation in the View)
- Entity (Model) 
- Router (Assemble each module and Take control of Routing)

### Dependency Graph

The dependence graph is unidirectional, which means:
**View** knows about **Presenter**
**Presenter** knows about **Router** and **Interactor** 
**Interactor** communicates with Database/Repository. 
It is like an onion. The outer layers are dependent on the closest inner layer. And the inner layers have no knowledge of the outer layers. 

### Dependency Inversion (Feedback Loop)

However, when we want to inform the outer layer changes of the inner layer, a feedback channel needs to be created to bring info from inside of the onion out.
This can be achieved in several ways. Using Rx Binding, closure (blocks) or like what we do here, using **delegates (protocols)**.

We use **ViewInterface** to communicate back from Presenter to View and **InteractionOutput** to communicate back from Interactor to Presenter.
												
## About the Demo App
It is a simple app which fetches movies and display them in collectionview. When the user taps on a movie, it shows movie detail and a "Favorite" button. User can mark their favorites in the detail page and consequently the changes will be shown in the collectionview.

There are in total 2 VIPER modules: movieList and movieDetail at this moment.

The UI appearance of this app is currently under construction 😂

## Unit Testing
One advantage of VIPER is that it makes unit testing so much easier!
We have been able to fully test Interactor, Presenter, Entity and Router. 

## Module Generation
VIPER comes with a lot of boilplate codes. We have created a script to generate the most basic viper modules https://github.com/SwiftTsubame/TsubameVIPER.git. This script will also be further improved according to the evolution of our understanding of VIPER.

## TODO:
1. Implement more real-life like UI
2. Allow other user interactions such as "sorting", "filtering"

# Contact:
I am still in the process of digesting clean architecture and how it can be applied in iOS. If you have any suggestion or questions, please submit a PR or drop me a message at @haiyan_nest on Twitter :)

