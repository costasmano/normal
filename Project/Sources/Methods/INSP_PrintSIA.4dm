//%attributes = {"invisible":true}
// Method: INSP_PrintSIA
// Description
// Print the SIA form from inside an Inspection report Print command.
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/26/07, 10:54:45
	// ----------------------------------------------------
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CM05a
	// Modified by: costasmanousakis-(Designer)-(9/12/2007 11:42:33)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(9/28/2007 09:00:43)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(1/18/11 16:16:37)
	Mods_2011_01
	//` Rail Road changes
	// Modified by: Costas Manousakis-(Designer)-(8/11/14 16:13:46)
	Mods_2014_08
	//  `make sure  [RAILBridgeInfo] record is loaded  ; added NBIS]InspResp="MBTA" check
	// Modified by: Costas Manousakis-(Designer)-(10/14/15 10:08:52)
	Mods_2015_10_bug
	//  `print the "RailTransitSIA" only for @RO bridges; else use method SIA_PrintForms
End if 
C_LONGINT:C283(vPgs; vPgf; vPageNo; vTotalPages)  //Command Replaced was o_C_INTEGER
vPgs:=0  // Mods_2007_CM12_5301 09/28/07
vPgf:=0

G_PrintOptions  // Mods_2007_CM12_5301 09/12/07
If ([Bridge MHD NBIS:1]Item8 BridgeCat:207="@RO")
	READ ONLY:C145([RAILBridgeInfo:37])
	QUERY:C277([RAILBridgeInfo:37]; [RAILBridgeInfo:37]BIN:1=[Bridge MHD NBIS:1]BIN:3)
	Print form:C5([Bridge MHD NBIS:1]; "RailTransitSIA")
Else 
	SIA_PrintForms(0; 1; 0)  //print the Inspection SIA
End if 
INSP_CheckLinks
vPageNo:=vPageNo+1