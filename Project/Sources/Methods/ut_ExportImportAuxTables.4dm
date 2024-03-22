//%attributes = {"invisible":true}
// Method: ut_ExportImportAuxTables
// Description
// Export or import Auxiliary tables used to load pulldown menus
// invarious parts of the application. Can be used to unload from the main
// DB the needed info and then load it to a new blank db.
// 
// Parameters
// $1 : $Task_txt ("EXPORT" | "IMPORT")
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/09/08, 10:02:51
	// ----------------------------------------------------
	
	Mods_2008_CM_5404  // ("AUXTABLEEXPORT")
	// Modified by: costasmanousakis-(Designer)-(5/15/09 11:16:45)
	Mods_2009_05
	// Modified by: costasmanousakis-(Designer)-(6/16/09 15:53:50)
	Mods_2009_06
	// Modified by: costasmanousakis-(Designer)-(5/26/11 17:35:29)
	Mods_2011_05  //
	//  `Added Templates and zSpecialReports, TableofLists to the list of tables
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
	// Modified by: costasmanousakis-(Designer)-(10/20/11 08:09:41)
	Mods_2011_10
	//  `When opening an import file ON ERR CALL ut_ChannelOpenError
End if 
C_TEXT:C284($Task_txt)
If (Count parameters:C259>0)
	C_TEXT:C284($1)
	$Task_txt:=$1
Else 
	CONFIRM:C162("Do an Export or Import?"; "Export"; "Import")
	If (OK=1)
		$Task_txt:="EXPORT"
	Else 
		$Task_txt:="IMPORT"
	End if 
End if 

