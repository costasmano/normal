//%attributes = {"invisible":true,"publishedSql":true}
//Method: FN_SetPassword
//Description
// Change a users password
// Parameters
// $0 : $return_blob
//  // $UserID_L if changed correctly
//  // $debug_text if $dgb:=true was added at the end of $1
// $1 : $param_blob 
//  // $currentusername_txt
//  // $newPassword_txt
//  // $currentuserID_L
//  // $Dgb_bool (optional)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 06/28/22, 17:31:58
	// ----------------------------------------------------
	//Created : 
	Mods_2022_07  // Created code to allow for single user to update their password on server
	// Modified by: Costas Manousakis-(Designer)-(2022-12-23 10:42:10)
	Mods_2022_12_bug
	//  `adjust location of debug text file 
	//  `accept in blob a dbg boolean to save debug text, return debug text in the return blob.
	
End if 
//
C_BLOB:C604($0; $1; $Send_blb; Return_blb; $debug_blb)
$Send_blb:=$1
C_LONGINT:C283($offset_L; $PassedInID_L)
$offset_L:=0

C_TEXT:C284($CurrentUser_txt; $ConfirmPassword_txt; $Path_txt; $debug_txt)
BLOB TO VARIABLE:C533($Send_blb; $CurrentUser_txt; $Offset_L)
BLOB TO VARIABLE:C533($Send_blb; $ConfirmPassword_txt; $Offset_L)
BLOB TO VARIABLE:C533($Send_blb; $PassedInID_L; $Offset_L)

C_BOOLEAN:C305($dbg)
BLOB TO VARIABLE:C533($Send_blb; $dbg; $Offset_L)

If ($dbg)  // We only use for debugging
	C_TIME:C306($Doc_tm)
	
	If (Application type:C494=4D Local mode:K5:1) | (Application type:C494=4D Remote mode:K5:5)
		$path_txt:=System folder:C487(Documents folder:K41:18)+"Debugdata"
	Else 
		$path_txt:=Get 4D folder:C485(Data folder:K5:33)+"Debugdata"
	End if 
	
	If (Test path name:C476($Path_txt)=Is a folder:K24:2)
	Else 
		CREATE FOLDER:C475($Path_txt)
	End if 
	$Path_txt:=$Path_txt+Folder separator:K24:12+Current method name:C684+"_"+\
		Replace string:C233(String:C10(Current date:C33; ISO date:K1:8; Current time:C178); ":"; "_")+".txt"
	
	$Doc_tm:=Create document:C266($path_txt)
	$debug_txt:="received data"+"\n"+\
		"Passed in Username "+$CurrentUser_txt+"\n"+\
		"Passed in $PassedInID_L "+String:C10($PassedInID_L)+"\n"+\
		"Passed in ConfirmPassword_txt "+$ConfirmPassword_txt+"\n\n"+\
		"Current user "+Current user:C182+"\n\n"
	
	SEND PACKET:C103($Doc_tm; $debug_txt)
	
	CLOSE DOCUMENT:C267($Doc_tm)
	VARIABLE TO BLOB:C532($debug_txt; $debug_blb; *)
End if 

C_TEXT:C284($name_txt; $startUp_txt; $OldPassword_txt; $Password_txt)
C_DATE:C307($LastLogin_D)
ARRAY TEXT:C222($UserNames_atxt; 0)
ARRAY LONGINT:C221($UserIDs_aL; 0)
C_LONGINT:C283($Pos_L; $UserID_L; $NumberLogins_L)

GET USER LIST:C609($UserNames_atxt; $UserIDs_aL)
$Pos_L:=Find in array:C230($UserNames_atxt; $CurrentUser_txt)
$UserID_L:=$UserIDs_aL{$Pos_L}
$startUp_txt:=""


GET USER PROPERTIES:C611($UserID_L; $name_txt; $startUp_txt; $Password_txt; $NumberLogins_L; $LastLogin_D)
If ($dbg)  // We only use for debugging
	$Doc_tm:=Append document:C265($path_txt)
	$debug_txt:="Starting user properties"+"\n"+\
		"$name_txt "+$name_txt+"\n"+\
		"$startUp_txt "+$startUp_txt+"\n"+\
		"$NumberLogins_L "+String:C10($NumberLogins_L)+"\n"+\
		"$LastLogin_D "+String:C10($LastLogin_D)+"\n\n"
	
	SEND PACKET:C103($Doc_tm; $debug_txt)
	CLOSE DOCUMENT:C267($Doc_tm)
	
	VARIABLE TO BLOB:C532($debug_txt; $debug_blb; *)
	
End if 
C_LONGINT:C283($Return_L)
C_BOOLEAN:C305(4DError_b)
4DError_b:=False:C215
ON ERR CALL:C155("4D_Errors")
$Return_L:=Set user properties:C612($UserID_L; $CurrentUser_txt; $startUp_txt; $ConfirmPassword_txt; $NumberLogins_L; $LastLogin_D)
ON ERR CALL:C155("")

If (($Return_L=$UserID_L) & Not:C34(4DError_b))
	
	If ($dbg)  // We only use for debugging
		$Doc_tm:=Append document:C265($path_txt)
		$debug_txt:="Set user properties : OK =1"+"\n\n"
		SEND PACKET:C103($Doc_tm; $debug_txt)
		CLOSE DOCUMENT:C267($Doc_tm)
		VARIABLE TO BLOB:C532($debug_txt; $debug_blb; *)
		
	End if 
	$ConfirmPassword_txt:=""
	GET USER PROPERTIES:C611($UserID_L; $name_txt; $startUp_txt; $ConfirmPassword_txt; $NumberLogins_L; $LastLogin_D)
	$CurrentUser_txt:=Current user:C182
	If ($dbg)  // We only use for debugging
		$Doc_tm:=Append document:C265($path_txt)
		$debug_txt:="User properties after set "+"\n"+\
			"$UserID_L "+String:C10($UserID_L)+"\n"+\
			"$name_txt "+$name_txt+"\n"+\
			"$startUp_txt "+$startUp_txt+"\n"+\
			"$CurrentUser_txt "+$CurrentUser_txt+"\n"+\
			"$NumberLogins_L "+String:C10($NumberLogins_L)+"\n"+\
			"$LastLogin_D "+String:C10($LastLogin_D)+"\n"
		
		SEND PACKET:C103($Doc_tm; $debug_txt)
		
		CLOSE DOCUMENT:C267($Doc_tm)
		VARIABLE TO BLOB:C532($debug_txt; $debug_blb; *)
	End if 
	
Else 
	
	If ($dbg)  // We only use for debugging
		$Doc_tm:=Append document:C265($path_txt)
		$debug_txt:=ut_ArrayToText(->SQL_InternalDescriptions_atxt; "\n")
		
		SEND PACKET:C103($Doc_tm; $debug_txt)
		
		CLOSE DOCUMENT:C267($Doc_tm)
		VARIABLE TO BLOB:C532($debug_txt; $debug_blb; *)
	End if 
	
End if 

VARIABLE TO BLOB:C532($Return_L; Return_blb; *)
VARIABLE TO BLOB:C532($debug_blb; Return_blb; *)

$0:=Return_blb

//End FN_SetPassword