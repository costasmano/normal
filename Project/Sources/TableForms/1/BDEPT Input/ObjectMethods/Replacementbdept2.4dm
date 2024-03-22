// ----------------------------------------------------
// Object Method: PRJ_DEDBridgeNo_s
// User name (OS): cjmiller
// Date and time: 01/10/06, 15:52:34
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(11/12/09 14:07:45)
	Mods_2009_11
	//Added handling of special case when there is not an existing project with the BDEPT
	//being replaced. To avoid making replacement BINs - set the toggle to New bridge
End if 
PRJ_DEBridgeNo_s:=Get edited text:C655

Case of 
	: (PRJ_DEBridgeNo_s="")
		OBJECT SET ENABLED:C1123(zz8; False:C215)  // Command Replaced was o_DISABLE BUTTON 
	: (Length:C16(PRJ_DEBridgeNo_s)#6)
		OBJECT SET ENABLED:C1123(zz8; False:C215)  // Command Replaced was o_DISABLE BUTTON 
	Else 
		OBJECT SET ENABLED:C1123(zz8; True:C214)
		READ ONLY:C145([PRJ_ProjectDetails:115])
		READ ONLY:C145([PRJ_ProjectDetailsIncludedBINS:122])
		
		QUERY:C277([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5=PRJ_DEBridgeNo_s+"@")
		
		QUERY SELECTION:C341([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PRJ_Completion_d:37=!00-00-00!)
		C_LONGINT:C283($NumberRecords_l)
		$NumberRecords_l:=Records in selection:C76([PRJ_ProjectDetails:115])
		C_BOOLEAN:C305($RetrieveBins_b)
		$RetrieveBins_b:=False:C215
		Case of 
			: ($NumberRecords_l=1)
				$RetrieveBins_b:=True:C214
			: ($NumberRecords_l=0)
				$RetrieveBins_b:=False:C215
				CONFIRM:C162("There are no active Bridge Projects for Bridge No. "+PRJ_DEBridgeNo_s+"! Continue saving or try another BDEPT?"; "Continue"; "Try again")
				If (OK=1)
					$RetrieveBins_b:=True:C214
					ALERT:C41("To avoid conflicts, this is being marked as a New bridge!")
					ReplacementBin_l:=0
					NonReplacementBin_l:=1
					OBJECT SET VISIBLE:C603(*; "Replacementbdept@"; False:C215)
					PRJ_DEBridgeNo_s:=""
				Else 
					
				End if 
				
			Else 
				C_LONGINT:C283($w; $H)
				FORM GET PROPERTIES:C674([PRJ_ProjectDetails:115]; "NewBDEPTSelection.o"; $W; $H)
				CENTER_WINDOW($W; 850; Plain form window:K39:10)
				FORM SET OUTPUT:C54([PRJ_ProjectDetails:115]; "NewBDEPTSelection.o")
				DISPLAY SELECTION:C59([PRJ_ProjectDetails:115]; *)
				CLOSE WINDOW:C154
				If (Records in selection:C76([PRJ_ProjectDetails:115])=1)
					$RetrieveBins_b:=True:C214
				Else 
					PRJ_DEBridgeNo_s:=Substring:C12(PRJ_DEBridgeNo_s; 1; 5)
				End if 
		End case 
		
		If ($RetrieveBins_b)
			
			//OBJECT SET ENABLED(zz8;True)  // Command Replaced was o_ENABLE BUTTON 
		End if 
End case 
//End Object Method: PRJ_DEDBridgeNo_s