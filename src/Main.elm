module Main exposing (Model, Msg(..), init, main, update, view)

import Browser exposing (Document)
import Browser.Dom
import Html exposing (Html, br, div, form, h1, h2, input, p, span, text)
import Html.Attributes exposing (autocomplete, autofocus, id, name, style, type_, value)
import Html.Events exposing (..)
import Json.Decode as Json
import Random
import Task


main =
    Browser.document
        { init = init
        , update = update
        , subscriptions = always Sub.none
        , view = view
        }



-- COLORS


type alias Color =
    { hex : String
    , names : List String
    }


defaultColor : Color
defaultColor =
    Color "#ffffff" [ "white" ]


colorList : List Color
colorList =
    [ Color "#000000" [ "black" ]
    , Color "#000080" [ "navy" ]
    , Color "#00008b" [ "darkblue" ]
    , Color "#0000cd" [ "mediumblue" ]
    , Color "#0000ff" [ "blue" ]
    , Color "#006400" [ "darkgreen" ]
    , Color "#008000" [ "green" ]
    , Color "#008080" [ "teal" ]
    , Color "#008b8b" [ "darkcyan" ]
    , Color "#00bfff" [ "deepskyblue" ]
    , Color "#00ced1" [ "darkturquoise" ]
    , Color "#00fa9a" [ "mediumspringgreen" ]
    , Color "#00ff00" [ "lime" ]
    , Color "#00ff7f" [ "springgreen" ]
    , Color "#00ffff" [ "aqua", "cyan" ]
    , Color "#191970" [ "midnightblue" ]
    , Color "#1e90ff" [ "dodgerblue" ]
    , Color "#20b2aa" [ "lightseagreen" ]
    , Color "#228b22" [ "forestgreen" ]
    , Color "#2e8b57" [ "seagreen" ]
    , Color "#2f4f4f" [ "darkslategray", "darkslategrey" ]
    , Color "#32cd32" [ "limegreen" ]
    , Color "#3cb371" [ "mediumseagreen" ]
    , Color "#40e0d0" [ "turquoise" ]
    , Color "#4169e1" [ "royalblue" ]
    , Color "#4682b4" [ "steelblue" ]
    , Color "#483d8b" [ "darkslateblue" ]
    , Color "#48d1cc" [ "mediumturquoise" ]
    , Color "#4b0082" [ "indigo" ]
    , Color "#556b2f" [ "darkolivegreen" ]
    , Color "#5f9ea0" [ "cadetblue" ]
    , Color "#6495ed" [ "cornflowerblue" ]
    , Color "#66cdaa" [ "mediumaquamarine" ]
    , Color "#696969" [ "dimgray", "dimgrey" ]
    , Color "#6a5acd" [ "slateblue" ]
    , Color "#6b8e23" [ "olivedrab" ]
    , Color "#708090" [ "slategray", "slategrey" ]
    , Color "#778899" [ "lightslategray", "lightslategrey" ]
    , Color "#7b68ee" [ "mediumslateblue" ]
    , Color "#7cfc00" [ "lawngreen" ]
    , Color "#7fff00" [ "chartreuse" ]
    , Color "#7fffd4" [ "aquamarine" ]
    , Color "#800000" [ "maroon" ]
    , Color "#800080" [ "purple" ]
    , Color "#808000" [ "olive" ]
    , Color "#808080" [ "gray", "grey" ]
    , Color "#87ceeb" [ "skyblue" ]
    , Color "#87cefa" [ "lightskyblue" ]
    , Color "#8a2be2" [ "blueviolet" ]
    , Color "#8b0000" [ "darkred" ]
    , Color "#8b008b" [ "darkmagenta" ]
    , Color "#8b4513" [ "saddlebrown" ]
    , Color "#8fbc8f" [ "darkseagreen" ]
    , Color "#90ee90" [ "lightgreen" ]
    , Color "#9370d8" [ "mediumpurple" ]
    , Color "#9400d3" [ "darkviolet" ]
    , Color "#98fb98" [ "palegreen" ]
    , Color "#9932cc" [ "darkorchid" ]
    , Color "#9acd32" [ "yellowgreen" ]
    , Color "#a0522d" [ "sienna" ]
    , Color "#a52a2a" [ "brown" ]
    , Color "#a9a9a9" [ "darkgray", "darkgrey" ]
    , Color "#add8e6" [ "lightblue" ]
    , Color "#adff2f" [ "greenyellow" ]
    , Color "#afeeee" [ "paleturquoise" ]
    , Color "#b0c4de" [ "lightsteelblue" ]
    , Color "#b0e0e6" [ "powderblue" ]
    , Color "#b22222" [ "firebrick" ]
    , Color "#b8860b" [ "darkgoldenrod" ]
    , Color "#ba55d3" [ "mediumorchid" ]
    , Color "#bc8f8f" [ "rosybrown" ]
    , Color "#bdb76b" [ "darkkhaki" ]
    , Color "#c0c0c0" [ "silver" ]
    , Color "#c71585" [ "mediumvioletred" ]
    , Color "#cd5c5c" [ "indianred" ]
    , Color "#cd853f" [ "peru" ]
    , Color "#d2691e" [ "chocolate" ]
    , Color "#d2b48c" [ "tan" ]
    , Color "#d3d3d3" [ "lightgray", "lightgrey" ]
    , Color "#d87093" [ "palevioletred" ]
    , Color "#d8bfd8" [ "thistle" ]
    , Color "#da70d6" [ "orchid" ]
    , Color "#daa520" [ "goldenrod" ]
    , Color "#dc143c" [ "crimson" ]
    , Color "#dcdcdc" [ "gainsboro" ]
    , Color "#dda0dd" [ "plum" ]
    , Color "#deb887" [ "burlywood" ]
    , Color "#e0ffff" [ "lightcyan" ]
    , Color "#e6e6fa" [ "lavender" ]
    , Color "#e9967a" [ "darksalmon" ]
    , Color "#ee82ee" [ "violet" ]
    , Color "#eee8aa" [ "palegoldenrod" ]
    , Color "#f08080" [ "lightcoral" ]
    , Color "#f0e68c" [ "khaki" ]
    , Color "#f0f8ff" [ "aliceblue" ]
    , Color "#f0fff0" [ "honeydew" ]
    , Color "#f0ffff" [ "azure" ]
    , Color "#f4a460" [ "sandybrown" ]
    , Color "#f5deb3" [ "wheat" ]
    , Color "#f5f5dc" [ "beige" ]
    , Color "#f5f5f5" [ "whitesmoke" ]
    , Color "#f5fffa" [ "mintcream" ]
    , Color "#f8f8ff" [ "ghostwhite" ]
    , Color "#fa8072" [ "salmon" ]
    , Color "#faebd7" [ "antiquewhite" ]
    , Color "#faf0e6" [ "linen" ]
    , Color "#fafad2" [ "lightgoldenrodyellow" ]
    , Color "#fdf5e6" [ "oldlace" ]
    , Color "#ff0000" [ "red" ]
    , Color "#ff00ff" [ "fuchsia", " magenta" ]
    , Color "#ff1493" [ "deeppink" ]
    , Color "#ff4500" [ "orangered" ]
    , Color "#ff6347" [ "tomato" ]
    , Color "#ff69b4" [ "hotpink" ]
    , Color "#ff7f50" [ "coral" ]
    , Color "#ff8c00" [ "darkorange" ]
    , Color "#ffa07a" [ "lightsalmon" ]
    , Color "#ffa500" [ "orange" ]
    , Color "#ffb6c1" [ "lightpink" ]
    , Color "#ffc0cb" [ "pink" ]
    , Color "#ffd700" [ "gold" ]
    , Color "#ffdab9" [ "peachpuff" ]
    , Color "#ffdead" [ "navajowhite" ]
    , Color "#ffe4b5" [ "moccasin" ]
    , Color "#ffe4c4" [ "bisque" ]
    , Color "#ffe4e1" [ "mistyrose" ]
    , Color "#ffebcd" [ "blanchedalmond" ]
    , Color "#ffefd5" [ "papayawhip" ]
    , Color "#fff0f5" [ "lavenderblush" ]
    , Color "#fff5ee" [ "seashell" ]
    , Color "#fff8dc" [ "cornsilk" ]
    , Color "#fffacd" [ "lemonchiffon" ]
    , Color "#fffaf0" [ "floralwhite" ]
    , Color "#fffafa" [ "snow" ]
    , Color "#ffff00" [ "yellow" ]
    , Color "#ffffe0" [ "lightyellow" ]
    , Color "#fffff0" [ "ivory" ]
    , Color "#ffffff" [ "white" ]
    ]


