;Like an InputBox but can accept \n
;MLI = Multi-Line Input
global MLI_WIDTH := 300
global MLI_HEIGHT := 200
global MLI_TITLE := "MLI"
global mliInput := ""

newInput(title, prompt, width, height) {
    Gui, MLI:New, +AlwaysOnTop, %MLI_TITLE%
    Gui, MLI:Font, s14
    textY := MLI_HEIGHT / 3
    Gui, MLI:Add, Text, +Center x0 y%textY% w%MLI_WIDTH%, %prompt%
    Gui, MLI:Show, w%MLI_WIDTH% h%MLI_HEIGHT%, %MLI_TITLE%
}

destroyInput() {
    Gui, MLI:Destroy
}

newInput(MLI_TITLE, "Text to Search For", MLI_WIDTH, MLI_HEIGHT)