module Tests exposing (cartesian)

import Expect
import List.Cartesian
import Test exposing (Test)


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
        ]
