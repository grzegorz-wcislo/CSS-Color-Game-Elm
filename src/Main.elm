module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- COLORS


type alias Color =
    { name : String
    , hex : String
    }



-- MODEL


type alias Model =
    { guessInput : String }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { guessInput = "" }, Cmd.none )



-- UPDATE


type Msg
    = ChangeGuess String
    | CheckGuess


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeGuess newGuess ->
            ( { model | guessInput = newGuess }, Cmd.none )

        CheckGuess ->
            ( { model | guessInput = "" }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



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
