//%attributes = {"invisible":true}
If (False:C215)
	
	//PM RememberCombined
	//Created: 2004/07/22
	//by: Albert Leung
	//Purpose: Bring back the current combined record and relations
	
	// Modified by: costasmanousakis-(Designer)-(12/16/2005 11:26:53)
	Mods_2005_CM20
End if 
C_LONGINT:C283($viListNum)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(vCurrentPontisID_L; vCurrentCombID_L)
If (False:C215)
	USE NAMED SELECTION:C332("curCombinedInspection")
	RELATE ONE:C42([Combined Inspections:90]NBISInspID:2)
	RELATE ONE:C42([Combined Inspections:90]BMSInspID:3)
	//The following is substitute for the above two - neither in use
	QUERY:C277([Combined Inspections:90]; [Combined Inspections:90]NBISInspID:2=[Inspections:27]InspID:2)
	QUERY:C277([BMS Inspections:44]; [BMS Inspections:44]Inspection ID:1=[Combined Inspections:90]BMSInspID:3)
End if 

INSP_CheckLinks

//2005-02-10 ASL Added this to fix Pontis printing
DISPL_CUs
vCurrentPontisID_L:=[BMS Inspections:44]Inspection ID:1
vCurrentCombID_L:=[Combined Inspections:90]ID:6