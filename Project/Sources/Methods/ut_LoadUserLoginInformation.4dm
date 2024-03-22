//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_LoadUserLoginInformation
// User name (OS): charlesmiller
// Date and time: 07/12/11, 11:01:04
// ----------------------------------------------------
// Description
// This method will select a file containing
//The following arrays
//ARRAY LONGINT($ExportUserNumbers_al;0)
//ARRAY LONGINT($ExportLoginCount_al;0)
//ARRAY DATE($ExportLastLoginDate_ad;0)
//ARRAY TEXT($ExportUserName_atxt;0)
//Created from method ut_SaveUserInformation
//It will loop through all users and reset login count and date
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2011_07  // CJ Miller`07/12/11, 11:01:07      `
	// Modified by: costasmanousakis-(Designer)-(12/13/11 22:53:19)
	Mods_2011_12
	//  `Fixed declaration of $Membership_aL switch from text array to longint
	//  `Add Check for OK after doc select
	
	// Modified by: Costas Manousakis-(Designer)-(1/20/12 18:07:12)
	Mods_2012_01
	//  `Fixed declaration of $GroupOwner_L switch from text  to longint
	Mods_2012_02  //r001`Exclude Administrator and Designer
	Mods_2012_02  //r001 `Fix bug and bring up alerts re who was skipped or not found
	//Modified by: Charles Miller (2/16/12 14:18:39)
	Mods_2013_06  //r001 ` Add update progress bar and change code to deal with adjusted user names
	//Modified by: Charles Miller (6/13/13 16:27:04)
	// Modified by: Costas Manousakis-(Designer)-(12/30/13 11:06:27)
	Mods_2013_12
	//  `fixed the update progress bar since the loop is  in reverse order
End if 
ARRAY LONGINT:C221($ExportUserNumbers_al; 0)
ARRAY LONGINT:C221($ExportLoginCount_al; 0)
ARRAY DATE:C224($ExportLastLoginDate_ad; 0)
ARRAY TEXT:C222($ExportUserName_atxt; 0)
C_TEXT:C284($Folder_txt)
ARRAY TEXT:C222($Documents_atxt; 0)

If (Count parameters:C259=1)
	C_TEXT:C284($1)
	$Folder_txt:=$1
	If (Test path name:C476($Folder_txt)=Is a document:K24:1)
	Else 
		$Folder_txt:=Select document:C905(""; "*"; "Select Document to load User Login date and count"; 0; $Documents_atxt)
		$Folder_txt:=$Documents_atxt{1}
	End if 
Else 
	$Folder_txt:=Select document:C905(""; "*"; "Select Document to load User Login date and count"; 0; $Documents_atxt)
	$Folder_txt:=$Documents_atxt{1}
