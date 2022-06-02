
# Complex Numbers

## Overview
- This project uses Apple's swift-numerics generic types in conjunction with a SwiftUI interface to display functions and values.

## Technical description
- The coordinate system is implemented as SwiftUI's _Path_ and _Shape_ classes. An alternative, probably more native to SwiftUI, would be to use stacks, preferences, geometry readers and the layout system.
- I use _callableAsFunction_ to improve the readability of polynomial expressions.
- The project uses dependency injection using Resolver package.