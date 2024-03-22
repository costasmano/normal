//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 02/14/13, 12:00:59
//----------------------------------------------------
//Method: Object Method: [Bridge MHD NBIS].NBIS Stack Info MBTA.INSP_KiloPtVal_r
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2013_02  //r001 ` 
	//Modified by: Charles Miller (2/21/13 13:31:25)
	// Modified by: Costas Manousakis-(Designer)-(4/23/13 09:31:24)
	Mods_2013_04
	//  `Show Milepost only for RRO records
End if 

If ([Bridge MHD NBIS:1]Item8 BridgeCat:207="RRO")
	INSP_KiloPtVal_r:=Round:C94([Bridge MHD NBIS:1]RRBridgeNo:211; 2)  //Is this correct?
Else 
	INSP_KiloPtVal_r:=0
End if 

//End Object Method: [Bridge MHD NBIS].NBIS Stack Info MBTA.INSP_KiloPtVal_r