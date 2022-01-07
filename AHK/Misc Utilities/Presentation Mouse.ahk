;///////////////////////////////////////////////////////////////////////
;//Purpose: For using a wireless mouse as a presentation clicker.
;///////////////////////////////////////////////////////////////////////
;//Comments: Created on Monday, November 30, 2020 10:56 AM for 2 upcoming
;speeches for 2 different classes of mine. I didn't have a clicker so this
;tiny script was created.
;When using a wireless mouse, place your middle finger on the right button,
;and place your pointer finger on the left button.
;Right = forward. Left = backwards. Middle = suspend hotkeys.
;///////////////////////////////////////////////////////////////////////
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
#SingleInstance force

MButton::Suspend
RButton::Right
LButton::Left