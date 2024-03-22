If (False:C215)
	
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		If ((Current user:C182="Designer"))
			OBJECT SET VISIBLE:C603(Self:C308->; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(Self:C308->; False:C215)
		End if 
		
	: (Form event code:C388=On Data Change:K2:15)
		
		
	: (Form event code:C388=On Clicked:K2:4)
		
		C_LONGINT:C283($choise_L)
		$choise_L:=Pop up menu:C542("Search from clipboard by ...;[PRJ_ProjectFile]PF_FileNumber_l;[PRJ_ProjectDetails]PRJ_BridgeNo_s")
		
		Case of 
			: ($choise_L=2)
				ut_ClipBoardSearch(->[PRJ_ProjectDetails:115]; ->[PRJ_ProjectFile:117]PF_FileNumber_l:3)
			: ($choise_L=3)
				ut_ClipBoardSearch(->[PRJ_ProjectDetails:115]; ->[PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5)
		End case 
		
		If ($choise_L>1)
			PRJ_DetailLBSetUpDisplayEvent
		End if 
End case 