randomColor : Random.Generator Color
randomColor =
    case colorList of
        head :: tail ->
            Random.uniform head tail

        _ ->
            Random.constant defaultColor



-- GUESSES


type alias Guess =
    { expected : Color
    , actual : String
    }


type Correctness
    = Correct
    | Incorrect
    | PartiallyCorrect


correctness : Guess -> Correctness
correctness { expected, actual } =
    let
        guess =
            String.toLower (String.replace " " "" actual)

        possibleColorNames =
            expected.names |> List.map String.toLower
    in
    if List.any (\c -> c == guess) possibleColorNames then
        Correct

    else if
        (String.length guess >= 4)
            && List.any
                (String.contains guess)
                possibleColorNames
    then
        PartiallyCorrect

    else
        Incorrect



-- MODEL


type alias Model =
    { color : Color
    , guessInput : String
    , score : Int
    , previousGuess : Maybe Guess
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { color = defaultColor
      , guessInput = ""
      , score = 0
      , previousGuess = Nothing
      }
    , Random.generate ChangeColor randomColor
    )



-- UPDATE


type Msg
    = NoOp
    | ChangeGuess String
    | ChangeColor Color
    | CheckGuess
    | FocusInput


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        ChangeGuess newGuess ->
            ( { model
                | guessInput = newGuess
              }
            , Cmd.none
            )

        ChangeColor newColor ->
            ( { model
                | color = newColor
              }
            , Cmd.none
            )

        CheckGuess ->
            let
                guess =
                    { expected = model.color
                    , actual = model.guessInput
                    }

                newScore =
                    case correctness guess of
                        Correct ->
                            model.score + 1

                        Incorrect ->
                            0

                        PartiallyCorrect ->
                            model.score
            in
            ( { model
                | guessInput = ""
                , score = newScore
                , previousGuess = Just guess
              }
            , Random.generate ChangeColor randomColor
            )

        FocusInput ->
            ( model, Task.attempt (always NoOp) (Browser.Dom.focus "user-guess") )



