
# Complex Numbers

## Overview
- This project uses Apple's swift-numerics generic types in conjunction with a SwiftUI interface to display functions and values in a 2D coordinate system.
- The coordinate system is implemented as SwiftUI's _Path_ and _Shape_ classes. An alternative, probably more native to SwiftUI, would be to use stacks, preferences, geometry readers and the layout system.
- I use _callableAsFunction_ to improve the readability of polynomial expressions.
- The project uses dependency injection using Resolver package.

## Technical description
- The data updates are based on _Combine_
- The are two main view components: _CoordinateSystem_ and _MenuView_.
- _CoordinateSystem_ has a presenter _CoordinateSystemPresenter_. 
- _MenuView_ has a presenter: _MenuPresenter_.
- Both presenters share a data source _CurrentPolynomialDataSource_ and are subscribed to changes in the polynomial function stored by the data source. 
- The data source publishes changes to the polynomial.
- The views observe changes in the function held by their presenters.

## Functions
- There's a protocol _Function_ with an associated type of type _Real_. A _function_ has one requirement, to be callable as a function: _callAsFunction_.
- _Polynomial_ is a concrete implementation of _Function_ with an array of terms (_Term_). Each term has an index and a coefficient.
- _Log_ is another concrete implementation of _Function_.
- _FunctionView_ is generic on a _Function_ conformant type. 


## Images

<img src="https://user-images.githubusercontent.com/199423/171673217-c0e13898-816d-41a5-a015-e2835a6ea7f0.gif" alt="Creating a polynomial function" width="50%">


