//%attributes = {"invisible":true}
// Method: INSP_UpdateInspList
// Description
// Update / get the current list of inspections for the current BIN
// 
// Parameters
// $1 : $Bin_s [Optional]
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/20/08, 08:07:27
	// ----------------------------------------------------
	
	Mods_2008_CM_5404
	// Modified by: costasmanousakis-(Designer)-(4/10/09 08:49:17)
	Mods_2009_04
	//Use the new effect of GOTO SELECTED RECORD to clear the selection of inspections.
	// Modified by: Costas Manousakis-(Designer)-(1/2/13 11:49:34)
	Mods_2013_01
	//  `Added call to ut_Read_Write_Tables ("READ";.. to set tables to RO before getting the selection
	// Modified by: Costas Manousakis-(Designer)-(4/12/13 16:16:51)
	Mods_2013_04
	//  `Use new INSP_Read_Write_Tables
	// Modified by: Costas Manousakis-(Designer)-(5/1/13 13:49:05)
	Mods_2013_05
	//  `different inspection list for Bridges or Tunnels
	// Modified by: Costas Manousakis-(Designer)-(1/6/15 10:23:12)
	Mods_2015_01
	//  `added TDA (tunnel damage to the tunnel inspections)
	// Modified by: Costas Manousakis-(Designer)-(2/13/15 11:47:42)
	Mods_2015_02
	//  `added TOT (tunnel other to the tunnel inspections)
End if 
C_TEXT:C284($BIN_s)  // Command Replaced was o_C_STRING length was 3
If (Count parameters:C259>0)
	C_TEXT:C284($1)  // Command Replaced was o_C_STRING length was 3
	$BIN_s:=$1
Else 
	$BIN_s:=[Bridge MHD NBIS:1]BIN:3
End if 
C_BOOLEAN:C305(vbInspRefresh)

INSP_Read_Write_Tables("READ")

QUERY:C277([Combined Inspections:90]; [Combined Inspections:90]BIN:1=$BIN_s)
C_TEXT:C284(INSP_Inspection_list_txt)

If (INSP_Inspection_list_txt="")
	INSP_Inspection_list_txt:="BRIDGE"
End if 

Case of 
	: (INSP_Inspection_list_txt="BRIDGE")
		QUERY SELECTION:C341([Combined Inspections:90]; [Combined Inspections:90]InspType:5#"TAL"; *)
		QUERY SELECTION:C341([Combined Inspections:90];  & ; [Combined Inspections:90]InspType:5#"TOV"; *)
		QUERY SELECTION:C341([Combined Inspections:90];  & ; [Combined Inspections:90]InspType:5#"TDA"; *)
		QUERY SELECTION:C341([Combined Inspections:90];  & ; [Combined Inspections:90]InspType:5#"TOT"; *)
		QUERY SELECTION:C341([Combined Inspections:90];  & ; [Combined Inspections:90]InspType:5#"TSP")
	: (INSP_Inspection_list_txt="TUNNEL")
		QUERY SELECTION:C341([Combined Inspections:90]; [Combined Inspections:90]InspType:5="TAL"; *)
		QUERY SELECTION:C341([Combined Inspections:90];  | ; [Combined Inspections:90]InspType:5="TOV"; *)
		QUERY SELECTION:C341([Combined Inspections:90];  | ; [Combined Inspections:90]InspType:5="TDA"; *)
		QUERY SELECTION:C341([Combined Inspections:90];  | ; [Combined Inspections:90]InspType:5="TOT"; *)
		QUERY SELECTION:C341([Combined Inspections:90];  | ; [Combined Inspections:90]InspType:5="TSP")
End case 

ORDER BY:C49([Combined Inspections:90]; [Combined Inspections:90]InspDate:4; <)
UNLOAD RECORD:C212([Combined Inspections:90])
UNLOAD RECORD:C212([Inspections:27])
UNLOAD RECORD:C212([BMS Inspections:44])
vbInspRefresh:=False:C215  //mark this to not refresh inspection list
//we need to refresh inspection list
COPY NAMED SELECTION:C331([Combined Inspections:90]; "curCombinedInspection")
GOTO SELECTED RECORD:C245([Combined Inspections:90]; 0)