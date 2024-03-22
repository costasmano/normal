//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_ControlFieldReset
// User name (OS): cjmiller
// Date and time: 12/03/03, 12:34:40
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2005_CJM03  //04/19/05, 13:38:17
	// Modified by: costasmanousakis-(Designer)-(10/9/2007 08:06:18)
	Mods_2007_CM12_5301  //Use open form window for dialog.  Load array aFilesToBeFixed - aFilesToBeSkipped is handled by dialog.
	// Modified by: costasmanousakis-(Designer)-(3/5/09 09:05:35)
	Mods_2009_CM_5404
	//Moved the declaration of array $aSkippedFileNums so that it is always declared
	// fixed a bug in the message where table name was called.
	//added case to drop indexes for all tables, not for all, or go by table
	Mods_2009_03  //CJM  r001   `03/06/09, 14:31:04`Upgrade from open form window to open window
End if 
C_LONGINT:C283($iNoFiles; $iTableLoop; $iFieldLoop; $iRecordLoop; $iSkipPos; $iPos; $iError)  //Command Replaced was o_C_INTEGER//Mods_2002_01_09
C_POINTER:C301($pTable; $pField)
C_TEXT:C284($format; $sString; $KeyField)
$iNoFiles:=Get last table number:C254

Case of 
	: ($iNoFiles<10)
		$format:="0"
	: ($iNoFiles<100)
		$format:="00"
	Else 
		$format:="000"
End case 

ARRAY TEXT:C222(aFilesToBeSkipped; 0)
ARRAY TEXT:C222(aFilesToBeFixed; $iNoFiles)
//lets get a display of files
C_LONGINT:C283($NoRecords_l)
C_POINTER:C301($Table_ptr)
For ($iTableLoop; 1; $iNoFiles)
	$Table_ptr:=Table:C252($iTableLoop)
	$NoRecords_l:=Records in table:C83($Table_ptr->)
	aFilesToBeFixed{$iTableLoop}:=String:C10($iTableLoop; $Format)+" - "+Table name:C256($iTableLoop)+" ("+String:C10($NoRecords_l)+")"
End for 
C_LONGINT:C283($ApplicationType_l)
$ApplicationType_l:=-1
$ApplicationType_l:=Application type:C494
TRACE:C157

//$win:=Open window(50;50;600;510;5;"Select Tables to be Excluded")

C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
C_TEXT:C284($Title_txt)
FORM GET PROPERTIES:C674([zDialogs:68]; "ResetDialog"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10; $Title_txt; "ut_CloseCancel")
//$win:=Open form window([zDialogs];"ResetDialog")

DIALOG:C40([zDialogs:68]; "ResetDialog")
CLOSE WINDOW:C154($Win_l)
If (OK=1)
	
	C_LONGINT:C283($indexChoise_i)  //Command Replaced was o_C_INTEGER
	$indexChoise_i:=ut_3Option_Confirm("Drop indexes for all tables, dont'drop, or by table?"; "All"; "None"; "ByTable")
	
	ARRAY LONGINT:C221($aSkippedFileNums; Size of array:C274(aFilesToBeSkipped))
	C_LONGINT:C283($i)
	If (Size of array:C274(aFilesToBeSkipped)>0)
		For ($i; 1; Size of array:C274(aFilesToBeSkipped))
			$iPos:=Position:C15("-"; aFilesToBeSkipped{$i})
			$sString:=Substring:C12(aFilesToBeSkipped{$i}; 1; $iPos-2)
			$aSkippedFileNums{$i}:=Num:C11($sString)
		End for 
		SORT ARRAY:C229($aSkippedFileNums; >)
	End if 
	C_TEXT:C284($TableName_txt)
	C_BOOLEAN:C305($DropIndices_b)
	C_LONGINT:C283($ProcessID)
	For ($iTableLoop; 1; $iNoFiles)
		$TableName_txt:=Table name:C256($iTableLoop)
		$iSkipPos:=Find in array:C230($aSkippedFileNums; $iTableLoop)
		
		If ($iSkipPos>0)
		Else 
			Case of 
				: ($indexChoise_i=1)
					$DropIndices_b:=True:C214
				: ($indexChoise_i=2)
					$DropIndices_b:=False:C215
				: ($indexChoise_i=3)
					CONFIRM:C162("Do you wish to drop indices for table "+$TableName_txt+" first?")
					$Table_ptr:=Table:C252($iTableLoop)
					If (OK=1)
						$DropIndices_b:=True:C214
					Else 
						$DropIndices_b:=False:C215
					End if 
					
			End case 
			$NoRecords_l:=Records in table:C83($Table_ptr->)
			
			If ($NoRecords_l>100000)
				CONFIRM:C162("There are "+String:C10($NoRecords_l)+" records for table "+Table name:C256($Table_ptr))
				If (OK=1)
					If ($ApplicationType_l=4D Remote mode:K5:5)
						$ProcessID:=Execute on server:C373("ut_FixTableProcess"; 0; "Updating Table number "+String:C10($iTableLoop); $iTableLoop; $DropIndices_b)
					Else 
						$ProcessID:=New process:C317("ut_FixTableProcess"; 0; "Updating Table number "+String:C10($iTableLoop); $iTableLoop; $DropIndices_b)
					End if 
				End if 
			Else 
				
				
				If ($ApplicationType_l=4D Remote mode:K5:5)
					$ProcessID:=Execute on server:C373("ut_FixTableProcess"; 0; "Updating Table number "+String:C10($iTableLoop); $iTableLoop; $DropIndices_b)
				Else 
					$ProcessID:=New process:C317("ut_FixTableProcess"; 0; "Updating Table number "+String:C10($iTableLoop); $iTableLoop; $DropIndices_b)
				End if 
			End if 
		End if 
		
	End for 
End if 

//End ut_ControlFieldReset