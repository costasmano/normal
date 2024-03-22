If (False:C215)
	//[PRJ_ProjectDetails];"ProjectDetails.o".PRJ_ShowAdStat_L
	PRJ_ShowAdPrjStatus  //we launch this one
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
		C_LONGINT:C283($pid)
		$pid:=LSpawnProcess("PRJ_ShowAdPrjStatus"; <>LStackSize; "Ad Status"; True:C214; False:C215)
		
End case 
