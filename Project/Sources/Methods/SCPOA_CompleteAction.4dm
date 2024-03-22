//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/13/10, 10:23:25
	// ----------------------------------------------------
	// Method: Method: SCPOA_CompleteAction
	// Description
	//  ` Perform data changes when POA is marked as complete
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_10
	// Modified by: costasmanousakis-(Designer)-(5/6/11 15:57:52)
	Mods_2011_05
	//  `SCPOA V2 modifications
End if 
If ([ScourPOA:132]Completed:21)
	SCPOA_Item8_c_txt:=SCPOA_Item8_txt
	SCPOA_Item113_c_txt:=SCPOA_Item113_txt
	SCPOA_Item60_c_txt:=SCPOA_Item60_txt
	SCPOA_Item61_c_txt:=SCPOA_Item61_txt
	SCPOA_Item71_c_txt:=SCPOA_Item71_txt
Else 
	SCPOA_Item8_c_txt:=""
	SCPOA_Item113_c_txt:=""
	SCPOA_Item60_c_txt:=""
	SCPOA_Item61_c_txt:=""
	SCPOA_Item71_c_txt:=""
End if 
SCPOA_CompleteChkBx:=Num:C11(f_Boolean2String([ScourPOA:132]Completed:21; "10"))