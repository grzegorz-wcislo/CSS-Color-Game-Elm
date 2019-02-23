module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
    { guessInput : String
    }


init : Model
init =
    { guessInput = "" }



-- UPDATE


type Msg
    = ChangeGuess String
    | CheckGuess


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangeGuess newGuess ->
            { model | guessInput = newGuess }

        CheckGuess ->
            { model | guessInput = "" }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ input
            [ placeholder "Your Guess"
            , value model.guessInput
            , onInput ChangeGuess
            ]
            []
        , div [] [ text model.guessInput ]
        , button [ onClick CheckGuess ] [ text "Check Guess" ]
        ]
