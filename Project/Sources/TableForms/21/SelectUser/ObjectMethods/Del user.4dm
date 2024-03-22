If (False:C215)
	Mods_2011_06  // CJ Miller`06/20/11, 10:40:55      ` Type all local variables for v11
End if 

CONFIRM:C162("Delete user : "+aUserInfo{aUserInfo}+"?")
If (OK=1)
	DELETE USER:C615(aUserIDs{aUserInfo})
	C_LONGINT:C283($i)
	For ($i; 1; NumUsers)
		aUserInfo{$i}:=aUserNames{$i}+"  ID: "+String:C10(aUserIDs{$i}; "#######")
		If (Is user deleted:C616(aUserIDs{$i}))
			aUserInfo{$i}:=aUserInfo{$i}+" Deleted"
		End if 
	End for 
	vGroupList:="User "+aUserInfo{aUserInfo}
	REDRAW:C174(aUserInfo)
	REDRAW:C174(vGroupList)
End if 