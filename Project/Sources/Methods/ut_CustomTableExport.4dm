//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/16/07, 20:25:24
	// ----------------------------------------------------
	// Method: Method: ut_CustomTableExport 
	// Description
	// ` Export a table to a file using SEND RECORD. Output file can be used by
	//  ` method ut_CustomTableLoad.  It allows exporting tables that are hidden
	//  ` and cannot be accessed from user mode. The export file contains tags that 
	//  ` identify the table number, the key field and number of records.
	//  ` At the end of each table export, more exports can be performed. 
	// 
	// Parameters
	// ----------------------------------------------------
	//See method ut_CustomTableLoad
	Mods_2007_CM04
	// Modified by: costasmanousakis-(Designer)-(5/21/2007 09:22:44)
	Mods_2007_CM10
	// Modified by: costasmanousakis-(Designer)-(11/7/2007 10:10:48)
	Mods_2007_CM12_5302
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v11
End if 
C_POINTER:C301($TargetTable_ptr; $TableIndexfld_ptr)
C_LONGINT:C283($numrecs_L; $i)
C_LONGINT:C283($SelectedFld_L; $TableNum_L; $UserOpt)
C_BOOLEAN:C305($DoneExporting_b)
$DoneExporting_b:=False:C215
Repeat 
	
	$TableNum_L:=ut_SelectTableNum
	If ($TableNum_L>0)
		
		$SelectedFld_L:=ut_SelectFieldNum($TableNum_L)
		//must have a key.....???
		If ($SelectedFld_L>0)
			$TargetTable_ptr:=Table:C252($TableNum_L)
			READ ONLY:C145($TargetTable_ptr->)
			$UserOpt:=ut_3Option_Confirm("Do all records or current selection?"; "ALL"; "Current"; "Custom")
			Case of 
				: ($UserOpt=1)
					ALL RECORDS:C47($TargetTable_ptr->)
				: ($UserOpt=3)
					QUERY:C277($TargetTable_ptr->)
			End case 
			If (Records in selection:C76($TargetTable_ptr->)>0)
				//start the export file
				SHORT_MESSAGE("Exporting "+Table name:C256($TableNum_L)+"..")
				SET TEXT TO PASTEBOARD:C523(Table name:C256($TableNum_L))
				SET CHANNEL:C77(12; "")  //choose the file
				C_TEXT:C284($vTag_txt)
				$vTag_txt:="MHDBMSTABLEEXPORT"
				C_LONGINT:C283($KeyFieldNum_L; $NumTableRecs_L)
				SEND VARIABLE:C80($vTag_txt)
				SEND VARIABLE:C80($TableNum_L)
				SEND VARIABLE:C80($SelectedFld_L)
				$NumTableRecs_L:=Records in selection:C76($TargetTable_ptr->)
				SEND VARIABLE:C80($NumTableRecs_L)
				//loop
				FIRST RECORD:C50($TargetTable_ptr->)
				For ($i; 1; $NumTableRecs_L)
					SEND RECORD:C78($TargetTable_ptr->)
					NEXT RECORD:C51($TargetTable_ptr->)
				End for 
				READ WRITE:C146($TargetTable_ptr->)
				//close the export file
				SET CHANNEL:C77(11)
				CLOSE WINDOW:C154
				ALERT:C41("Done exporting "+Table name:C256($TableNum_L)+"...")
				
			Else 
				ALERT:C41("No Selected records for table "+Table name:C256($TableNum_L))
			End if 
			
		End if 
		CONFIRM:C162("Try Exporting Another table?"; "OneMore"; "Done")
		If (OK=1)
		Else 
			$DoneExporting_b:=True:C214
		End if 
		
	Else 
		$DoneExporting_b:=True:C214
	End if 
Until ($DoneExporting_b)