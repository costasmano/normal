//%attributes = {"invisible":true}

// ----------------------------------------------------
// User name (OS): administrator
// Date and time: 09/04/14, 14:58:36
// ----------------------------------------------------
// Method: LSS_ControlUT
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2019_02  //  //Change lss inspection input forms to use subforms wherever possible
	//Modified by: Chuck Miller (2/4/19 16:49:28)
End if 
Case of 
		
	: (Form event code:C388=On Clicked:K2:4)
		USE NAMED SELECTION:C332("UT_LB")
		LSS_SelectUTResults
		
	: (Form event code:C388=On Double Clicked:K2:5)
		USE NAMED SELECTION:C332("UT_LB")
		LSS_ModifyUT
		
		LSS_SelectUTResults
		
		REDRAW:C174(UT_LB)
		
End case 