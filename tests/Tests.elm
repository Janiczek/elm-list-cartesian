module Tests exposing (cartesian, zip)

import Expect
import Fuzz exposing (Fuzzer)
import List.Cartesian
import List.Zip
import Test exposing (Test)


list : Fuzzer (List Int)
list =
    Fuzz.list Fuzz.int


listAtLeast2Elements : Fuzzer (List Int)
listAtLeast2Elements =
    Fuzz.map3 (\a b xs -> a :: b :: xs)
        Fuzz.int
        Fuzz.int
        (Fuzz.list Fuzz.int)


cartesian : Test
cartesian =
    Test.describe "List.Cartesian"
        [ Test.describe "andMap"
            [ Test.test "Simple example" <|
                \() ->
                    [ Tuple.pair ]
                        |> List.Cartesian.andMap [ 1, 2 ]
                        |> List.Cartesian.andMap [ 3, 4 ]
                        |> Expect.equalLists [ ( 1, 3 ), ( 1, 4 ), ( 2, 3 ), ( 2, 4 ) ]
            , Test.test "Multiple functions - explained" <|
                \() ->
                    [ \a b -> "f1 " ++ String.fromInt a ++ " " ++ String.fromInt b
                    , \a b -> "f2 " ++ String.fromInt a ++ " " ++ String.fromInt b
                    ]
                        |> List.Cartesian.andMap [ 1, 2 ]
                        |> List.Cartesian.andMap [ 100, 200 ]
                        |> Expect.equalLists
                            [ "f1 1 100"
                            , "f1 1 200"
                            , "f1 2 100"
                            , "f1 2 200"
                            , "f2 1 100"
                            , "f2 1 200"
                            , "f2 2 100"
                            , "f2 2 200"
                            ]
            , Test.test "Different multiple functions" <|
                \() ->
                    [ (+), (*) ]
                        |> List.Cartesian.andMap [ 1, 2 ]
                        |> List.Cartesian.andMap [ 100, 200 ]
                        |> Expect.equalLists [ 101, 201, 102, 202, 100, 200, 200, 400 ]
            ]
        , Test.describe "map2"
            [ Test.test "Tries all combinations (doesn't zip)" <|
                \() ->
                    List.Cartesian.map2 Tuple.pair
                        [ 1, 2 ]
                        [ 3, 4 ]
                        |> Expect.equalLists [ ( 1, 3 ), ( 1, 4 ), ( 2, 3 ), ( 2, 4 ) ]
            , Test.fuzz2 list list "len(result) = len(list1) * len(list2)" <|
                \list1 list2 ->
                    List.Cartesian.map2 Tuple.pair list1 list2
                        |> List.length
                        |> Expect.equal (List.length list1 * List.length list2)
            ]
        , Test.describe "map3"
            [ Test.test "Tries all combinations (doesn't zip)" <|
                \() ->
                    List.Cartesian.map3 (\a b c -> ( a, b, c ))
                        [ 1, 2 ]
                        [ 3, 4 ]
                        [ 'a', 'b' ]
                        |> Expect.equalLists
                            [ ( 1, 3, 'a' )
                            , ( 1, 3, 'b' )
                            , ( 1, 4, 'a' )
                            , ( 1, 4, 'b' )
                            , ( 2, 3, 'a' )
                            , ( 2, 3, 'b' )
                            , ( 2, 4, 'a' )
                            , ( 2, 4, 'b' )
                            ]
            ]
        , Test.describe "map4"
            [ Test.test "Tries all combinations (doesn't zip)" <|
                \() ->
                    List.Cartesian.map4 (\a b c d -> [ a, b, c, d ])
                        [ 1, 2 ]
                        [ 3, 4 ]
                        [ 5, 6 ]
                        [ 7, 8 ]
                        |> Expect.equalLists
                            [ [ 1, 3, 5, 7 ]
                            , [ 1, 3, 5, 8 ]
                            , [ 1, 3, 6, 7 ]
                            , [ 1, 3, 6, 8 ]
                            , [ 1, 4, 5, 7 ]
                            , [ 1, 4, 5, 8 ]
                            , [ 1, 4, 6, 7 ]
                            , [ 1, 4, 6, 8 ]
                            , [ 2, 3, 5, 7 ]
                            , [ 2, 3, 5, 8 ]
                            , [ 2, 3, 6, 7 ]
                            , [ 2, 3, 6, 8 ]
                            , [ 2, 4, 5, 7 ]
                            , [ 2, 4, 5, 8 ]
                            , [ 2, 4, 6, 7 ]
                            , [ 2, 4, 6, 8 ]
                            ]
            ]
        , Test.describe "map5"
            [ Test.test "Tries all combinations (doesn't zip)" <|
                \() ->
                    List.Cartesian.map5 (\a b c d e -> [ a, b, c, d, e ])
                        [ 1, 2 ]
                        [ 3, 4 ]
                        [ 5, 6 ]
                        [ 7, 8 ]
                        [ 9, 10 ]
                        |> Expect.equalLists
                            [ [ 1, 3, 5, 7, 9 ]
                            , [ 1, 3, 5, 7, 10 ]
                            , [ 1, 3, 5, 8, 9 ]
                            , [ 1, 3, 5, 8, 10 ]
                            , [ 1, 3, 6, 7, 9 ]
                            , [ 1, 3, 6, 7, 10 ]
                            , [ 1, 3, 6, 8, 9 ]
                            , [ 1, 3, 6, 8, 10 ]
                            , [ 1, 4, 5, 7, 9 ]
                            , [ 1, 4, 5, 7, 10 ]
                            , [ 1, 4, 5, 8, 9 ]
                            , [ 1, 4, 5, 8, 10 ]
                            , [ 1, 4, 6, 7, 9 ]
                            , [ 1, 4, 6, 7, 10 ]
                            , [ 1, 4, 6, 8, 9 ]
                            , [ 1, 4, 6, 8, 10 ]
                            , [ 2, 3, 5, 7, 9 ]
                            , [ 2, 3, 5, 7, 10 ]
                            , [ 2, 3, 5, 8, 9 ]
                            , [ 2, 3, 5, 8, 10 ]
                            , [ 2, 3, 6, 7, 9 ]
                            , [ 2, 3, 6, 7, 10 ]
                            , [ 2, 3, 6, 8, 9 ]
                            , [ 2, 3, 6, 8, 10 ]
                            , [ 2, 4, 5, 7, 9 ]
                            , [ 2, 4, 5, 7, 10 ]
                            , [ 2, 4, 5, 8, 9 ]
                            , [ 2, 4, 5, 8, 10 ]
                            , [ 2, 4, 6, 7, 9 ]
                            , [ 2, 4, 6, 7, 10 ]
                            , [ 2, 4, 6, 8, 9 ]
                            , [ 2, 4, 6, 8, 10 ]
                            ]
            ]
        , Test.describe "Equivalences"
            [ Test.fuzz2 list list "map2 = pure >> andMap >> andMap" <|
                \list1 list2 ->
                    List.Cartesian.map2 (+) list1 list2
                        |> Expect.equalLists
                            ([ (+) ]
                                |> List.Cartesian.andMap list1
                                |> List.Cartesian.andMap list2
                            )
            ]
        , Test.describe "Lawfulness"
            [ Test.fuzz list "Identity" <|
                \list_ ->
                    ([ identity ] |> List.Cartesian.andMap list_)
                        |> Expect.equalLists list_
            , Test.test "Homomorphism" <|
                \() ->
                    ([ (+) 1 ] |> List.Cartesian.andMap [ 2 ])
                        |> Expect.equalLists [ (+) 1 2 ]
            , Test.test "Interchange" <|
                \() ->
                    ([ (+) 1 ] |> List.Cartesian.andMap [ 2 ])
                        |> Expect.equal
                            ([ (|>) 2 ] |> List.Cartesian.andMap [ (+) 1 ])
            , Test.test "Composition" <|
                \() ->
                    ([ (<<) ]
                        |> List.Cartesian.andMap [ (*) 2 ]
                        |> List.Cartesian.andMap [ (*) 3 ]
                        |> List.Cartesian.andMap [ 1 ]
                    )
                        |> Expect.equal
                            ([ (*) 2 ]
                                |> List.Cartesian.andMap
                                    ([ (*) 3 ]
                                        |> List.Cartesian.andMap [ 1 ]
                                    )
                            )
            ]
        ]


