//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_FindInspectionDuplicates
// User name (OS): cjmiller
// Date and time: 02/22/05, 10:10:04
// ----------------------------------------------------
// Description
// This method will find potential instepction  duplicates using the following rul
//1 [Bridge MHD NBIS]FHWARecord = true and
//[Bridge MHD NBIS] InspResp ="DIST@"
//2 [BMS Inspections]Insp Date > 12/31/97
//3 > 1 [BMS Inspections] record
//4 [BMS Inspections]Insp Date within 15 days of another [BMS Inspections]
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2011_06  // CJ Miller`06/14/11, 10:48:04      ` Type all local variables for v11
End if 

ARRAY TEXT:C222($Report_atxt; 1)
C_LONGINT:C283($Loop_l; $InnerLoop_l; $ReportLoop_l)
C_DATE:C307($TestDate_d)

QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]InspResp:173="DIST@")
QUERY SELECTION:C341([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]FHWARecord:174=True:C214)
//_O_PLATFORM PROPERTIES($Platform_l)// MassDOT_PS - conversion v19R7
C_TEXT:C284($EOL_txt; $District_txt)
If (Is Windows:C1573)
	$Eol_txt:=Char:C90(13)+Char:C90(10)
Else 
	$Eol_txt:=Char:C90(13)
End if 
ORDER BY:C49([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]InspResp:173; >)
$Report_atxt{1}:=""
$District_txt:=""
For ($Loop_l; 1; Records in selection:C76([Bridge MHD NBIS:1]))
	GOTO SELECTED RECORD:C245([Bridge MHD NBIS:1]; $Loop_l)
	QUERY:C277([BMS Inspections:44]; [BMS Inspections:44]BIN:2=[Bridge MHD NBIS:1]BIN:3; *)
	QUERY:C277([BMS Inspections:44];  & ; [BMS Inspections:44]Insp Date:4>!1997-12-31!)
	C_TIME:C306($Doc)
	C_TEXT:C284($Document_txt)
	If ($District_txt#[Bridge MHD NBIS:1]InspResp:173)
		If ($District_txt="")
			$District_txt:=[Bridge MHD NBIS:1]InspResp:173
		Else 
			If (Is Windows:C1573)
				$Doc:=Create document:C266("Dup_Insp_"+$District_txt; "txt")
			Else 
				$Doc:=Create document:C266("Dup_Insp_"+$District_txt)
			End if 
			For ($ReportLoop_l; Size of array:C274($Report_atxt); 1; -1)
				SEND PACKET:C103($Doc; $Report_atxt{$ReportLoop_l})
			End for 
			ARRAY TEXT:C222($Report_atxt; 0)
			ARRAY TEXT:C222($Report_atxt; 1)
			
			$Document_txt:=Document
			CLOSE DOCUMENT:C267($Doc)
			If (Is Windows:C1573)
				
			Else 
				//_ O _SET DOCUMENT TYPE($Document_txt;"TEXT")
				//_ O _SET DOCUMENT CREATOR($Document_txt;"ttxt")
			End if 
			
		End if 
		$District_txt:=[Bridge MHD NBIS:1]InspResp:173
	End if 
	If (Records in selection:C76([BMS Inspections:44])>1)
		ORDER BY:C49([BMS Inspections:44]; [BMS Inspections:44]Insp Date:4; >)
		ARRAY LONGINT:C221($RecordNumbers_al; 0)
		ARRAY DATE:C224($InspDate_ad; 0)
		ARRAY LONGINT:C221($DuplicateRecord_al; 0)
		SELECTION TO ARRAY:C260([BMS Inspections:44]; $RecordNumbers_al; [BMS Inspections:44]Insp Date:4; $InspDate_ad)
		For ($InnerLoop_l; 1; Size of array:C274($InspDate_ad)-1)
			$TestDate_d:=$InspDate_ad{$InnerLoop_l}+14
			If ($InspDate_ad{$InnerLoop_l+1}<$TestDate_d)
				INSERT IN ARRAY:C227($DuplicateRecord_al; 1; 2)
				$DuplicateRecord_al{1}:=$RecordNumbers_al{$InnerLoop_l}
				$DuplicateRecord_al{2}:=$RecordNumbers_al{$InnerLoop_l+1}
			End if 
		End for 
		If (Size of array:C274($DuplicateRecord_al)>0)
			For ($InnerLoop_l; 1; Size of array:C274($DuplicateRecord_al)-1; 2)
				
				GOTO RECORD:C242([BMS Inspections:44]; $DuplicateRecord_al{$InnerLoop_l})
				If (Length:C16($Report_atxt{1})>25000)
					INSERT IN ARRAY:C227($Report_atxt; 1; 1)
				End if 
				$Report_atxt{1}:=$Report_atxt{1}+[Bridge MHD NBIS:1]InspResp:173+Char:C90(9)+[BMS Inspections:44]BIN:2+Char:C90(9)+String:C10([BMS Inspections:44]Insp Date:4; 7)+Char:C90(9)
				
				GOTO RECORD:C242([BMS Inspections:44]; $DuplicateRecord_al{$InnerLoop_l+1})
				$Report_atxt{1}:=$Report_atxt{1}+String:C10([BMS Inspections:44]Insp Date:4; 7)+$EOL_txt
				
			End for 
		End if 
	End if 
	
End for 
If (Is Windows:C1573)
	$Doc:=Create document:C266("Dup_Insp_"+$District_txt; "txt")
Else 
	$Doc:=Create document:C266("Dup_Insp_"+$District_txt)
End if 
For ($Loop_l; Size of array:C274($Report_atxt); 1; -1)
	SEND PACKET:C103($Doc; $Report_atxt{$Loop_l})
	
End for 
$Document_txt:=Document
CLOSE DOCUMENT:C267($Doc)
If (Is Windows:C1573)
	
Else 
	//_ O _SET DOCUMENT TYPE($Document_txt;"TEXT")
	//_ O _SET DOCUMENT CREATOR($Document_txt;"ttxt")
End if 


//End ut_FindInspectionDuplicates