module List.Cartesian exposing (andMap, map2, map3, map4, map5)

{-| Cartesian product version of List `andMap` and `mapN` functions.

This module's functions behave differently from the "common" ones in `elm/core`
and `elm-community/list-extra` in that instead of zipping they will run through
all combinations of the lists you provide:

    List.Cartesian.map2 (+) [ 1, 2 ] [ 100, 200, 300 ]
    --> [ 101, 201, 301, 102, 202, 302 ]

Compare that with the default zipping behaviour:

    List.map2 (+) [ 1, 2 ] [ 100, 200, 300 ]
    --> [ 101, 202 ]

@docs andMap, map2, map3, map4, map5

-}


{-| A building block for arbitrary `mapN` functions. See [`map5`](#map5) for more info.

Note that `andMap` allows you to do stuff you might not realize is possible with
`map2` etc.:

    [ (+), (*) ]
        |> List.Cartesian.andMap [ 1, 2 ]
        |> List.Cartesian.andMap [ 90, 93, 96 ]
    --> [ 91, 94, 97, 92, 95, 98, 90, 93, 96, 180, 186, 192 ]

-}
andMap : List a -> List (a -> b) -> List b
andMap as_ fns =
    List.concatMap
        (\fn -> List.map fn as_)
        fns


{-| Equivalent to

    [ fn ]
        |> List.Cartesian.andMap xs
        |> List.Cartesian.andMap ys

Also equivalent to `List.Extra.lift2`.

    List.Cartesian.map2 (*) [ 10, 100 ] [ 1, 2, 3 ]
    --> [ 10, 20, 30, 100, 200, 300 ]

-}
map2 : (a -> b -> c) -> List a -> List b -> List c
map2 fn as_ bs =
    List.concatMap
        (\a -> List.map (fn a) bs)
        as_


{-| Equivalent to

    [ fn ]
        |> List.Cartesian.andMap xs
        |> List.Cartesian.andMap ys
        |> List.Cartesian.andMap zs

Also equivalent to `List.Extra.lift3`.

-}
map3 : (a -> b -> c -> d) -> List a -> List b -> List c -> List d
map3 fn as_ bs cs =
    List.concatMap
        (\a ->
            List.concatMap
                (\b -> List.map (fn a b) cs)
                bs
        )
        as_


{-| Equivalent to

    [ fn ]
        |> List.Cartesian.andMap xs
        |> List.Cartesian.andMap ys
        |> List.Cartesian.andMap zs
        |> List.Cartesian.andMap ws

Also equivalent to `List.Extra.lift4`.

-}
map4 : (a -> b -> c -> d -> e) -> List a -> List b -> List c -> List d -> List e
map4 fn as_ bs cs ds =
    List.concatMap
        (\a ->
            List.concatMap
                (\b ->
                    List.concatMap
                        (\c ->
                            List.map (fn a b c) ds
                        )
                        cs
                )
                bs
        )
        as_


{-| Equivalent to

    [ fn ]
        |> List.Cartesian.andMap xs
        |> List.Cartesian.andMap ys
        |> List.Cartesian.andMap zs
        |> List.Cartesian.andMap ws
        |> List.Cartesian.andMap vs

In case you're looking for `map6` etc., you can use the above `andMap` pattern to
map as many lists you want.

-}
map5 : (a -> b -> c -> d -> e -> f) -> List a -> List b -> List c -> List d -> List e -> List f
map5 fn as_ bs cs ds es =
    List.concatMap
        (\a ->
            List.concatMap
                (\b ->
                    List.concatMap
                        (\c ->
                            List.concatMap
                                (\d ->
                                    List.map (fn a b c d) es
                                )
                                ds
                        )
                        cs
                )
                bs
        )
        as_