zip : Test
zip =
    Test.describe "List.Zip"
        [ Test.describe "andMap"
            [ Test.fuzz list "implements map6" <|
                \list_ ->
                    let
                        length =
                            List.length list_

                        fn a b c d e f =
                            a + b + c + d + e + f

                        timesSix =
                            List.map ((*) 6) list_
                    in
                    List.repeat length fn
                        |> List.Zip.andMap list_
                        |> List.Zip.andMap list_
                        |> List.Zip.andMap list_
                        |> List.Zip.andMap list_
                        |> List.Zip.andMap list_
                        |> List.Zip.andMap list_
                        |> Expect.equalLists timesSix
            ]
        , Test.describe "map3"
            [ Test.test "Zips (doesn't try all combinations)" <|
                \() ->
                    List.Zip.map3 (\a b c -> ( a, b, c ))
                        [ 1, 2 ]
                        [ 3, 4 ]
                        [ 'a', 'b' ]
                        |> Expect.equalLists
                            [ ( 1, 3, 'a' )
                            , ( 2, 4, 'b' )
                            ]
            ]
        , Test.describe "map4"
            [ Test.test "Zips (doesn't try all combinations)" <|
                \() ->
                    List.Zip.map4 (\a b c d -> [ a, b, c, d ])
                        [ 1, 2 ]
                        [ 3, 4 ]
                        [ 5, 6 ]
                        [ 7, 8 ]
                        |> Expect.equalLists
                            [ [ 1, 3, 5, 7 ]
                            , [ 2, 4, 6, 8 ]
                            ]
            ]
        , Test.describe "map5"
            [ Test.test "Zips (doesn't try all combinations)" <|
                \() ->
                    List.Zip.map5 (\a b c d e -> [ a, b, c, d, e ])
                        [ 1, 2 ]
                        [ 3, 4 ]
                        [ 5, 6 ]
                        [ 7, 8 ]
                        [ 9, 10 ]
                        |> Expect.equalLists
                            [ [ 1, 3, 5, 7, 9 ]
                            , [ 2, 4, 6, 8, 10 ]
                            ]
            ]
        , Test.describe "Lawfulness"
            [ Test.fuzz listAtLeast2Elements "Identity does NOT hold" <|
                \list_ ->
                    ([ identity ] |> List.Zip.andMap list_)
                        |> Expect.notEqual list_
            , Test.test "Homomorphism" <|
                \() ->
                    ([ (+) 1 ] |> List.Zip.andMap [ 2 ])
                        |> Expect.equalLists [ (+) 1 2 ]
            , Test.test "Interchange" <|
                \() ->
                    ([ (+) 1 ] |> List.Zip.andMap [ 2 ])
                        |> Expect.equal
                            ([ (|>) 2 ] |> List.Zip.andMap [ (+) 1 ])
            , Test.test "Composition" <|
                \() ->
                    ([ (<<) ]
                        |> List.Zip.andMap [ (*) 2 ]
                        |> List.Zip.andMap [ (*) 3 ]
                        |> List.Zip.andMap [ 1 ]
                    )
                        |> Expect.equal
                            ([ (*) 2 ]
                                |> List.Zip.andMap
                                    ([ (*) 3 ]
                                        |> List.Zip.andMap [ 1 ]
                                    )
                            )
            ]
        ]
