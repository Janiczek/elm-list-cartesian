module List.Zip exposing (andMap, map2, map3, map4, map5)

{-| Zipping version of List `andMap` and `mapN` functions.

This module exists mainly to illustrate the difference between the
[`List.Cartesian`](https://package.elm-lang.org/packages/Janiczek/elm-list-cartesian/1.0.1/List-Cartesian)
functions and the "common" ones from [`elm/core`](https://package.elm-lang.org/packages/elm/core/1.0.5/)
and [`elm-community/list-extra`](https://package.elm-lang.org/packages/elm-community/list-extra/8.4.0/).

The `mapN` functions in this module are aliases of the functions found in
[`List`](https://package.elm-lang.org/packages/elm/core/1.0.5/List):
[`List.Zip.map2`](#map2) = [`List.map2`](https://package.elm-lang.org/packages/elm/core/1.0.5/List#map2)
and so on.

@docs andMap, map2, map3, map4, map5

-}


{-| Same as [`List.Extra.andMap`](https://package.elm-lang.org/packages/elm-community/list-extra/8.4.0/List-Extra#andMap).

A building block for arbitrary `mapN` functions, but beware: there is a gotcha.
See [`map5`](#map5) for more info.

Note that the zipping behaviour will drop items if your lists aren't of the same
length.

-}
andMap : List a -> List (a -> b) -> List b
andMap =
    map2 (|>)


{-| Same as [`List.map2`](https://package.elm-lang.org/packages/elm-community/list-extra/8.4.0/List-Extra#map2).

Note that the zipping behaviour will drop items if your lists aren't of the same
length.

    List.Zip.map2 (*) [ 10, 100 ] [ 1, 2, 3 ]
    --> [ 10, 200 ]

-}
map2 : (a -> b -> c) -> List a -> List b -> List c
map2 =
    List.map2


{-| Same as [`List.map3`](https://package.elm-lang.org/packages/elm-community/list-extra/8.4.0/List-Extra#map3).

Note that the zipping behaviour will drop items if your lists aren't of the same
length.

-}
map3 : (a -> b -> c -> d) -> List a -> List b -> List c -> List d
map3 =
    List.map3


{-| Same as [`List.map4`](https://package.elm-lang.org/packages/elm-community/list-extra/8.4.0/List-Extra#map4).

Note that the zipping behaviour will drop items if your lists aren't of the same
length.

-}
map4 : (a -> b -> c -> d -> e) -> List a -> List b -> List c -> List d -> List e
map4 =
    List.map4


{-| Same as [`List.map5`](https://package.elm-lang.org/packages/elm-community/list-extra/8.4.0/List-Extra#map5).

Note that the zipping behaviour will drop items if your lists aren't of the same
length.

In case you're looking for `map6` etc., you can use this [`andMap`](#andMap) pattern to map
as many lists you want:

    List.repeat listLength fn
        |> List.Zip.andMap list1
        |> List.Zip.andMap list2
        |> List.Zip.andMap list3
        |> List.Zip.andMap list4
        |> List.Zip.andMap list5
        |> List.Zip.andMap list6
        |> ...

The gotcha is in that you need to provide the function repeated: `[fn] |> ...`
would not work correctly, as it would return a list with at most 1 item inside.

-}
map5 : (a -> b -> c -> d -> e -> f) -> List a -> List b -> List c -> List d -> List e -> List f
map5 =
    List.map5
