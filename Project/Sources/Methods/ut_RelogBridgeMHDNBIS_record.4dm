//%attributes = {"invisible":true}
// Method: ut_RelogBridgeMHDNBIS_record
// Description
//  ` Recreate LogNewrecord and Changes for  Bridge mhd nbis record(s) 
//  ` to be executed in the Main Boston server.
//  ` First do a search on the bridge table to select the record(s) to be re-logged;
//  ` Find users who connect for transfers to the main server - dive users and 
//  `  ` the District x servers and External server;
//  ` Make sure that the dive users are not part of a district which means they would 
//  `  ` get the change from the district server
//  ` Select which one of those to exclude which means the changes will go only to him(her) 
// Parameters - None
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/22/10, 20:16:44
	// ----------------------------------------------------
	// 
	
	Mods_2010_09
	// Modified by: costasmanousakis-(Designer)-(12/20/10 14:33:15)
	Mods_2010_12
	//  `Get the list of users to be included in the [Owners of Data] records from the 4D Users and Groups;
	//  `Add the Owner Records after the execution of LogNewRecord  and FlushGrpChgs.
	// Modified by: costasmanousakis-(Designer)-(1/31/11 09:29:07)
	Mods_2011_01
	//  ` Use method X_AddOwnerRec
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
C_LONGINT:C283($TableNum_L; $NumFields_L; $KeyFieldNum_L; $i)
C_TEXT:C284($FieldName_txt; $keyFieldName_txt)
C_POINTER:C301($Tbl_ptr; $KeyField_ptr)
$Tbl_ptr:=->[Bridge MHD NBIS:1]
$KeyField_ptr:=->[Bridge MHD NBIS:1]BIN:3
$TableNum_L:=Table:C252($Tbl_ptr)
$NumFields_L:=Get last field number:C255(Table:C252($TableNum_L))
ARRAY POINTER:C280($a_Ptr_Fields; $NumFields_L)
For ($i; 1; $NumFields_L)
	$a_Ptr_Fields{$i}:=Field:C253($TableNum_L; $i)
End for 
$KeyFieldNum_L:=Find in array:C230($a_Ptr_Fields; $KeyField_ptr)
C_BOOLEAN:C305($ResetRW_b)
$ResetRW_b:=False:C215
If (Read only state:C362($Tbl_ptr->))
Else 
	$ResetRW_b:=True:C214
	READ ONLY:C145($Tbl_ptr->)
End if 