End if 
If (OK=1)
	C_BLOB:C604($Blob_blb)
	SET BLOB SIZE:C606($Blob_blb; 0)
	
	DOCUMENT TO BLOB:C525($Folder_txt; $Blob_blb)
	C_LONGINT:C283($Loop_l; $Position_l; $NumberofLogins_l; $UserID_l; $GroupOwner_L)
	C_DATE:C307($LastLogin_d)
	$Loop_l:=0
	BLOB TO VARIABLE:C533($Blob_blb; $ExportUserNumbers_al; $Loop_l)
	BLOB TO VARIABLE:C533($Blob_blb; $ExportLoginCount_al; $Loop_l)
	BLOB TO VARIABLE:C533($Blob_blb; $ExportLastLoginDate_ad; $Loop_l)
	BLOB TO VARIABLE:C533($Blob_blb; $ExportUserName_atxt; $Loop_l)
	
	SET BLOB SIZE:C606($Blob_blb; 0)
	ARRAY LONGINT:C221($Membership_aL; 0)
	
	ARRAY TEXT:C222($UserNames_atxt; 0)
	ARRAY LONGINT:C221($UserNumbers_al; 0)
	C_TEXT:C284($Name_txt; $StartUp_txt; $Password_txt)
	C_TEXT:C284($Aster_txt)
	$Aster_txt:="*"
	C_LONGINT:C283($NumberUpdated_l; $SizeofArray_l)
	$NumberUpdated_l:=0
	
	GET USER LIST:C609($UserNames_atxt; $UserNumbers_al)
	$Position_l:=Find in array:C230($UserNames_atxt; "Designer")
	If ($Position_l>0)
		DELETE FROM ARRAY:C228($UserNames_atxt; $Position_l; 1)
		DELETE FROM ARRAY:C228($UserNumbers_al; $Position_l; 1)
	End if 
	
	$Position_l:=Find in array:C230($UserNames_atxt; "Administrator")
	If ($Position_l>0)
		DELETE FROM ARRAY:C228($UserNames_atxt; $Position_l; 1)
		DELETE FROM ARRAY:C228($UserNumbers_al; $Position_l; 1)
	End if 
	$SizeofArray_l:=Size of array:C274($UserNumbers_al)
	<>ProgressPID:=StartProgress("Load Login info"; "Button"; "Load user log in data")
	C_LONGINT:C283($Interval_L)
	
	$Interval_L:=MaxNum(MinNum(Int:C8($SizeofArray_l/40); 20); 2)  // get an update interval between 2 and 20
	
	ARRAY TEXT:C222($Unmatched_atxt; 0)
	
	For ($Loop_l; $SizeofArray_l; 1; -1)
		If ((($SizeofArray_l-$Loop_l)%$Interval_L=0) | ($Loop_l=$SizeofArray_l))  //Don't slow down things just to display
			UpdateProgress(($SizeofArray_l-$Loop_l); $SizeofArray_l)
		End if 
		$Position_l:=Find in array:C230($ExportUserNumbers_al; $UserNumbers_al{$Loop_l})
		If ($Position_l>0)
			$NumberUpdated_l:=$NumberUpdated_l+1
			GET USER PROPERTIES:C611($UserNumbers_al{$Loop_l}; $Name_txt; $StartUp_txt; $Password_txt; $NumberofLogins_l; $LastLogin_d; $Membership_aL; $GroupOwner_L)
			Case of 
				: ($Name_txt#$ExportUserName_atxt{$Position_l})
					APPEND TO ARRAY:C911($Unmatched_atxt; $ExportUserName_atxt{$Position_l}+" set to "+$Name_txt)
					$UserID_l:=Set user properties:C612($UserNumbers_al{$Loop_l}; $Name_txt; $StartUp_txt; *; $ExportLoginCount_al{$Position_l}; $ExportLastLoginDate_ad{$Position_l}; $Membership_aL)
					
				: ($Name_txt="Designer") | ($Name_txt="Administrator")
				Else 
					$UserID_l:=Set user properties:C612($UserNumbers_al{$Loop_l}; $ExportUserName_atxt{$Position_l}; $StartUp_txt; *; $ExportLoginCount_al{$Position_l}; $ExportLastLoginDate_ad{$Position_l}; $Membership_aL)
			End case 
			DELETE FROM ARRAY:C228($ExportUserName_atxt; $Position_l; 1)
			DELETE FROM ARRAY:C228($ExportLoginCount_al; $Position_l; 1)
			DELETE FROM ARRAY:C228($ExportLastLoginDate_ad; $Position_l; 1)
			DELETE FROM ARRAY:C228($ExportUserNumbers_al; $Position_l; 1)
			DELETE FROM ARRAY:C228($UserNumbers_al; $Loop_l; 1)
			DELETE FROM ARRAY:C228($UserNames_atxt; $Loop_l; 1)
		End if 
		
	End for 
	
	POST OUTSIDE CALL:C329(<>ProgressPID)
	
	If (Size of array:C274($ExportUserName_atxt)>0)
		ARRAY TEXT:C222(LBGeneric_atxt; 0)
		COPY ARRAY:C226($ExportUserName_atxt; LBGeneric_atxt)
		C_LONGINT:C283($Width_l; $Height_l)
		FORM GET PROPERTIES:C674("OneArrayLB"; $Width_l; $Height_l)
		ut_OpenNewWindow($Width_l; $Height_l; 0; Plain window:K34:13; "Old Users Not Updated"; "ut_CloseCancel")
		1_TXT:="Not Updated"
		DIALOG:C40("OneArrayLB")
		If (False:C215)
			C_TEXT:C284($Message_txt)
			$Message_txt:=$ExportUserName_atxt{1}
			For ($Loop_l; 2; Size of array:C274($ExportUserName_atxt))
				$Message_txt:=$Message_txt+", "+$ExportUserName_atxt{$Loop_l}
			End for 
			ALERT:C41("The following "+String:C10(Size of array:C274($ExportUserName_atxt))+" old users not updated as they were not found on the receiving db."+Char:C90(Carriage return:K15:38)+$Message_txt)
		End if 
	End if 
	If (Size of array:C274($Unmatched_atxt)>0)
		ARRAY TEXT:C222(LBGeneric_atxt; 0)
		COPY ARRAY:C226($Unmatched_atxt; LBGeneric_atxt)
		C_LONGINT:C283($Width_l; $Height_l)
		FORM GET PROPERTIES:C674("OneArrayLB"; $Width_l; $Height_l)
		ut_OpenNewWindow($Width_l; $Height_l; 0; Plain window:K34:13; "Mismatched Users"; "ut_CloseCancel")
		1_TXT:="Names reset"
		DIALOG:C40("OneArrayLB")
		
		
	End if 
	If (Size of array:C274($UserNames_atxt)>0)
		
		ARRAY TEXT:C222(LBGeneric_atxt; 0)
		COPY ARRAY:C226($UserNames_atxt; LBGeneric_atxt)
		C_LONGINT:C283($Width_l; $Height_l)
		FORM GET PROPERTIES:C674("OneArrayLB"; $Width_l; $Height_l)
		ut_OpenNewWindow($Width_l; $Height_l; 0; Plain window:K34:13; "New Users Added"; "ut_CloseCancel")
		1_TXT:="New Users"
		DIALOG:C40("OneArrayLB")
		If (False:C215)
			C_TEXT:C284($Message_txt)
			$Message_txt:=$UserNames_atxt{1}
			For ($Loop_l; 2; Size of array:C274($UserNames_atxt))
				$Message_txt:=$Message_txt+", "+$UserNames_atxt{$Loop_l}
			End for 
			ALERT:C41("The following "+String:C10($SizeofArray_l-$NumberUpdated_l)+" new users not updated!!!"+Char:C90(Carriage return:K15:38)+$Message_txt)
		End if 
	End if 
	If ((Size of array:C274($ExportUserName_atxt)=0) & (Size of array:C274($UserNames_atxt)=0))
		ALERT:C41("all users updated")
	End if 
	
End if 
ARRAY LONGINT:C221($ExportUserNumbers_al; 0)
ARRAY LONGINT:C221($ExportLoginCount_al; 0)
ARRAY DATE:C224($ExportLastLoginDate_ad; 0)
ARRAY TEXT:C222($ExportUserName_atxt; 0)
ARRAY LONGINT:C221($UserNumbers_al; 0)

//End ut_LoadUserLoginInformation