//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/20/07, 10:10:28
	// ----------------------------------------------------
	// Method: PRJ_BPGM_SearchVar_OM
	// Description
	// 
	// 
	// Parameters
	// $1 : $VarPtr : pointer to search variable
	// ----------------------------------------------------
	
End if 
C_POINTER:C301($1; $SearchVar_Ptr)
$SearchVar_Ptr:=$1
Case of 
	: (Form event code:C388=On Load:K2:1)
		
	: (Form event code:C388=On Data Change:K2:15)
		$SearchVar_Ptr->:=f_TrimStr($SearchVar_Ptr->; True:C214; True:C214)
		If ($SearchVar_Ptr->#"")
			//clear the other values
			PRJ_BPGM_ClearOtherSrch($SearchVar_Ptr)
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		
End case 
