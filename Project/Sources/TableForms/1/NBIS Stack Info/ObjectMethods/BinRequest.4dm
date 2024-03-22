//Method: [Bridge MHD NBIS].NBIS Stack Info.BinRequest
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 06/27/19, 10:52:25
	// ----------------------------------------------------
	//Created : 
	Mods_2019_06
End if 
//
Case of 
		
		
	: (Form event code:C388=On Clicked:K2:4)
		If (Records in set:C195("UserSet")=1)
			COPY NAMED SELECTION:C331([Bridge MHD NBIS:1]; "TempNSel")
			USE SET:C118("UserSet")
			
			Bridge_CopyBinRequest
			USE NAMED SELECTION:C332("TempNSel")
			CLEAR NAMED SELECTION:C333("TempNSel")
			
			POST OUTSIDE CALL:C329(Current process:C322)
		Else 
			If (Records in set:C195("UserSet")=0)
				ALERT:C41("you must select a record to proceed")
			Else 
				ALERT:C41("you can only select one record at a time")
				
			End if 
			
		End if 
End case 
//End [Bridge MHD NBIS].NBIS Stack Info.BinRequest