//%attributes = {"invisible":true}
//Method: SIA_PrintForms
//Description
// Print SIA form(s)
// Parameters
// $1 : $PrintInventory_L (0|1)
// $2 : $PrintInsp_L (0|1)
// $3 : $PrintMHDSpecific_L (0|1)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 10/14/15, 09:58:03
	// ----------------------------------------------------
	//Created : 
	Mods_2015_10_bug
	C_LONGINT:C283(SIA_PrintForms; $1)
	C_LONGINT:C283(SIA_PrintForms; $2)
	C_LONGINT:C283(SIA_PrintForms; $3)
	
End if 
//
C_LONGINT:C283($1; $2; $3)

If ($1=1)
	If ([Bridge MHD NBIS:1]InspResp:173="MBTA")
		If ([RAILBridgeInfo:37]BIN:1#[Bridge MHD NBIS:1]BIN:3)
			READ ONLY:C145([RAILBridgeInfo:37])
			QUERY:C277([RAILBridgeInfo:37]; [RAILBridgeInfo:37]BIN:1=[Bridge MHD NBIS:1]BIN:3)
		End if 
		//Print form([Bridge MHD NBIS];"RailTransitSIA")
	End if 
	Print form:C5([Bridge MHD NBIS:1]; "SI & A (Normal)")
	
End if 
//PAGE BREAK(>)
If ($2=1)
	
	If ([Bridge MHD NBIS:1]InspResp:173="MBTA")
		If ([RAILBridgeInfo:37]BIN:1#[Bridge MHD NBIS:1]BIN:3)
			READ ONLY:C145([RAILBridgeInfo:37])
			QUERY:C277([RAILBridgeInfo:37]; [RAILBridgeInfo:37]BIN:1=[Bridge MHD NBIS:1]BIN:3)
		End if 
		//Print form([Bridge MHD NBIS];"RailTransitSIA")
	Else 
	End if 
	Print form:C5([Bridge MHD NBIS:1]; "SI & A (Insp)")
	
End if 
If ($3=1)
	Print form:C5([Bridge MHD NBIS:1]; "MHD Specific Items")
End if 

//End SIA_PrintForms