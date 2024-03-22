//%attributes = {"invisible":true}
If (False:C215)
	//G_TeamLeader 
	//Method to be called from the Team Leader object on inspection print forms
	Mods_2012_09  //r001 ` 
	//Modified by: Charles Miller (9/13/12 14:36:15)
End if 

C_TEXT:C284(vTeamLdr)  // Command Replaced was o_C_STRING length was 40

If (Form event code:C388=On Printing Detail:K2:18)
	
	vTeamLdr:=fn_ReturnName(->[Inspections:27]TeamLeader:4)
	READ ONLY:C145([Personnel:42])
	QUERY:C277([Personnel:42]; [Personnel:42]Person ID:1=[Inspections:27]TeamLeader:4)
	
	If ([Personnel:42]Suffix:6="@P.E.@")
		vTeamLdr:=vTeamLdr+[Personnel:42]Suffix:6
	End if 
	
	Case of 
		: (Length:C16(vTeamLdr)>32)
			OBJECT SET FONT SIZE:C165(*; "vTeamLdr"; 8)
		: (Length:C16(vTeamLdr)>25)
			OBJECT SET FONT SIZE:C165(*; "vTeamLdr"; 9)
	End case 
End if 