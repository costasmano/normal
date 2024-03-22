If (False:C215)
	Mods_2011_06  // CJ Miller`06/20/11, 10:39:49      ` Type all local variables for v11
End if 
If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Clicked:K2:4))
	If (Is user deleted:C616(aUserIDs{aUserInfo}))
		vGroupList:="User "+aUserInfo{aUserInfo}
	Else 
		vGroupList:=""
		C_TEXT:C284($uname; $ustartup; $upwd)
		C_LONGINT:C283($unblogin; $k; $i; $ngrps)
		C_DATE:C307($ulastlogin)
		ARRAY LONGINT:C221($ugroups; 0)
		GET USER PROPERTIES:C611(aUserIDs{aUserinfo}; $uname; $ustartup; $upwd; $unblogin; $ulastlogin)
		If (Size of array:C274($ugroups)>0)
			vGroupList:="User "+aUserInfo{aUserInfo}+" is member of :"+<>sCR
			$ngrps:=Size of array:C274($ugroups)
			GET GROUP LIST:C610($aGroupNames; $aGroupIDs)
			For ($i; 1; $ngrps)
				$k:=Find in array:C230($aGroupIDs; $ugroups{$i})
				If ($k>0)
					vGroupList:=vGroupList+$aGroupNames{$k}+<>sCR
				Else 
					vGroupList:="Bad Group ID "+String:C10($ugroups{$i})+<>sCR
				End if 
				
			End for 
			
		Else 
			vGroupList:="User "+aUserInfo{aUserInfo}+" does not belong to any groups"
		End if 
		
	End if 
	
End if 