QUERY:C277($Tbl_ptr->)
If (Ok=1)
	
	If (Type:C295(ptr_Changes)#Array 2D:K8:24)
		ARRAY POINTER:C280(ptr_Changes; 0; 0)
	End if 
	ARRAY TEXT:C222(SpecOwnerList_atxt; 0)
	
	C_LONGINT:C283($DiveInspGrpID_L; $DiveGrpID_L; $grpOwn_L; $loop_L)
	ARRAY TEXT:C222($GroupNames_atxt; 0)
	ARRAY TEXT:C222($UserNames_atxt; 0)
	ARRAY LONGINT:C221($GroupNos_aL; 0)
	ARRAY LONGINT:C221($UserNos_aL; 0)
	ARRAY LONGINT:C221($DiveInspMembers_aL; 0)
	ARRAY LONGINT:C221($DiveGrpMembers_aL; 0)
	C_TEXT:C284($grpName)
	GET GROUP LIST:C610($GroupNames_atxt; $GroupNos_aL)
	GET USER LIST:C609($UserNames_atxt; $UserNos_aL)
	$DiveInspGrpID_L:=$GroupNos_aL{Find in array:C230($GroupNames_atxt; "Dive Inspection")}
	$DiveGrpID_L:=$GroupNos_aL{Find in array:C230($GroupNames_atxt; "DiveGroup")}
	GET GROUP PROPERTIES:C613($DiveInspGrpID_L; $grpName; $grpOwn_L; $DiveInspMembers_aL)
	GET GROUP PROPERTIES:C613($DiveGrpID_L; $grpName; $grpOwn_L; $DiveGrpMembers_aL)
	For ($loop_L; 1; Size of array:C274($DiveGrpMembers_aL))
		If (Find in array:C230($DiveInspMembers_aL; $DiveGrpMembers_aL{$loop_L})<=0)
			APPEND TO ARRAY:C911($DiveInspMembers_aL; $DiveGrpMembers_aL{$loop_L})
		End if 
	End for 
	C_LONGINT:C283($TotalNumMbrs_L)
	$TotalNumMbrs_L:=Size of array:C274($DiveInspMembers_aL)
	
	ARRAY TEXT:C222(SpecOwnerList_atxt; $TotalNumMbrs_L)
	For ($loop_L; 1; $TotalNumMbrs_L)
		SpecOwnerList_atxt{$loop_L}:=$UserNames_atxt{(Find in array:C230($UserNos_aL; $DiveInspMembers_aL{$loop_L}))}
	End for 
	For ($loop_L; $TotalNumMbrs_L; 1; -1)
		Case of 
			: (User in group:C338(SpecOwnerList_atxt{$loop_L}; "District 1"))
				DELETE FROM ARRAY:C228(SpecOwnerList_atxt; $loop_L; 1)
			: (User in group:C338(SpecOwnerList_atxt{$loop_L}; "District 2"))
				DELETE FROM ARRAY:C228(SpecOwnerList_atxt; $loop_L; 1)
			: (User in group:C338(SpecOwnerList_atxt{$loop_L}; "District 3"))
				DELETE FROM ARRAY:C228(SpecOwnerList_atxt; $loop_L; 1)
			: (User in group:C338(SpecOwnerList_atxt{$loop_L}; "District 4"))
				DELETE FROM ARRAY:C228(SpecOwnerList_atxt; $loop_L; 1)
			: (User in group:C338(SpecOwnerList_atxt{$loop_L}; "District 5"))
				DELETE FROM ARRAY:C228(SpecOwnerList_atxt; $loop_L; 1)
			: (User in group:C338(SpecOwnerList_atxt{$loop_L}; "District 6"))
				DELETE FROM ARRAY:C228(SpecOwnerList_atxt; $loop_L; 1)
		End case 
		
	End for 
	
	APPEND TO ARRAY:C911(SpecOwnerList_atxt; "District1 Server")
	APPEND TO ARRAY:C911(SpecOwnerList_atxt; "District2 Server")
	APPEND TO ARRAY:C911(SpecOwnerList_atxt; "District3 Server")
	APPEND TO ARRAY:C911(SpecOwnerList_atxt; "District4 Server")
	APPEND TO ARRAY:C911(SpecOwnerList_atxt; "District5 Server")
	APPEND TO ARRAY:C911(SpecOwnerList_atxt; "District6 Server")
	APPEND TO ARRAY:C911(SpecOwnerList_atxt; "BMSExternal Server")
	
	C_TEXT:C284($UserToExclude_txt)
	$UserToExclude_txt:=Request:C163("Enter user name to exclude from list of owners")
	C_LONGINT:C283($indx_L)
	$indx_L:=Find in array:C230(SpecOwnerList_atxt; $UserToExclude_txt)
	If ($indx_L>0)
		DELETE FROM ARRAY:C228(SpecOwnerList_atxt; $indx_L; 1)
	Else 
		ALERT:C41("User name <"+$UserToExclude_txt+"> Not found in list of users!")
	End if 
	If (Records in selection:C76($Tbl_ptr->)>0)
		C_TEXT:C284($Msg_txt)
		ARRAY TEXT:C222($BINS_atxt; 0)
		SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]BIN:3; $BINS_atxt)
		$Msg_txt:="Ready to Re-Log Entries for "+String:C10(Records in selection:C76([Bridge MHD NBIS:1]))+" Bridges? ["
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274($BINS_atxt))
			$Msg_txt:=$Msg_txt+$BINS_atxt{$loop_L}+" "
		End for 
		$Msg_txt:=$Msg_txt+"]"
		
		CONFIRM:C162($Msg_txt)
		If (OK=1)
			FIRST RECORD:C50($Tbl_ptr->)
			While (Not:C34(End selection:C36($Tbl_ptr->)))
				//LogDeletion ($KeyField_ptr;$KeyField_ptr;$KeyField_ptr;0)
				C_LONGINT:C283($actRefID_L; $loop_L)
				START TRANSACTION:C239
				LogNewRecord($KeyField_ptr; $KeyField_ptr; $KeyField_ptr; 0; "BIN")
				LOAD RECORD:C52([Activity Log:59])
				$actRefID_L:=[Activity Log:59]RefID:28
				UNLOAD RECORD:C212([Activity Log:59])
				X_CreateOwnRecs($actRefID_L; "ARRAY")
				InitChangeStack(1)
				For ($i; 1; $NumFields_L)
					If ($i#$KeyFieldNum_L)
						PushChange(1; $a_Ptr_Fields{$i})
					End if 
				End for 
				FlushGrpChgs(1; $KeyField_ptr; $KeyField_ptr; $KeyField_ptr; 0)
				LOAD RECORD:C52([Activity Log:59])
				$actRefID_L:=[Activity Log:59]RefID:28
				UNLOAD RECORD:C212([Activity Log:59])
				X_CreateOwnRecs($actRefID_L; "ARRAY")
				VALIDATE TRANSACTION:C240
				NEXT RECORD:C51($Tbl_ptr->)
			End while 
			
		End if 
	Else 
		ALERT:C41("No Records Selected in table ["+Table name:C256($Tbl_ptr)+"]")
	End if 
	ARRAY TEXT:C222($GroupNames_atxt; 0)
	ARRAY TEXT:C222($UserNames_atxt; 0)
	ARRAY LONGINT:C221($GroupNos_aL; 0)
	ARRAY LONGINT:C221($UserNos_aL; 0)
	ARRAY LONGINT:C221($DiveInspMembers_aL; 0)
	ARRAY LONGINT:C221($DiveGrpMembers_aL; 0)
	ARRAY TEXT:C222(SpecOwnerList_atxt; 0)
	
End if 
If ($ResetRW_b)
	READ WRITE:C146($Tbl_ptr->)
End if 