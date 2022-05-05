;When Terminal tab active, get a branch name and delete the local and remote branches.
^!d::
InputBox, branchName, Enter Branch Name, Enter Name of Branch to Delete,, 220, 120,,,,
cmd := "git branch -d " . branchName .  "; git push origin --delete " . branchName
Send, %cmd%
Send, {Enter}
return