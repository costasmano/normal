//%attributes = {"invisible":true}
//Method: CreateRandomSetForNBEElmt
//Description
// Create a bridge set from NBE element search
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 07/6/15, 13:58:02
	// ----------------------------------------------------
	//Created : 
	Mods_2015_07
	// Modified by: Costas Manousakis-(Designer)-(4/10/17 17:09:47)
	Mods_2017_04
	//  `progress bar
End if 
//
C_BOOLEAN:C305($one_b; $many_b)
GET AUTOMATIC RELATIONS:C899($one_b; $many_b)
SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)

C_TEXT:C284($s)  // Command Replaced was o_C_STRING length was 30
If ((vAddTo=True:C214) & (Records in set:C195("Random Set")=0))
	CREATE SET:C116([Bridge MHD NBIS:1]; "Random Set")
End if 
If ((Records in set:C195("TotalElmtsFound")=0))
	CREATE SET:C116([PON_ELEM_INSP:179]; "TotalElmtsFound")
End if 

OBJECT SET ENABLED:C1123(bFind; False:C215)  // Command Replaced was o_DISABLE BUTTON 
C_LONGINT:C283($progressBar_L)
$progressBar_L:=Progress New
Progress SET TITLE($progressBar_L; "Searching for Inspections")
Progress SET BUTTON ENABLED($progressBar_L; False:C215)

//SHORT_MESSAGE ("Searching…")
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

QUERY SELECTION:C341([Inspections:27]; [PON_ELEM_INSP:179]ELEMID:22>0)  // find inspections with NBEs

Progress SET MESSAGE($progressBar_L; "Sorting..")
ORDER BY:C49([Inspections:27]; [Inspections:27]BIN:1; >; [Inspections:27]Insp Date:78; <)
CREATE SET:C116([Inspections:27]; "SetInspectionStart")
RELATE MANY SELECTION:C340([PON_ELEM_INSP:179]INSPID:21)
C_TEXT:C284($StartBIN)  // Command Replaced was o_C_STRING length was 3
GOTO SELECTED RECORD:C245([Inspections:27]; 1)
$StartBIN:=[Inspections:27]BIN:1
C_LONGINT:C283($i)
For ($i; 2; Records in selection:C76([Inspections:27]))
	GOTO SELECTED RECORD:C245([Inspections:27]; $i)
	If ([Inspections:27]BIN:1=$StartBIN)
		//remove from list
		REMOVE FROM SET:C561([Inspections:27]; "SetInspectionStart")
	Else 
		$StartBIN:=[Inspections:27]BIN:1
	End if 
	
End for 

USE SET:C118("SetInspectionStart")
CLEAR SET:C117("SetInspectionStart")
RELATE MANY SELECTION:C340([PON_ELEM_INSP:179]INSPID:21)

//QR REPORT([PON_ELEM_INSP];Char(1))

G_NBEElmtQuery

//CLOSE WINDOW
Progress QUIT($progressBar_L)

OBJECT SET ENABLED:C1123(bFind; True:C214)  // Command Replaced was o_ENABLE BUTTON 
CREATE SET:C116([PON_ELEM_INSP:179]; "ElmtsFoundThisTime")
If (Records in set:C195("TotalElmtsFound")=0)
	If (vAddTo=False:C215)
		CREATE EMPTY SET:C140([PON_ELEM_INSP:179]; "TotalElmtsFound")
	End if 
End if 
UNION:C120("TotalElmtsFound"; "ElmtsFoundThisTime"; "TotalElmtsFound")
CLEAR SET:C117("ElmtsFoundThisTime")

RELATE ONE SELECTION:C349([PON_ELEM_INSP:179]; [Inspections:27])
RELATE ONE SELECTION:C349([Inspections:27]; [Bridge MHD NBIS:1])

CREATE SET:C116([Bridge MHD NBIS:1]; "Found Bridge Recs Set")
If (Records in set:C195("Random Set")=0)
	If (vAddTo=False:C215)
		CREATE EMPTY SET:C140([Bridge MHD NBIS:1]; "Random Set")
	End if 
End if 
UNION:C120("Random Set"; "Found Bridge Recs Set"; "Random Set")
CLEAR SET:C117("Found Bridge Recs Set")
SET AUTOMATIC RELATIONS:C310($one_b; $many_b)
//End CreateRandomSetForNBEElmt