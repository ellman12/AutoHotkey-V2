;Created Thursday, November 5, 2020
#NoEnv
#MaxHotkeysPerInterval 999999999999999999999999999999999
#HotkeyInterval 99999999999999999999999999999999999
#KeyHistory 0
ListLines Off
Process, Priority, , A
SetBatchLines, -1
SetKeyDelay, -1, -1
SetMouseDelay, -1
SetDefaultMouseSpeed, 0
SetWinDelay, -1
SetControlDelay, -1
SendMode Input
DetectHiddenWindows, Off
#SingleInstance force

blockInputToggle := false

!p::
blockInputToggle := !blockInputToggle

if (blockInputToggle = true)
    MsgBox, 64, Input Is Now Blocked, Input Is Now Blocked. Use Alt + P to disable., 1
else if (blockInputToggle = false)
    MsgBox, 64, Input Is No Longer Blocked, Input Is No Longer Blocked., 1
return

#If blockInputToggle = true
escape::
F1::
F2::
F3::
F4::
F5::
F6::
F7::
F9::
F8::
F10::
F11::
F12::
insert::
delete::
PrintScreen::
`::
1::
2::
3::
4::
5::
6::
7::
8::
9::
0::
-::
=::
BackSpace::
tab::
q::
w::
e::
r::
t::
y::
u::
i::
o::
; p::
[::
]::
\::
CapsLock::
a::
s::
d::
f::
g::
h::
j::
K::
l::
`;::
'::
enter::
z::
x::
c::
v::
b::
n::
m::
,::
.::
/::
space::
Lshift::
Lctrl::
; Lalt::
Lwin::
rshift::
rctrl::
ralt::
rwin::
appskey::
ScrollLock::
home::
end::
pgup::
pgdn::
up::
down::
left::
right::
NumPad0::
NumPad1::
NumPad2::
NumPad3::
NumPad4::
NumPad5::
NumPad6::
NumPad7::
NumPad8::
NumPad9::
NumPadins::
NumPadend::
NumPaddown::
NumPadpgdn::
NumPadleft::
NumPadclear::
NumPadright::
NumPadhome::
NumPadup::
NumpadPgup::
NumLock::
NumPadDiv::
NumPadMult::
NumPadSub::
NumPadAdd::
NumPadEnter::
NumPadDot::

; LButton::
; MButton::
; RButton::
; XButton1::
; XButton2::
; WheelDown::
; WheelUp::
; WheelLeft::
; WheelRight::
return
#If

/*
*escape::
*F1::
*F2::
*F3::
*F4::
*F5::
*F6::
*F7::
*F9::
*F8::
*F10::
*F11::
*F12::
*insert::
*delete::
*PrintScreen::
*`::
*1::
*2::
*3::
*4::
*5::
*6::
*7::
*8::
*9::
*0::
*-::
*=::
*BackSpace::
*tab::
*q::
*w::
*e::
*r::
*t::
*y::
*u::
*i::
*o::
*p::
*[::
*]::
*\::
*CapsLock::
*a::
*s::
*d::
*f::
*g::
*h::
*j::
*K::
*l::
*`;::
*'::
*enter::
*z::
*x::
*c::
*v::
*b::
*n::
*m::
*,::
*.::
; */::
*space::
*Lshift::
*Lctrl::
*Lalt::
*Lwin::
*rshift::
*rctrl::
*ralt::
*rwin::
*appskey::
*ScrollLock::
*home::
*end::
*pgup::
*pgdn::
*up::
*down::
*left::
*right::
*NumPad0::
*NumPad1::
*NumPad2::
*NumPad3::
*NumPad4::
*NumPad5::
*NumPad6::
*NumPad7::
*NumPad8::
*NumPad9::
*NumPadins::
*NumPadend::
*NumPaddown::
*NumPadpgdn::
*NumPadleft::
*NumPadclear::
*NumPadright::
*NumPadhome::
*NumPadup::
*NumpadPgup::
*NumLock::
*NumPadDiv::
*NumPadMult::
*NumPadSub::
*NumPadAdd::
*NumPadEnter::
*NumPadDot::

; LButton::
; MButton::
; RButton::
; XButton1::
; XButton2::
; WheelDown::
; WheelUp::
; WheelLeft::
; WheelRight::
return
*/