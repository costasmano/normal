//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/12/07, 08:39:35
	// ----------------------------------------------------
	// Method: ut_CheckTransfer2Pontis
	// Description
	// Check the status of the latest transfer to Pontis db
	// 
	// Parameters
	// 0 : AlertFlag : Boolean : Processes are out of schedule
	// 1 : MesgPtr : Pointer to a text var to append the result
	// ----------------------------------------------------
	
	Mods_2007_CM07
End if 
C_BOOLEAN:C305($0; $AlertFlag_b)
C_POINTER:C301($1; $TxtMsg_ptr)
$TxtMsg_ptr:=$1
C_TEXT:C284($Results_txt)
$Results_txt:=""
$AlertFlag_b:=False:C215
READ ONLY:C145([Preferences:57])
ALL RECORDS:C47([Preferences:57])
FIRST RECORD:C50([Preferences:57])
C_DATE:C307($ULastLogin_d; $LastUpdate_d)
$LastUpdate_d:=[Preferences:57]Pontis_LastUpdate_d:18
C_TEXT:C284($Uname_txt; $Ustart_txt; $Pw_txt)
C_LONGINT:C283($UNlogin_L)
GET USER PROPERTIES:C611(f_GetUserID("BMSPontis Transfer"); $Uname_txt; $Ustart_txt; $Pw_txt; $UNlogin_L; $ULastLogin_d)

$Results_txt:="Date Pontis Update finished successfully :"+String:C10($LastUpdate_d)
$Results_txt:=$Results_txt+Char:C90(13)+"Date Pontis Batch user logged in last :"+String:C10($ULastLogin_d)
If (Current date:C33(*)>Add to date:C393($LastUpdate_d; 0; 0; 1))
	$AlertFlag_b:=True:C214
	$Results_txt:=$Results_txt+Char:C90(13)+Char:C90(9)+"Appears Pontis transfer is late!"
Else 
	$Results_txt:=$Results_txt+Char:C90(13)+Char:C90(9)+"Appears Pontis transfer is on schedule!"
End if 

$0:=$AlertFlag_b
$Results_txt:=Char:C90(13)+Char:C90(13)+"Checking Transfer to Pontis db. Check run on "+String:C10(Current time:C178(*))+Char:C90(13)+$Results_txt
$TxtMsg_ptr->:=$TxtMsg_ptr->+$Results_txt
$Results_txt:=""