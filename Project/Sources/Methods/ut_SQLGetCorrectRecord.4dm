//%attributes = {"invisible":true}

// ----------------------------------------------------
// User name (OS): Charles Miller
// Date and time: 08/10/10, 10:06:05
// ----------------------------------------------------
// Method: ut_SQLGetCorrectRecord
// Description
// This method is called by 
//ut_SQLServerLink
//ut_SQLUpdateLocalField
//ut_SQLUpdateLocalFields 
//to load the correct local record

// Parameters
// ----------------------------------------------------

//$1 pointer to ocal
//$2 pointer to parent

// Modified by: Charles Miller (8/10/10)
If (False:C215)
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (8/11/10 11:22:01) 
End if 

C_POINTER:C301($1; $2)
C_POINTER:C301($Local_ptr; $Parent_Ptr)
$Local_ptr:=$1
$Parent_Ptr:=$2

C_TEXT:C284($LocalID_s; $ParentID_s; $RefID_s)  // Command Replaced was o_C_STRING length was 80
C_POINTER:C301($LocalTable_ptr; $LocalFld_ptr)
$LocalTable_ptr:=Table:C252([Activity Log:59]FileID Local:24)
$LocalFld_ptr:=Field:C253([Activity Log:59]FileID Local:24; [Activity Log:59]FieldID Local:25)

C_LONGINT:C283($RefID_l)
Case of 
	: ([Activity Log:59]RefIDType:26=0)
		$RefID_s:=[Activity Log:59]Local ID:15
		$RefID_l:=Num:C11($RefID_s)
		If ([Activity Log:59]Local Type:18=0)
			QUERY:C277($LocalTable_ptr->; $LocalFld_ptr->=$RefID_s)
		Else 
			QUERY:C277($LocalTable_ptr->; $LocalFld_ptr->=$RefID_l)
		End if 
		$LocalID_s:=$RefID_s
		$ParentID_s:=[Activity Log:59]Parent ID:14
	: ([Activity Log:59]RefIDType:26=1)
		$RefID_s:=aDblLookUpDest([Activity Log:59]FileID Local:24; [Activity Log:59]Local ID:15; "Here"; <>Destination)
		$RefID_l:=Num:C11($RefID_s)
		If ([Activity Log:59]Local Type:18=0)
			QUERY:C277($LocalTable_ptr->; $LocalFld_ptr->=$RefID_s)
		Else 
			QUERY:C277($LocalTable_ptr->; $LocalFld_ptr->=$RefID_l)
		End if 
		$LocalID_s:=$RefID_s
		$ParentID_s:=[Activity Log:59]Parent ID:14
		If ([Activity Log:59]FieldID Parent:23#[Activity Log:59]FieldID Local:25)
			$RefID_l:=Num:C11([Activity Log:59]Parent ID:14)
			C_POINTER:C301($ParentField_ptr)
			$ParentField_ptr:=Field:C253([Activity Log:59]FileID Local:24; [Activity Log:59]FieldID Parent:23)
			If ([Activity Log:59]Type Parent:17=0)
				QUERY SELECTION:C341($LocalTable_ptr->; $ParentField_ptr->=[Activity Log:59]Parent ID:14)
			Else 
				QUERY SELECTION:C341($LocalTable_ptr->; $ParentField_ptr->=$RefID_l)
			End if 
			
		Else 
			$ParentID_s:=$LocalID_s
		End if 
		
	: ([Activity Log:59]RefIDType:26=2)
		$RefID_s:=aDblLookUpDest([Activity Log:59]FileID Local:24; [Activity Log:59]Local ID:15; "Here"; <>Destination)
		$RefID_l:=Num:C11($RefID_s)
		If ([Activity Log:59]Local Type:18=0)
			QUERY:C277($LocalTable_ptr->; $LocalFld_ptr->=$RefID_s)
		Else 
			QUERY:C277($LocalTable_ptr->; $LocalFld_ptr->=$RefID_l)
		End if 
		$LocalID_s:=$RefID_s
		$RefID_s:=aDblLookUpDest([Activity Log:59]FileID Parent:22; [Activity Log:59]Parent ID:14; "Here"; <>Destination)
		C_POINTER:C301($ParentField_ptr)
		$ParentField_ptr:=Field:C253([Activity Log:59]FileID Local:24; [Activity Log:59]FieldID Parent:23)
		If ([Activity Log:59]Type Parent:17=0)
			QUERY SELECTION:C341($LocalTable_ptr->; $ParentField_ptr->=$RefID_s)
		Else 
			$RefID_l:=Num:C11($RefID_s)
			QUERY SELECTION:C341($LocalTable_ptr->; $ParentField_ptr->=$RefID_l)
		End if 
		$ParentID_s:=$RefID_s
	: ([Activity Log:59]RefIDType:26=3)  //this should only be for delete
		$RefID_s:=aLookUpDest([Activity Log:59]File Number:7; [Activity Log:59]Local ID:15; "here")  //Can not rely on the destination id
		If ($RefID_s="")  //Assume remote and local ids match!
			$RefID_s:=[Activity Log:59]Local ID:15
		End if 
		$RefID_l:=Num:C11($RefID_s)
		If ([Activity Log:59]Local Type:18=0)
			QUERY:C277($LocalTable_ptr->; $LocalFld_ptr->=$RefID_s)
		Else 
			QUERY:C277($LocalTable_ptr->; $LocalFld_ptr->=$RefID_l)
		End if 
		$LocalID_s:=$RefID_s
		$RefID_s:=aDblLookUpDest([Activity Log:59]FileID Parent:22; [Activity Log:59]Parent ID:14; "Here"; <>Destination)
		//Danger!             
		If ($RefID_s="")  //Assume remote and local ids match!
			$RefID_s:=[Activity Log:59]Parent ID:14
		End if 
		$RefID_l:=Num:C11($RefID_s)
		C_POINTER:C301($ParentField_ptr)
		$ParentField_ptr:=Field:C253([Activity Log:59]FileID Local:24; [Activity Log:59]FieldID Parent:23)
		If ([Activity Log:59]Type Parent:17=0)
			QUERY SELECTION:C341($LocalTable_ptr->; $ParentField_ptr->=$RefID_s)
		Else 
			QUERY SELECTION:C341($LocalTable_ptr->; $ParentField_ptr->=$RefID_l)
		End if 
		$ParentID_s:=$RefID_s
End case 


$Local_ptr->:=$LocalID_s
$Parent_Ptr->:=$ParentID_s