-- VIEW


view : Model -> Document Msg
view model =
    let
        color =
            model.color.hex

        setBackgroundColor =
            style "background-color" color
    in
    { title = "CSS Color Game"
    , body =
        [ div [ id "game-canvas", setBackgroundColor ]
            [ div [ id "score-box" ]
                [ h1 [ id "score" ] [ text (String.fromInt model.score) ]
                , tooltipView model.previousGuess
                ]
            , div [ id "game" ]
                [ h1 [ id "color-hex" ] [ text model.color.hex ]
                , form [ onSubmit CheckGuess ]
                    [ input
                        [ type_ "text"
                        , name "Your Guess"
                        , id "user-guess"
                        , onInput ChangeGuess
                        , onBlur FocusInput
                        , autocomplete False
                        , autofocus True
                        , value model.guessInput
                        ]
                        []
                    ]
                , p [ id "confirm-btn", onClick CheckGuess, setBackgroundColor ] [ text "OK" ]
                ]
            ]
        ]
    }


tooltipView : Maybe Guess -> Html Msg
tooltipView maybeGuess =
    h2 [ id "tooltip" ]
        (case maybeGuess of
            Nothing ->
                [ text "Name the"
                , br [] []
                , text "background color"
                ]

            Just guess ->
                let
                    hint =
                        [ br [] []
                        , span
                            [ id "previous-color"
                            , style
                                "color"
                                guess.expected.hex
                            ]
                            [ guess.expected.names
                                |> String.join " or "
                                |> text
                            ]
                        ]
                in
                case correctness guess of
                    Correct ->
                        [ text "Good job!" ]

                    Incorrect ->
                        [ text "Not even close. It was:" ] ++ hint

                    PartiallyCorrect ->
                        [ text "Close enough. It was:" ] ++ hint
        )
