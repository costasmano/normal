//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/10/05, 20:16:58
	// ----------------------------------------------------
	// Method: CreateRandomSetForPontisElmt
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CM17
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
End if 

C_TEXT:C284($s)  // Command Replaced was o_C_STRING length was 30
If ((vAddTo=True:C214) & (Records in set:C195("Random Set")=0))
	CREATE SET:C116([Bridge MHD NBIS:1]; "Random Set")
End if 
If ((Records in set:C195("TotalElmtsFound")=0))
	CREATE SET:C116([Cond Units:45]; "TotalElmtsFound")
End if 

OBJECT SET ENABLED:C1123(bFind; False:C215)  // Command Replaced was o_DISABLE BUTTON 
SHORT_MESSAGE("Searching…")
If (vAddTo)
	USE NAMED SELECTION:C332("UserRegionA")
Else 
	USE NAMED SELECTION:C332("StartSearch")
End if 

ARRAY TEXT:C222($asInspBIN; 0)  //Command Replaced was o_ARRAY string length was 5
RELATE MANY SELECTION:C340([Inspections:27]BIN:1)

Case of 
	: (vbAnyCompleted)
		QUERY SELECTION:C341([Inspections:27]; [Inspections:27]InspComplete:168=True:C214)
	: (vbAnyApprvDBIE)
		QUERY SELECTION:C341([Inspections:27]; [Inspections:27]InspReviewed:12=BMS Approved)
	: (vInspApproved)
		QUERY SELECTION:C341([Inspections:27]; [Inspections:27]InspApproved:167=BMS Approved)
End case 
RELATE MANY SELECTION:C340([Combined Inspections:90]NBISInspID:2)
RELATE ONE SELECTION:C349([Combined Inspections:90]; [BMS Inspections:44])
If (False:C215)
	ARRAY LONGINT:C221($arInspIDs; 0)
	ARRAY LONGINT:C221($arCombIDs; 0)
	ARRAY LONGINT:C221($arBMSIDs; 0)
	SELECTION TO ARRAY:C260([Inspections:27]InspID:2; $arInspIDs)
	QUERY WITH ARRAY:C644([Combined Inspections:90]NBISInspID:2; $arInspIDs)
	SELECTION TO ARRAY:C260([Combined Inspections:90]BMSInspID:3; $arBMSIDs)
	QUERY WITH ARRAY:C644([BMS Inspections:44]Inspection ID:1; $arBMSIDs)
End if 

ORDER BY:C49([BMS Inspections:44]; [BMS Inspections:44]BIN:2; >; [BMS Inspections:44]Insp Date:4; <)
CREATE SET:C116([BMS Inspections:44]; "SetInspectionStart")
C_TEXT:C284($StartBIN)  // Command Replaced was o_C_STRING length was 3
GOTO SELECTED RECORD:C245([BMS Inspections:44]; 1)
$StartBIN:=[BMS Inspections:44]BIN:2
C_LONGINT:C283($i)
For ($i; 2; Records in selection:C76([BMS Inspections:44]))
	GOTO SELECTED RECORD:C245([BMS Inspections:44]; $i)
	If ([BMS Inspections:44]BIN:2=$StartBIN)
		//remove from list
		REMOVE FROM SET:C561([BMS Inspections:44]; "SetInspectionStart")
	Else 
		$StartBIN:=[BMS Inspections:44]BIN:2
	End if 
	
End for 

USE SET:C118("SetInspectionStart")
CLEAR SET:C117("SetInspectionStart")

RELATE MANY SELECTION:C340([Cond Units:45]Inspection ID:2)

G_PontisElmtQuery

CLOSE WINDOW:C154
OBJECT SET ENABLED:C1123(bFind; True:C214)  // Command Replaced was o_ENABLE BUTTON 
CREATE SET:C116([Cond Units:45]; "ElmtsFoundThisTime")
If (Records in set:C195("TotalElmtsFound")=0)
	If (vAddTo=False:C215)
		CREATE EMPTY SET:C140([Cond Units:45]; "TotalElmtsFound")
	End if 
End if 
UNION:C120("TotalElmtsFound"; "ElmtsFoundThisTime"; "TotalElmtsFound")
CLEAR SET:C117("ElmtsFoundThisTime")

RELATE ONE SELECTION:C349([Cond Units:45]; [BMS Inspections:44])
RELATE ONE SELECTION:C349([BMS Inspections:44]; [Bridge MHD NBIS:1])

CREATE SET:C116([Bridge MHD NBIS:1]; "Found Bridge Recs Set")
If (Records in set:C195("Random Set")=0)
	If (vAddTo=False:C215)
		CREATE EMPTY SET:C140([Bridge MHD NBIS:1]; "Random Set")
	End if 
End if 
UNION:C120("Random Set"; "Found Bridge Recs Set"; "Random Set")
CLEAR SET:C117("Found Bridge Recs Set")