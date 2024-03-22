
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 03/20/12, 14:42:45
//----------------------------------------------------
//Method: Form Method: CloneActivityLogListBox
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_03  //r001`Added code to allow for diufferent method in retrieveing [Activity Log] records
	//Modified by: Charles Miller (3/20/12 14:42:46)
	
End if 
If (Form event code:C388=On Load:K2:1)
	RBAbort_l:=1
	RBReplace_l:=0
	RBSkip_l:=0
End if 
//End Form Method: CloneActivityLogListBox

