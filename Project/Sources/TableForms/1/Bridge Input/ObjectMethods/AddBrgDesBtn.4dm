//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 02/21/12, 15:16:35
//----------------------------------------------------
//Method: Object Method: [Bridge MHD NBIS].Bridge Design.bAdd
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_02  //r001
	//Modified by: Charles Miller (2/21/12 15:16:36)
	
End if 
FORM SET INPUT:C55([Bridge Design:75]; "Bridge Design In")
ADD RECORD:C56([Bridge Design:75])
vbNewRtgRec:=False:C215
QUERY:C277([Bridge Design:75]; [Bridge Design:75]BIN:1=[Bridge MHD NBIS:1]BIN:3)
ORDER BY:C49([Bridge Design:75]; [Bridge Design:75]ADVDate:4; <)
LB_Header3_l:=2
//End Object Method: [Bridge MHD NBIS].Bridge Design.bAdd