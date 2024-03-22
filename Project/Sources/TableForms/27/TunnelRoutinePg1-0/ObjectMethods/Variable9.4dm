
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 04/30/13, 13:32:31
//----------------------------------------------------
//Method: Object Method: [Inspections].TunnelRoutinePg1.vBrClrSgnNE
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2013_04  //r001 ` 
	//Modified by: Charles Miller (4/30/13 13:32:33)
	
End if 
If ([Inspections:27]ClrPosting:49=True:C214)
	vClrPost:=""
	vBrClrSgnNE:=[Inspections:27]BrClrSignsNE:54
	vBrClrSgnSW:=[Inspections:27]BrClrSignsSW:55
	vAdClrSgnNE:=[Inspections:27]AdClrSignNE:56
	vAdClrSgnSW:=[Inspections:27]AdClrSignSW:57
Else 
	vClrPost:="X"
	vBrClrSgnNE:=""
	vBrClrSgnSW:=""
	vAdClrSgnNE:=""
	vAdClrSgnSW:=""
End if 
//End Object Method: [Inspections].TunnelRoutinePg1.vBrClrSgnNE

