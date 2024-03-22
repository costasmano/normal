//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/16/09, 20:41:40
	// ----------------------------------------------------
	// Method: Method: Print_Freeze_pg1
	// Description
	// 
	// 
	// Parameters
	// $0 : $NumPages
	// $1 : PrintFlag
	// ----------------------------------------------------
	If (False:C215)
		DIALOG:C40([Inspections:27]; "FrzThawPg1")
	End if 
	
	Mods_2009_CM_5404  // --- "FREEZETHAW"
	
	// Modified by: costasmanousakis-(Designer)-(4/9/09 19:26:19)
	Mods_2009_04
	//  `When running the method with PrintFlag=False (ie checking page numbers), direct the print output to
	//  `a temp file and then delete the file. Avoids blank pages.
	
	// Modified by: costasmanousakis-(Designer)-(4/29/09 19:26:19)
	Mods_2009_04
	//  `Fixed the SET PRINT OPTION(Destination option ;2;$tempFile_txt) - used to have option 3
	//  `which worked on a MAC, but gave errors when trying to delete the temp file on a PC.
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
	// Modified by: Costas Manousakis-(Designer)-(2/18/14 13:41:38)
	Mods_2014_02
	//  `New Freeze thaw
	// Modified by: Costas Manousakis-(Designer)-(6/17/14 16:20:47)
	Mods_2014_06_bug
	//  `Added code to print the Orientation text if it does not fit on page 1
	
End if 
C_BOOLEAN:C305(PrintFlag)
C_LONGINT:C283($0; $NumPages)
If (Count parameters:C259>0)
	C_BOOLEAN:C305($1)
	PrintFlag:=$1
Else 
	PrintFlag:=True:C214
End if 

G_Insp_RelateInsp(->[ElementsSafety:29]InspID:4)

ARRAY BOOLEAN:C223(FRZ_CommentsFit_b; 8)  //2 for each of the freeze thaw items

C_LONGINT:C283($recnum; $i; $numGrps; $j; $k; $viElmtsPerPage; $viElmtsPerPage2)  //Command Replaced was o_C_INTEGER
C_TEXT:C284($vsInspFormName; $vsInspFormName2)  // Command Replaced was o_C_STRING length was 40
C_LONGINT:C283(vPageno)  //Command Replaced was o_C_INTEGER
//Sort by element no.
FRZ_OrientationOnPg1_b:=True:C214
If ([Inspections:27]Insp Date:78<<>InspFormRevDate_7)
	$vsInspFormName:="FrzThawPg1"
Else 
	$vsInspFormName:="FrzThawPg1A"
End if 
ORDER BY:C49([ElementsSafety:29]; [ElementsSafety:29]ElementNo:1; >)
ARRAY LONGINT:C221($alAllElmts; 0)
C_LONGINT:C283($lElmtRecIDNum; $Loop)
vPageNo:=1
If (Not:C34(INSP_CreatePDFsofApproved_B))
	If (Not:C34(PrintFlag))
		C_TEXT:C284($tempFile_txt)
		$tempFile_txt:=Temporary folder:C486+"FRZ_"+ut_CreateTimeStamp+".tmp"
		C_LONGINT:C283($spo_L)
		C_BOOLEAN:C305($PrntPrv_b)
		$PrntPrv_b:=Get print preview:C1197
		If ($PrntPrv_b)
			SET PRINT PREVIEW:C364(False:C215)
		End if 
		GET PRINT OPTION:C734(Mac spool file format option:K47:11; $spo_L)
		SET PRINT OPTION:C733(Destination option:K47:7; 2; $tempFile_txt)
		SET PRINT OPTION:C733(Mac spool file format option:K47:11; 1)  //set to ps
		PAGE BREAK:C6
	End if 
End if 
$lElmtRecIDNum:=Print form:C5([Inspections:27]; $vsInspFormName)
If (Not:C34(INSP_CreatePDFsofApproved_B))
	If (Not:C34(PrintFlag))
		PAGE BREAK:C6
		SET PRINT OPTION:C733(Destination option:K47:7; 1; "")
		DELETE DOCUMENT:C159($tempFile_txt)
	End if 
End if 
//now see if everything  fit
C_BOOLEAN:C305($AllFit_b)
$AllFit_b:=False:C215 | Not:C34(FRZ_OrientationOnPg1_b)
For ($Loop; 1; Size of array:C274(FRZ_CommentsFit_b))
	$AllFit_b:=$AllFit_b | FRZ_CommentsFit_b{$Loop}
End for 
If ($AllFit_b)
	$NumPages:=INSP_FRZ_PrintCmts_WP(PrintFlag)+1
	
Else 
	$NumPages:=1
End if 

$0:=$NumPages