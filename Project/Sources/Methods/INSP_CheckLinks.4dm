//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/16/05, 14:27:02
	// ----------------------------------------------------
	// Method: INSP_CheckLinks
	// Description
	// Check the links to the related inspection records, and
	// load them if necessary
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CM20
	// Modified by: costasmanousakis-(Designer)-(6/30/06 12:36:04)
	Mods_2006_CM05
	// Modified by: costasmanousakis-(Designer)-(1/26/2007 10:28:53)
	Mods_2007_CM05a
End if 
C_POINTER:C301($Errorpointer_ptr)
If (Count parameters:C259>0)
	C_POINTER:C301($1)
	$Errorpointer_ptr:=$1
End if 


C_BOOLEAN:C305($vCorrectLinks_B)
C_TEXT:C284($msg)

If (Not:C34(Is record loaded:C669([Combined Inspections:90])))
	Case of 
		: (Records in selection:C76([Combined Inspections:90])=1)
			GOTO SELECTED RECORD:C245([Combined Inspections:90]; 1)
		: (Records in selection:C76([Combined Inspections:90])#1)
			QUERY:C277([Combined Inspections:90]; [Combined Inspections:90]NBISInspID:2=[Inspections:27]InspID:2)
			GOTO SELECTED RECORD:C245([Combined Inspections:90]; 1)
	End case 
End if 
$vCorrectLinks_B:=True:C214
If ([Combined Inspections:90]NBISInspID:2#[Inspections:27]InspID:2)
	$vCorrectLinks_B:=False:C215
	$msg:="Database Link Error 1 in current inspection! [NBI_ID_MISMATCH]"
	$msg:=$msg+Char:C90(13)+"Please Cancel Edits,  Exit the inspection and then try to re-open it!"
	$msg:=$msg+Char:C90(13)+"If the problem persists please contact the database administrator!"
	ALERT:C41($msg)
End if 
If (([Combined Inspections:90]NBISInspID:2=[Inspections:27]InspID:2) & ([Combined Inspections:90]BIN:1#[Inspections:27]BIN:1))
	$vCorrectLinks_B:=False:C215
	$msg:="Database Link Error 3 in current inspection! [NBI_BIN_MISMATCH]"
	$msg:=$msg+Char:C90(13)+"Please Cancel Edits,  Exit the inspection and then try to re-open it!"
	$msg:=$msg+Char:C90(13)+"If the problem persists please contact the database administrator!"
	ALERT:C41($msg)
End if 

If ($vCorrectLinks_B)
	If ([Combined Inspections:90]BMSInspID:3>0)
		If (Not:C34(Is record loaded:C669([BMS Inspections:44])))
			Case of 
				: (Records in selection:C76([BMS Inspections:44])=1)
					GOTO SELECTED RECORD:C245([BMS Inspections:44]; 1)
				: (Records in selection:C76([BMS Inspections:44])#1)
					QUERY:C277([BMS Inspections:44]; [BMS Inspections:44]Inspection ID:1=[Combined Inspections:90]BMSInspID:3)
					GOTO SELECTED RECORD:C245([BMS Inspections:44]; 1)
			End case 
		End if 
		If ([BMS Inspections:44]Inspection ID:1=0)  // Modified by: costasmanousakis-(Designer)-(6/30/06 12:28:10)
			QUERY:C277([BMS Inspections:44]; [BMS Inspections:44]Inspection ID:1=[Combined Inspections:90]BMSInspID:3)
			GOTO SELECTED RECORD:C245([BMS Inspections:44]; 1)
		End if 
		
		If ([Combined Inspections:90]BMSInspID:3#[BMS Inspections:44]Inspection ID:1)
			$vCorrectLinks_B:=False:C215
			$msg:="Database Link Error 2 in current inspection! [BMS_ID_MISMATCH]"
			$msg:=$msg+Char:C90(13)+"Please Cancel Edits,  Exit the inspection and then try to re-open it!"
			$msg:=$msg+Char:C90(13)+"If the problem persists please contact the database administrator!"
			ALERT:C41($msg)
		End if 
		If (([Combined Inspections:90]BMSInspID:3=[BMS Inspections:44]Inspection ID:1) & ([Combined Inspections:90]BIN:1#[BMS Inspections:44]BIN:2))
			$vCorrectLinks_B:=False:C215
			$msg:="Database Link Error 4 in current inspection! [BMS_BIN_MISMATCH]"
			$msg:=$msg+Char:C90(13)+"Please Cancel Edits,  Exit the inspection and then try to re-open it!"
			$msg:=$msg+Char:C90(13)+"If the problem persists please contact the database administrator!"
			ALERT:C41($msg)
		End if 
	End if 
End if 
If ([Bridge MHD NBIS:1]BIN:3="")  // Modified by: costasmanousakis-(Designer)-(6/30/06 12:28:01)
	RELATE ONE:C42([Combined Inspections:90]BIN:1)
End if 
If (Count parameters:C259>0)
	C_POINTER:C301($1)
	$1->:=$vCorrectLinks_B
End if 

$msg:=""