//%attributes = {"invisible":true}
// ----------------------------------------------------
//ut_SaveUserLogInInformation
// User name (OS): charlesmiller
// Date and time: 07/12/11, 10:49:22
// ----------------------------------------------------
// Description
// This method will save user information for later imprt so that last log in date and number of logins can be maintained
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2011_07  // CJ Miller`07/12/11, 10:49:24      ` 
	
	// Modified by: Costas Manousakis-(Designer)-(1/20/12 18:05:26)
	Mods_2012_01
	//  `Fixed declaration of variables in the GET USER PROPERTIES call
	//  `Removed adding ◊PL_DirectorySep_s to the selected folder - not needed
	Mods_2012_02  //r001`Exclude Administrator and Designer
	//Modified by: Charles Miller (2/7/12 15:33:51)
	Mods_2013_06  //r001 ` Add update progress bar and change code to deal with adjusted user names
	//Modified by: Charles Miller (6/13/13 16:27:04)
End if 
C_TEXT:C284($0; $SavedDocumentPath_txt)

ARRAY TEXT:C222($UserNames_atxt; 0)
ARRAY LONGINT:C221($UserNumbers_al; 0)
C_DATE:C307($LastLogin_d)
GET USER LIST:C609($UserNames_atxt; $UserNumbers_al)

C_LONGINT:C283($Loop_l; $NumberofLogins_l; $GroupOwner_L)
C_TEXT:C284($Name_txt; $StartUp_txt; $Password_txt)
C_TEXT:C284($Changes_txt; $DocPath_txt)
ARRAY LONGINT:C221($ExportUserNumbers_al; 0)
ARRAY LONGINT:C221($ExportLoginCount_al; 0)
ARRAY DATE:C224($ExportLastLoginDate_ad; 0)
ARRAY TEXT:C222($ExportUserName_atxt; 0)
ARRAY LONGINT:C221($Membership_aL; 0)
C_LONGINT:C283($NumberRecords_L; $Interval_L)
<>ProgressPID:=StartProgress("Save Login info"; "Button"; "Save user log in data")
$NumberRecords_L:=Size of array:C274($UserNumbers_al)

$Interval_L:=MaxNum(MinNum(Int:C8($NumberRecords_l/40); 20); 2)  // get an update interval between 2 and 20


For ($Loop_l; 1; Size of array:C274($UserNumbers_al))
	If (($Loop_l%$Interval_L=0) | ($Loop_l=$NumberRecords_L))  //Don't slow down things just to display
		UpdateProgress($Loop_l; $NumberRecords_L)
	End if 
	If (Not:C34(Is user deleted:C616($UserNumbers_al{$Loop_l})))
		
		If ($UserNames_atxt{$Loop_l}="Designer") | ($UserNames_atxt{$Loop_l}="Administrator")
		Else 
			APPEND TO ARRAY:C911($ExportUserNumbers_al; $UserNumbers_al{$Loop_l})
			GET USER PROPERTIES:C611($UserNumbers_al{$Loop_l}; $Name_txt; $StartUp_txt; $Password_txt; $NumberofLogins_l; $LastLogin_d; $Membership_aL; $GroupOwner_L)
			APPEND TO ARRAY:C911($ExportLoginCount_al; $NumberofLogins_l)
			APPEND TO ARRAY:C911($ExportLastLoginDate_ad; $LastLogin_d)
			APPEND TO ARRAY:C911($ExportUserName_atxt; $Name_txt)
			
		End if 
	End if 
End for 

POST OUTSIDE CALL:C329(<>ProgressPID)
C_TEXT:C284($Folder_txt; $FileName_txt)
$Folder_txt:=Select folder:C670("select folder to save User log in data to ")

//$Folder_txt:=$Folder_txt+◊PL_DirectorySep_s
$FileName_txt:=Substring:C12(ut_ReturnTimeStampFromDate(Current date:C33(*); Current time:C178(*)); 1; 14)+"Users_Data"
C_BLOB:C604($Blob_blb)
SET BLOB SIZE:C606($Blob_blb; 0)

VARIABLE TO BLOB:C532($ExportUserNumbers_al; $Blob_blb; *)
VARIABLE TO BLOB:C532($ExportLoginCount_al; $Blob_blb; *)
VARIABLE TO BLOB:C532($ExportLastLoginDate_ad; $Blob_blb; *)
VARIABLE TO BLOB:C532($ExportUserName_atxt; $Blob_blb; *)


$Folder_txt:=$Folder_txt+$FileName_txt
C_TIME:C306($Doc_tm)
$Doc_tm:=Create document:C266($Folder_txt)
CLOSE DOCUMENT:C267($Doc_tm)
BLOB TO DOCUMENT:C526($Folder_txt; $Blob_blb)
$0:=Document
SET BLOB SIZE:C606($Blob_blb; 0)

//End ut_SaveUserLogInInformation