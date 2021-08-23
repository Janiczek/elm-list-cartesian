# `Janiczek/elm-list-cartesian`

**Specialized List `mapN` and `andMap` functions that give all combinations of list elements (Cartesian product) instead of zipping them**

The [`List.mapN`](https://package.elm-lang.org/packages/elm/core/1.0.5/List#map2) functions and the [`List.Extra.andMap`](https://package.elm-lang.org/packages/elm-community/list-extra/8.4.0/List-Extra#andMap) function are of the zipping variety: they combine the first elements of all lists, then the second elements, then the third ones and so on, and stop as soon as any list runs out of items.

```elm
List.map2 (+) [ 1, 2 ] [ 100, 200, 300 ]
--> [ 101, 202 ]
```

Functions in the [`List.Cartesian`](/List-Cartesian) module instead give you the Cartesian product -- all combinations of the list elements you provide:

```elm
List.Cartesian.map2 (+) [ 1, 2 ] [ 100, 200, 300 ]
--> [ 101, 201, 301, 102, 202, 302 ]
```

The functions in the [`List.Zip`](/List-Zip) are just aliases of the `elm/core` functions and only serve a didactic purpose. But they might be useful to make your code more explicit if you need to use both variants in the same file!

```elm
import List.Cartesian
import List.Zip


myFn list1 list2 =
    let
        allCombinations : List (Int, Int)
        allCombinations =
            List.Cartesian.map2 Tuple.pair list1 list2

        pairings : List (Int, Int)
        pairings =
            List.Zip.map2 Tuple.pair list1 list2
    in
    -- ...
```