ARRAY POINTER:C280($AuxTables_ptr; 0)
C_LONGINT:C283($i; $NumTables_L)
$NumTables_L:=0
$NumTables_L:=$NumTables_L+1
INSERT IN ARRAY:C227($AuxTables_ptr; $NumTables_L)
$AuxTables_ptr{$NumTables_L}:=->[Bed Material:39]
$NumTables_L:=$NumTables_L+1
INSERT IN ARRAY:C227($AuxTables_ptr; $NumTables_L)
$AuxTables_ptr{$NumTables_L}:=->[Deck Protection:17]
$NumTables_L:=$NumTables_L+1
INSERT IN ARRAY:C227($AuxTables_ptr; $NumTables_L)
$AuxTables_ptr{$NumTables_L}:=->[Deck Structure:14]
$NumTables_L:=$NumTables_L+1
INSERT IN ARRAY:C227($AuxTables_ptr; $NumTables_L)
$AuxTables_ptr{$NumTables_L}:=->[Design:11]
$NumTables_L:=$NumTables_L+1
INSERT IN ARRAY:C227($AuxTables_ptr; $NumTables_L)
$AuxTables_ptr{$NumTables_L}:=->[Design Load:6]
$NumTables_L:=$NumTables_L+1
INSERT IN ARRAY:C227($AuxTables_ptr; $NumTables_L)
$AuxTables_ptr{$NumTables_L}:=->[Direction:13]
$NumTables_L:=$NumTables_L+1
INSERT IN ARRAY:C227($AuxTables_ptr; $NumTables_L)
$AuxTables_ptr{$NumTables_L}:=->[Foundation Type:38]
$NumTables_L:=$NumTables_L+1
INSERT IN ARRAY:C227($AuxTables_ptr; $NumTables_L)
$AuxTables_ptr{$NumTables_L}:=->[FunctionalClass:5]
$NumTables_L:=$NumTables_L+1
INSERT IN ARRAY:C227($AuxTables_ptr; $NumTables_L)
$AuxTables_ptr{$NumTables_L}:=->[HistSig:25]
$NumTables_L:=$NumTables_L+1
INSERT IN ARRAY:C227($AuxTables_ptr; $NumTables_L)
$AuxTables_ptr{$NumTables_L}:=->[Insp Resp:20]
$NumTables_L:=$NumTables_L+1
INSERT IN ARRAY:C227($AuxTables_ptr; $NumTables_L)
$AuxTables_ptr{$NumTables_L}:=->[Inspection Type:31]
$NumTables_L:=$NumTables_L+1
INSERT IN ARRAY:C227($AuxTables_ptr; $NumTables_L)
$AuxTables_ptr{$NumTables_L}:=->[Integral Bridge:71]
$NumTables_L:=$NumTables_L+1
INSERT IN ARRAY:C227($AuxTables_ptr; $NumTables_L)
$AuxTables_ptr{$NumTables_L}:=->[Item 100:33]
$NumTables_L:=$NumTables_L+1
INSERT IN ARRAY:C227($AuxTables_ptr; $NumTables_L)
$AuxTables_ptr{$NumTables_L}:=->[Item 101:34]
$NumTables_L:=$NumTables_L+1
INSERT IN ARRAY:C227($AuxTables_ptr; $NumTables_L)
$AuxTables_ptr{$NumTables_L}:=->[Item 111:35]
$NumTables_L:=$NumTables_L+1
INSERT IN ARRAY:C227($AuxTables_ptr; $NumTables_L)
$AuxTables_ptr{$NumTables_L}:=->[Item 20 Tolls:22]
$NumTables_L:=$NumTables_L+1
INSERT IN ARRAY:C227($AuxTables_ptr; $NumTables_L)
$AuxTables_ptr{$NumTables_L}:=->[Item 33 Median:23]
$NumTables_L:=$NumTables_L+1
INSERT IN ARRAY:C227($AuxTables_ptr; $NumTables_L)
$AuxTables_ptr{$NumTables_L}:=->[Item 38:24]
$NumTables_L:=$NumTables_L+1
INSERT IN ARRAY:C227($AuxTables_ptr; $NumTables_L)
$AuxTables_ptr{$NumTables_L}:=->[MaintOwnerCode:4]
$NumTables_L:=$NumTables_L+1
INSERT IN ARRAY:C227($AuxTables_ptr; $NumTables_L)
$AuxTables_ptr{$NumTables_L}:=->[Material:10]
$NumTables_L:=$NumTables_L+1
INSERT IN ARRAY:C227($AuxTables_ptr; $NumTables_L)
$AuxTables_ptr{$NumTables_L}:=->[Membrane:16]
$NumTables_L:=$NumTables_L+1
INSERT IN ARRAY:C227($AuxTables_ptr; $NumTables_L)
$AuxTables_ptr{$NumTables_L}:=->[Months:26]
$NumTables_L:=$NumTables_L+1
INSERT IN ARRAY:C227($AuxTables_ptr; $NumTables_L)
$AuxTables_ptr{$NumTables_L}:=->[Parameters:107]
$NumTables_L:=$NumTables_L+1
INSERT IN ARRAY:C227($AuxTables_ptr; $NumTables_L)
$AuxTables_ptr{$NumTables_L}:=->[Posting Code:7]
$NumTables_L:=$NumTables_L+1
INSERT IN ARRAY:C227($AuxTables_ptr; $NumTables_L)
$AuxTables_ptr{$NumTables_L}:=->[PostingStatus:61]
$NumTables_L:=$NumTables_L+1
INSERT IN ARRAY:C227($AuxTables_ptr; $NumTables_L)
$AuxTables_ptr{$NumTables_L}:=->[Rating Method:67]
$NumTables_L:=$NumTables_L+1
INSERT IN ARRAY:C227($AuxTables_ptr; $NumTables_L)
$AuxTables_ptr{$NumTables_L}:=->[RPCs:72]
$NumTables_L:=$NumTables_L+1
INSERT IN ARRAY:C227($AuxTables_ptr; $NumTables_L)
$AuxTables_ptr{$NumTables_L}:=->[Service Over:8]
$NumTables_L:=$NumTables_L+1
INSERT IN ARRAY:C227($AuxTables_ptr; $NumTables_L)
$AuxTables_ptr{$NumTables_L}:=->[Service Under:9]
$NumTables_L:=$NumTables_L+1
INSERT IN ARRAY:C227($AuxTables_ptr; $NumTables_L)
$AuxTables_ptr{$NumTables_L}:=->[TableOfLists:125]
$NumTables_L:=$NumTables_L+1
INSERT IN ARRAY:C227($AuxTables_ptr; $NumTables_L)
$AuxTables_ptr{$NumTables_L}:=->[Templates:86]
$NumTables_L:=$NumTables_L+1
INSERT IN ARRAY:C227($AuxTables_ptr; $NumTables_L)
$AuxTables_ptr{$NumTables_L}:=->[Town Data:2]
$NumTables_L:=$NumTables_L+1
INSERT IN ARRAY:C227($AuxTables_ptr; $NumTables_L)
$AuxTables_ptr{$NumTables_L}:=->[Truck Code:12]
$NumTables_L:=$NumTables_L+1
INSERT IN ARRAY:C227($AuxTables_ptr; $NumTables_L)
$AuxTables_ptr{$NumTables_L}:=->[Type of Work:18]
$NumTables_L:=$NumTables_L+1
INSERT IN ARRAY:C227($AuxTables_ptr; $NumTables_L)
$AuxTables_ptr{$NumTables_L}:=->[Wearing Surface:15]
$NumTables_L:=$NumTables_L+1
INSERT IN ARRAY:C227($AuxTables_ptr; $NumTables_L)
$AuxTables_ptr{$NumTables_L}:=->[Work Done By:19]
$NumTables_L:=$NumTables_L+1
INSERT IN ARRAY:C227($AuxTables_ptr; $NumTables_L)
$AuxTables_ptr{$NumTables_L}:=->[zSpecialReports:106]

