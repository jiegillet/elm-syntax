module Elm.Parser.CombineTestUtil exposing (parseFullString, parseWithState, pushIndent)

import Combine exposing (..)
import Elm.Parser.State exposing (State, emptyState)


pushIndent : Int -> Parser State b -> Parser State b
pushIndent x p =
    modifyState (Elm.Parser.State.pushColumn (x + 1)) |> Combine.continueWith p


parseWithState : String -> Parser State a -> Maybe ( State, a )
parseWithState s p =
    Combine.runParser (p |> Combine.ignore Combine.end) emptyState s
        |> Result.toMaybe


parseFullString : String -> Parser State a -> Maybe a
parseFullString s p =
    parseWithState s p
        |> Maybe.map Tuple.second
