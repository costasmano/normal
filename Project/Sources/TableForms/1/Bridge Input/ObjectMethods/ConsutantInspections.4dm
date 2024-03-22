//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 02/16/12, 14:30:05
//----------------------------------------------------
//Method: Object Method: [Bridge MHD NBIS].Cslt Insps.List Box
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_02  //r001
	//Modified by: Charles Miller (2/16/12 14:30:06)
	
End if 
Case of 
		
	: (Form event code:C388=On Display Detail:K2:22)
		SIA_OnDisplayDetail
	: (Form event code:C388=On Double Clicked:K2:5)
		SIA_ControlDoubleClick
End case 
//End Object Method: [Bridge MHD NBIS].Cslt Insps.List Box