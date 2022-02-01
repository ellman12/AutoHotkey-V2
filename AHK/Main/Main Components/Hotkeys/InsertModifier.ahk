;Inserting very common symbols as a faster alternative to using Prompt.
#If (GetKeyState("Insert", "P"))

a::Send, {U+2200} ;∀
!a::Send, {U+2227} ;∧
e::Send, {U+2208} ;∈
!e::Send, {U+2203} ;∃
i::Send, {U+2229} ;∩
m::Send, {U+21A6} ;↦
n::Send, {U+00AC} ;¬
o::Send, {U+2228} ;∨
r::Send, {U+211D} ;ℝ
s::Send, {U+2282} ;⊂
+s::Send, {U+2286} ;⊆
u::Send, {U+222A} ;∪

Up::Send, {U+2191} ;↑
Right::Send, {U+2192} ;→
Down::Send, {U+2193} ;↓
Left::Send, {U+2190} ;←
!Up::Send, {U+27F5} ;⟵
!Right::Send, {U+27F6} ;⟶
!Down::Send, {U+27F9} ;⟹
!Left::Send, {U+27F8} ;⟸

#If