ut_SelectTables(->$AuxTables_ptr)
$NumTables_L:=Size of array:C274($AuxTables_ptr)
C_TEXT:C284($vTag_txt)
C_LONGINT:C283($NumTableRecs_L; $TableNum_L; $j; $i)

Case of 
	: ($Task_txt="EXPORT")
		SHORT_MESSAGE("We Will Be Exporting "+String:C10($NumTables_L)+" Auxiliary Tables ...")
		SET CHANNEL:C77(12; "")  //choose the new file
		If (OK=1)
			$vTag_txt:="MHDBMSAUXTABLEEXPORT"
			SEND VARIABLE:C80($vTag_txt)
			SEND VARIABLE:C80($NumTables_L)
			For ($i; 1; $NumTables_L)
				$TableNum_L:=Table:C252($AuxTables_ptr{$i})
				SEND VARIABLE:C80($TableNum_L)
				READ ONLY:C145($AuxTables_ptr{$i}->)
				ALL RECORDS:C47($AuxTables_ptr{$i}->)
				$NumTableRecs_L:=Records in selection:C76($AuxTables_ptr{$i}->)
				SEND VARIABLE:C80($NumTableRecs_L)
				MESSAGE:C88(<>sCR+"Table "+String:C10($i)+"/"+String:C10($NumTables_L)+" :"+Table name:C256($AuxTables_ptr{$i})+"["+String:C10($NumTableRecs_L)+"]")
				//loop
				FIRST RECORD:C50($AuxTables_ptr{$i}->)
				For ($j; 1; $NumTableRecs_L)
					SEND RECORD:C78($AuxTables_ptr{$i}->)
					NEXT RECORD:C51($AuxTables_ptr{$i}->)
				End for 
				READ WRITE:C146($AuxTables_ptr{$i}->)
				REDUCE SELECTION:C351($AuxTables_ptr{$i}->; 0)
			End for 
			//close the export file
			SET CHANNEL:C77(11)
			CLOSE WINDOW:C154
			ALERT:C41("Done exporting "+String:C10($NumTables_L)+" Aux Tables to file "+Document)
		Else 
			CLOSE WINDOW:C154
		End if 
		
	: ($Task_txt="IMPORT")
		ON ERR CALL:C155("ut_ChannelOpenError")
		SET CHANNEL:C77(10; "")
		If (OK=1)
			ON ERR CALL:C155("")
			C_TEXT:C284($vTag_txt)
			RECEIVE VARIABLE:C81($vTag_txt)
			If ($vTag_txt="MHDBMSAUXTABLEEXPORT")
				RECEIVE VARIABLE:C81($NumTables_L)
				SHORT_MESSAGE("Importing "+String:C10($NumTables_L)+" Auxiliary Tables ...")
				C_POINTER:C301($Tbl_ptr)
				For ($i; 1; $NumTables_L)
					RECEIVE VARIABLE:C81($TableNum_L)
					$Tbl_ptr:=Table:C252($TableNum_L)
					RECEIVE VARIABLE:C81($NumTableRecs_L)
					MESSAGE:C88(<>sCR+"Table "+String:C10($i)+"/"+String:C10($NumTables_L)+" :"+Table name:C256($Tbl_ptr)+"["+String:C10($NumTableRecs_L)+"]")
					If ($NumTableRecs_L>0)
						ALL RECORDS:C47($Tbl_ptr->)
						DELETE SELECTION:C66($Tbl_ptr->)
						For ($j; 1; $NumTableRecs_L)
							RECEIVE RECORD:C79($Tbl_ptr->)
							SAVE RECORD:C53($Tbl_ptr->)
						End for 
						//FLUSH CACHE
					Else 
						MESSAGE:C88("..Skipped (zero records)")
					End if 
					REDUCE SELECTION:C351($Tbl_ptr->; 0)
				End for 
				CLOSE WINDOW:C154
			Else 
				ALERT:C41("File <"+Document+"> is not an auxilary table export file!")
			End if 
			
			SET CHANNEL:C77(11)
		End if 
		ON ERR CALL:C155("")
		
End case 