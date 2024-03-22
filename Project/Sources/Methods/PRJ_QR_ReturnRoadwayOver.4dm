//%attributes = {"shared":true}
// ----------------------------------------------------
// PRJ_QR_ReturnRoadwayOver
// User name (OS): cjmiller
// Date and time: 03/22/07, 12:44:34
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
	$0:=[PRJ_ProjectDetails:115]PRJ_NonBridgeNotes_txt:40
Else 
	QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=[PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34)
	$0:=[Bridge MHD NBIS:1]Item7:65+" / "+[Bridge MHD NBIS:1]Item6A:63
End if 
//End PRJ_QR_ReturnRoadwayOver