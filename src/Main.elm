module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Random


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


randomColor : Random.Generator Color
randomColor =
    Random.uniform
        (Color "aliceblue" "#f0f8ff")
        [ Color "antiquewhite" "#faebd7"
        , Color "aqua" "#00ffff"
        , Color "aquamarine" "#7fffd4"
        , Color "azure" "#f0ffff"
        , Color "beige" "#f5f5dc"
        , Color "bisque" "#ffe4c4"
        , Color "blanchedalmond" "#ffebcd"
        , Color "blue" "#0000ff"
        , Color "blueviolet" "#8a2be2"
        , Color "brown" "#a52a2a"
        , Color "burlywood" "#deb887"
        , Color "cadetblue" "#5f9ea0"
        , Color "chartreuse" "#7fff00"
        , Color "chocolate" "#d2691e"
        , Color "coral" "#ff7f50"
        , Color "cornflowerblue" "#6495ed"
        , Color "cornsilk" "#fff8dc"
        , Color "crimson" "#dc143c"
        , Color "cyan" "#00ffff"
        , Color "darkblue" "#00008b"
        , Color "darkcyan" "#008b8b"
        , Color "darkgoldenrod" "#b8860b"
        , Color "darkgreen" "#006400"
        , Color "darkkhaki" "#bdb76b"
        , Color "darkmagenta" "#8b008b"
        , Color "darkolivegreen" "#556b2f"
        , Color "darkorange" "#ff8c00"
        , Color "darkorchid" "#9932cc"
        , Color "darkred" "#8b0000"
        , Color "darksalmon" "#e9967a"
        , Color "darkseagreen" "#8fbc8f"
        , Color "darkslateblue" "#483d8b"
        , Color "darkturquoise" "#00ced1"
        , Color "darkviolet" "#9400d3"
        , Color "deeppink" "#ff1493"
        , Color "deepskyblue" "#00bfff"
        , Color "dodgerblue" "#1e90ff"
        , Color "firebrick" "#b22222"
        , Color "floralwhite" "#fffaf0"
        , Color "forestgreen" "#228b22"
        , Color "fuchsia" "#ff00ff"
        , Color "gainsboro" "#dcdcdc"
        , Color "ghostwhite" "#f8f8ff"
        , Color "gold" "#ffd700"
        , Color "goldenrod" "#daa520"
        , Color "green" "#008000"
        , Color "greenyellow" "#adff2f"
        , Color "honeydew" "#f0fff0"
        , Color "hotpink" "#ff69b4"
        , Color "indianred" "#cd5c5c"
        , Color "indigo" "#4b0082"
        , Color "ivory" "#fffff0"
        , Color "khaki" "#f0e68c"
        , Color "lavender" "#e6e6fa"
        , Color "lavenderblush" "#fff0f5"
        , Color "lawngreen" "#7cfc00"
        , Color "lemonchiffon" "#fffacd"
        , Color "lightblue" "#add8e6"
        , Color "lightcoral" "#f08080"
        , Color "lightcyan" "#e0ffff"
        , Color "lightgoldenrodyellow" "#fafad2"
        , Color "lightgreen" "#90ee90"
        , Color "lightpink" "#ffb6c1"
        , Color "lightsalmon" "#ffa07a"
        , Color "lightseagreen" "#20b2aa"
        , Color "lightskyblue" "#87cefa"
        , Color "lightsteelblue" "#b0c4de"
        , Color "lightyellow" "#ffffe0"
        , Color "lime" "#00ff00"
        , Color "limegreen" "#32cd32"
        , Color "linen" "#faf0e6"
        , Color "magenta" "#ff00ff"
        , Color "maroon" "#800000"
        , Color "mediumaquamarine" "#66cdaa"
        , Color "mediumblue" "#0000cd"
        , Color "mediumorchid" "#ba55d3"
        , Color "mediumpurple" "#9370db"
        , Color "mediumseagreen" "#3cb371"
        , Color "mediumslateblue" "#7b68ee"
        , Color "mediumspringgreen" "#00fa9a"
        , Color "mediumturquoise" "#48d1cc"
        , Color "mediumvioletred" "#c71585"
        , Color "midnightblue" "#191970"
        , Color "mintcream" "#f5fffa"
        , Color "mistyrose" "#ffe4e1"
        , Color "moccasin" "#ffe4b5"
        , Color "navajowhite" "#ffdead"
        , Color "navy" "#000080"
        , Color "oldlace" "#fdf5e6"
        , Color "olive" "#808000"
        , Color "olivedrab" "#6b8e23"
        , Color "orange" "#ffa500"
        , Color "orangered" "#ff4500"
        , Color "orchid" "#da70d6"
        , Color "palegoldenrod" "#eee8aa"
        , Color "palegreen" "#98fb98"
        , Color "paleturquoise" "#afeeee"
        , Color "palevioletred" "#db7093"
        , Color "papayawhip" "#ffefd5"
        , Color "peachpuff" "#ffdab9"
        , Color "peru" "#cd853f"
        , Color "pink" "#ffc0cb"
        , Color "plum" "#dda0dd"
        , Color "powderblue" "#b0e0e6"
        , Color "purple" "#800080"
        , Color "rebeccapurple" "#663399"
        , Color "red" "#ff0000"
        , Color "rosybrown" "#bc8f8f"
        , Color "royalblue" "#4169e1"
        , Color "saddlebrown" "#8b4513"
        , Color "salmon" "#fa8072"
        , Color "sandybrown" "#f4a460"
        , Color "seagreen" "#2e8b57"
        , Color "seashell" "#fff5ee"
        , Color "sienna" "#a0522d"
        , Color "silver" "#c0c0c0"
        , Color "skyblue" "#87ceeb"
        , Color "slateblue" "#6a5acd"
        , Color "snow" "#fffafa"
        , Color "springgreen" "#00ff7f"
        , Color "steelblue" "#4682b4"
        , Color "tan" "#d2b48c"
        , Color "teal" "#008080"
        , Color "thistle" "#d8bfd8"
        , Color "tomato" "#ff6347"
        , Color "turquoise" "#40e0d0"
        , Color "violet" "#ee82ee"
        , Color "wheat" "#f5deb3"
        , Color "whitesmoke" "#f5f5f5"
        , Color "yellow" "#ffff00"
        , Color "yellowgreen" "#9acd32"
        ]



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

        colorName =
            String.toLower expected.name
    in
    if guess == colorName then
        Correct

    else if
        (String.length guess >= 4)
            && String.contains guess colorName
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
    ( { color = Color "white" "#fff"
      , guessInput = ""
      , score = 0
      , previousGuess = Nothing
      }
    , Random.generate ChangeColor randomColor
    )



-- UPDATE


type Msg
    = ChangeGuess String
    | ChangeColor Color
    | CheckGuess


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
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



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text (String.fromInt model.score) ]
        , input
            [ placeholder "Your Guess"
            , value model.guessInput
            , onInput ChangeGuess
            ]
            []
        , div [] [ text (model.color.name ++ " " ++ model.color.hex) ]
        , div [] [ text model.guessInput ]
        , button [ onClick CheckGuess ] [ text "Check Guess" ]
        , div [] [ text (Debug.toString model.previousGuess) ]
        ]
