//%attributes = {"invisible":true}
//Method: Test_SearchNBEs
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/11/16, 16:31:48
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
End if 
//
C_POINTER:C301(pFile)
pFile:=->[Bridge MHD NBIS:1]
C_TEXT:C284(MainTitle)
C_TEXT:C284($InspRespChoice_txt)
C_LONGINT:C283($choice_L)
$InspRespChoice_txt:="Dist1;Dist2;Dist3;Dist4;Dist5;Dist6;MBTA;MDC;MPA"
$choice_L:=Pop up menu:C542($InspRespChoice_txt)
ARRAY TEXT:C222($Hoices_atxt; 0)
ut_TextToArray($InspRespChoice_txt; ->$Hoices_atxt; ";")
If ($choice_L>0)
	QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]InspResp:173=$Hoices_atxt{$choice_L})
Else 
	QUERY:C277([Bridge MHD NBIS:1])
End if 

M_SearchNBEElmts

//QR REPORT([PON_ELEM_INSP];Char(1))
//End Test_SearchNBEs