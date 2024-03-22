//%attributes = {"shared":true}
// ----------------------------------------------------
// PRJ_QR_ReturnRoadwayUnder
// User name (OS): cjmiller
// Date and time: 03/22/07, 12:48:16
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
End if 
C_TEXT:C284($0)
If ([PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34="")
	$0:=""
Else 
	$0:=[Bridge MHD NBIS:1]Item6A:63
End if 
//End PRJ_QR_ReturnRoadwayUnder