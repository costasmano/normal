//[Inspections];"Routine Form"
//Description for vDiveMaster

C_TEXT:C284(vDiveMaster)  // Command Replaced was o_C_STRING length was 44

If (Form event code:C388=On Printing Detail:K2:18)
	
	//vDiveMaster:=Uppercase(Get_Description (->aPeople;->aPeople_ID;->[Inspections]TeamLeader))
	
	PERS_GetInfo([Inspections:27]TeamLeader:4; "FILASTNAME"; ->vDiveMaster)
	Case of 
		: (Length:C16(vDiveMaster)>22)
			OBJECT SET FONT SIZE:C165(*; "vDiveMaster"; 7)
		: (Length:C16(vDiveMaster)>19)
			OBJECT SET FONT SIZE:C165(*; "vDiveMaster"; 8)
		: (Length:C16(vDiveMaster)>16)
			OBJECT SET FONT SIZE:C165(*; "vDiveMaster"; 9)
	End case 
End if 
