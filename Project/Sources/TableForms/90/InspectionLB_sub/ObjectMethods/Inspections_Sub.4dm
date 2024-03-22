//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 02/21/12, 15:00:25
//----------------------------------------------------
//Method: Object Method: [Bridge MHD NBIS].Bridge Design.BridgeDesign
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_02  //r001
	//Modified by: Charles Miller (2/21/12 15:00:28)
	
End if 
Case of 
	: (Form event code:C388=On Display Detail:K2:22)
		SIA_OnDisplayDetail
	: (Form event code:C388=On Double Clicked:K2:5)
		SIA_ControlDoubleClick
		
End case 

//End Object Method: [Bridge MHD NBIS].Bridge Design.BridgeDesign