// ----------------------------------------------------
// Object Method: ReplacementBin_l
// User name (OS): cjmiller
// Date and time: 04/14/08, 14:13:05
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2008_CJM_v56  //r001 `04/14/08, 14:13:08 
	Mods_2008_CJM_v56  //r004 `06/30/08, 12:56:59  `Make sure data entry area for replacement bdept is invisible on load
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		ReplacementBin_l:=0
		NonReplacementBin_l:=0
		OBJECT SET VISIBLE:C603(*; "Replacementbdept@"; False:C215)
		OBJECT SET ENABLED:C1123(ZZ8; False:C215)  // Command Replaced was o_DISABLE BUTTON 
	: (Form event code:C388=On Clicked:K2:4)
		If (ReplacementBin_l=1)
			NonReplacementBin_l:=0
			OBJECT SET VISIBLE:C603(*; "Replacementbdept@"; True:C214)
			OBJECT SET ENABLED:C1123(ZZ8; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			PRJ_DEBridgeNo_s:=""
			PRJ_DEBridgeNo_s:=Substring:C12([Bridge MHD NBIS:1]BDEPT:1; 1; 3)
			OBJECT SET ENABLED:C1123(ZZ8; True:C214)
			HIGHLIGHT TEXT:C210(PRJ_DEBridgeNo_s; 4; 4)
		Else 
			NonReplacementBin_l:=1
			ReplacementBin_l:=0
			OBJECT SET ENABLED:C1123(ZZ8; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET VISIBLE:C603(*; "Replacementbdept@"; False:C215)
			PRJ_DEBridgeNo_s:=""
		End if 
		
End case 

//End Object Method: ReplacementBin_l