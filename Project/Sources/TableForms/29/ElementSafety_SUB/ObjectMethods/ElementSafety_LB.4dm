//Method: [Standard Photos].LB_StdPhotosInc_SUB.List Box
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 04/18/19, 13:18:48
	// ----------------------------------------------------
	//Created : 
	Mods_2019_04
	Mods_2021_04  //Change from auto to selecting input on sub forms by double clicking 
	//Modified by: CJ (4/8/21 15:51:14)
	
End if 
//
Case of 
	: (Form event code:C388=On Double Clicked:K2:5)
		CTRL_SubFormDoubleClick(->[ElementsSafety:29]; "Safety ElmInput"; "ElementSafety_LB")
		
	: (Form event code:C388=On Display Detail:K2:22)
		vItemNo:=INSP_ElmtSfty_ItemNo([ElementsSafety:29]ElementNo:1)
		
		//Display description
		vElmDescr:=GetElmtNumber+" "+[ElementsSafety:29]Description:22
		If (INSP_IsInspRoutine_b)
			If ([ElementsSafety:29]SpecMemb Flag:8)
				vElmDescr:=vElmDescr+" - (Spec.Mb.)"
			End if 
		End if 
		
	: (Form event code:C388=On Close Detail:K2:24)
		CALL SUBFORM CONTAINER:C1086(-20)
End case 
//End [Standard Photos].LB_StdPhotosInc_SUB.List Box