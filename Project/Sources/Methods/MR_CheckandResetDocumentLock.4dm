//%attributes = {"invisible":true}
//Method: MR_CheckandResetDocumentLock($DocumentPathandName_txt)
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 11/22/17, 11:08:25
	// ----------------------------------------------------
	//Created : 
	Mods_2017_11
End if 
C_BOOLEAN:C305($0)

C_TEXT:C284($1; $DocumentPathandName_txt)
$DocumentPathandName_txt:=$1
C_BOOLEAN:C305($2; $ResetToLocked_B)
$ResetToLocked_B:=$2
//
4DError_b:=False:C215
C_BOOLEAN:C305($Locked_B; $Invisible_B)
C_TIME:C306($CreatededAt_tm; $ModifiedAt_tm)
C_DATE:C307($Createdon_d; $ModifiedOn_d)
GET DOCUMENT PROPERTIES:C477($DocumentPathandName_txt; $Locked_B; $Invisible_B; $Createdon_d; $CreatededAt_tm; $ModifiedOn_d; $ModifiedAt_tm)
Case of 
	: (Not:C34($Locked_B) & $ResetToLocked_B)
		$Locked_B:=$ResetToLocked_B
		ON ERR CALL:C155("4D_Errors")
		SET DOCUMENT PROPERTIES:C478($DocumentPathandName_txt; $Locked_B; $Invisible_B; $Createdon_d; $CreatededAt_tm; $ModifiedOn_d; $ModifiedAt_tm)
		ON ERR CALL:C155("")
	: (($Locked_B) & Not:C34($ResetToLocked_B))
		$Locked_B:=False:C215
		ON ERR CALL:C155("4D_Errors")
		SET DOCUMENT PROPERTIES:C478($DocumentPathandName_txt; $Locked_B; $Invisible_B; $Createdon_d; $CreatededAt_tm; $ModifiedOn_d; $ModifiedAt_tm)
		ON ERR CALL:C155("")
	Else 
		
End case 

If (4DError_b)
	C_TEXT:C284($Message_txt)
	C_LONGINT:C283($loop_l)
	For ($loop_l; 1; Size of array:C274(SQL_InternalDescriptions_atxt))
		$Message_txt:=$Message_txt+SQL_InternalDescriptions_atxt{$loop_l}+Char:C90(Carriage return:K15:38)
	End for 
	$Message_txt:="Could not reset lock status for "+$DocumentPathandName_txt+Char:C90(Carriage return:K15:38)+$Message_txt
	ut_BigAlert($Message_txt; "Reset Lock status")
	
End if 
$0:=(4DError_b=False:C215)
//End MR_CheckandResetDocumentLock