//%attributes = {"invisible":true,"executedOnServer":true}
//Method: PRJ_ReturnFileNumber
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 06/13/19, 14:49:31
	// ----------------------------------------------------
	//Created : 
	Mods_2019_06
End if 
//

C_LONGINT:C283($0; $1; $PRJ_DEProjectFileNo_l; $PRJ_PFFileID_L)
$PRJ_PFFileID_L:=$1
Begin SQL
	select [PRJ_ProjectFile].[PF_FileNumber_l] 
	FROM [PRJ_ProjectFile] WHERE
	[PRJ_ProjectFile].[PF_FileID_l] = :$PRJ_PFFileID_L
	INTO :$PRJ_DEProjectFileNo_l
End SQL
$0:=$PRJ_DEProjectFileNo_l
//End PRJ_ReturnFileNumber