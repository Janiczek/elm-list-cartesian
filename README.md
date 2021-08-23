# `Janiczek/elm-list-cartesian`

**Specialized List `mapN` and `andMap` functions that give all combinations of list elements (Cartesian product) instead of zipping them**

The `elm/core` versions of `mapN` and `andMap` functions are of the zipping variety, in that they combine the first elements of all lists, then the second elements, then the third ones and so on, and stop as soon as any list runs out of items.

```elm
List.map2 (+) [ 1, 2 ] [ 100, 200, 300 ]
--> [ 101, 202 ]
```

Functions in the `List.Cartesian` module instead give you the Cartesian product, all combinations of the list elements you provide:

```elm
List.Cartesian.map2 (+) [ 1, 2 ] [ 100, 200, 300 ]
--> [ 101, 201, 301, 102, 202, 302 ]
```
