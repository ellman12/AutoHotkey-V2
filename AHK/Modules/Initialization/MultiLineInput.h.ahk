;Like an InputBox but can accept \n
;MLI = Multi-Line Input
global MLI_WIDTH := 300
global MLI_HEIGHT := 252
global MLI_TITLE := "MLI"
global mliInput := ""

newInput(title, prompt, width, height) {
    Gui, MLI:New, +AlwaysOnTop, %MLI_TITLE%
    Gui, MLI:Font, s14
    Gui, MLI:Add, Text, x5 y5, %prompt%
    
    width := MLI_WIDTH - 12
    height := MLI_HEIGHT - 75
    Gui, MLI:Add, Edit, xp yp+25 w%width% h%height% -VScroll
    
    Gui, MLI:Font, s11
    Gui, MLI:Add, Button, +Center xp yp+185 h30 w55, OK
    Gui, MLI:Add, Button, +Center xp+66 yp h30 w55, Cancel
    
    Gui, MLI:Show, w%MLI_WIDTH% h%MLI_HEIGHT% x2000, %MLI_TITLE%
}

destroyInput() {
    Gui, MLI:Destroy
}

newInput(MLI_TITLE, "Text to Search In", MLI_WIDTH, MLI_HEIGHT)
; newInput(MLI_TITLE, "Text to Search For", MLI_WIDTH, MLI_HEIGHT)
; newInput(MLI_TITLE, "Text to Replace With", MLI_WIDTH, MLI_HEIGHT)