ORDER BY:C49(Current form table:C627->)
If (OK=1)
	Header1:=0
	Header2:=0
	Header3:=0
	Header4:=0
	Header5:=0
	Header6:=0
	Header7:=0
	If (False:C215)
		// Modified by: Costas Manousakis-(Designer)-(11/29/18 14:47:28)
		Mods_2018_11
		//  `hide the review and print buttons
	End if 
	
	//hide the review and print buttons
	OBJECT SET VISIBLE:C603(*; "LSS_Approved_L"; False:C215)
	OBJECT SET VISIBLE:C603(*; "LSS_Print_L"; False:C215)
	
End if 