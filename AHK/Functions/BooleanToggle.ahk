;Pass in a boolean toggle, and it gets toggled to its opposite state. Also has two custom Tippy messages for true/false.
booleanToggle(ByRef Boolean, TippyMsgTrue, TippyMsgFalse, TippyDelay := 400) {
    Boolean := !Boolean

    if (Boolean = true)
        Tippy(TippyMsgTrue, TippyDelay)
    else
        Tippy(TippyMsgFalse, TippyDelay)

    return Boolean
}