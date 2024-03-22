//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/26/07, 12:36:40
	// ----------------------------------------------------
	// Method: WKHR_ProposalToAssignRemote
	// Description
	// Transfer from the external server to the boston server
	// 
	// Parameters
	// $0 : $TransferOK_b
	// $1 :  $Option_txt : (Update or Clear)
	// ----------------------------------------------------
	
	// Modified by: costasmanousakis-(Designer)-(8/31/2007 11:54:47)
	Mods_2007_CM12_5301
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (9/3/10 15:36:30)
	//Ugrade to v11
	//Modified by: Charles Miller (5/10/11 11:17:35)
End if 
Compiler_FieldVariables
ut_InitFieldArray
COMPILER_forSQL
C_BOOLEAN:C305($0; $TransferOK_b)
C_TEXT:C284($1; $Option_txt)
$Option_txt:=$1
C_TEXT:C284($UserName_txt; $Server; $PasswPrompt_txt; $AssgnAdden_txt; $Password)



$Server:="146.243.135.242"

$UserName_txt:=Current user:C182
$TransferOK_b:=False:C215
$PasswPrompt_txt:=Current user:C182+", you are about to "
Case of 
	: ($Option_txt="Update")
		$PasswPrompt_txt:=$PasswPrompt_txt+"transfer the Work hour data to the Negotiated Costs of "
	: ($Option_txt="Clear")
		$PasswPrompt_txt:=$PasswPrompt_txt+"clear the Negotiated Costs of "
End case 
If ([Work_Estimate:103]AddendumNo:29>0)
	$AssgnAdden_txt:="Addendum"
Else 
	$AssgnAdden_txt:="Assignment"
End if 
$PasswPrompt_txt:=$PasswPrompt_txt+"the "+$AssgnAdden_txt+" on the Boston server."
C_LONGINT:C283($Error_l)
$Error_l:=ut_SQLMakeConnnection(Current user:C182; $Password; $Server; $PasswPrompt_txt)
C_BOOLEAN:C305(InWHKRUpdate_b)
If ($Error_l=1)
	InWHKRUpdate_b:=True:C214
	ut_SQLExecuteNoReturn("START")
	Case of 
		: (ut_CheckForBackup)
			ALERT:C41("Backup up running... "+$Option_txt+" cancelled.")
		: (WKHR_PAREMOTE_Search#1)
			
			//: (Not(OP_ErrorCheck ("Binding";WKHR_PAREMOTE_SetLinks (OP_BindID_L))))
			
		: (Not:C34(WKHR_PAREMOTE_UpdateValues($Option_txt)))
			
			
		Else 
			$TransferOK_b:=True:C214
			
	End case 
	
	If (Not:C34($TransferOK_b))
		ut_SQLExecuteNoReturn("ROLLBACK")
	Else 
		ut_SQLExecuteNoReturn("COMMIT")
	End if 
	
	
Else 
	Case of 
		: ($Error_l=-2)
			ALERT:C41("Tranfer cancelled due to invalid password")
		: ($Error_l=-4)
			ALERT:C41("Tranfer cancelled due to Password entry screen cancelled")
	End case 
End if 
ut_SQLLogout
$0:=$TransferOK_b
