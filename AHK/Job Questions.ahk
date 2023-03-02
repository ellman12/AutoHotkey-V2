;Created 3/2/2023 to automate repetitive job application stuff.

employer := "Maximus"

::ph::5078589061
::addr::808 Center St.
::Cal::Caledonia

RShift::SendRaw, Legoman1ell!

;Application Questions
^#a::
switch (employer)
{
    case "Northrop Grumman":
        Send, n{Tab}
        Send, n{Tab}
        Send, n{Tab}
        Send, n{Tab}
        Send, {Tab 14}
        Send, n{Tab}
        Send, y{Tab}
        Send, y{Tab}
        Send, a{Tab}
        Send, n{Tab}
        Send, n{Tab}
        Send, n{Tab}
        Send, n{Tab}
        Send, n{Tab}
        Send, n{Tab}{Tab 2}   
    return
    
    case "Maximus":
        Send, {Tab}n
        Send, {Tab}y
        Send, {Tab}y
        Send, {Tab}n
        Send, {Tab}n
        Send, {Tab}n
        Send, {Tab}n
        Send, {Tab}NA
        Send, {Tab}y
        Send, {Tab}b
        Send, {Tab 2}
    return
    
    Default:
        MsgBox, Employer not defined
    Return
}
return

;Voluntary Disclosure
+#n::
switch (employer) {
    case "Northrop Grumman":
    
    return
    
    case "Maximus":
        Send, {Tab}m
        Send, {Tab}w
        Send, {Down 3}
        Send, {Tab 2}
    return
}
return