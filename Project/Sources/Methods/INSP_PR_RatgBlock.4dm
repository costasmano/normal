//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/10/07, 12:38:36
	// ----------------------------------------------------
	// Method: INSP_PR_RatgBlock
	// Description
	// Fill the variables for the Rating block info on Inspection forms.
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CM07
End if 
C_TEXT:C284(vWghtPost; vBrPstSgnNE; vBrPstSgnSW; vAdPstSgnNE; vAdPstSgnSW)  // Command Replaced was o_C_STRING length was 2
//Rating priority    
f_Var_to_Series([Inspections:27]RatingPriority:85; "xS"; "HML")

//Flags    
If ([Inspections:27]WeightPosting:30=True:C214)
	vWghtPost:=""
	vBrPstSgnNE:=[Inspections:27]BrPostSignsNE:37
	vBrPstSgnSW:=[Inspections:27]BrPostSignsSW:38
	vAdPstSgnNE:=[Inspections:27]AdPostSignNE:39
	vAdPstSgnSW:=[Inspections:27]AdPostSignSW:40
Else 
	vWghtPost:="X"
	vBrPstSgnNE:=""
	vBrPstSgnSW:=""
	vAdPstSgnNE:=""
	vAdPstSgnSW:=""
End if 
vRatingRep:=f_Boolean2String([Inspections:27]Rating Report:73; "YN")
vRerating:=f_Boolean2String([Inspections:27]Rerating:75; "YN")

G_Insp_HideRatReq

INSP_SetInspRtgVars