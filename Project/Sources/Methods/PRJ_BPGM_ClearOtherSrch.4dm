//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/20/07, 09:52:27
	// ----------------------------------------------------
	// Method: PRJ_BPGM_ClearOtherSrch
	// Description
	// Clear the other variables in the search form. All are assumed to be text/string
	// 
	// Parameters
	// $1 : $ExcludeVar_ptr : pointer to variable to be excluded from cleaning
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(6/18/2007 12:49:02)
	Mods_2007_CM12_5301
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v11
End if 
C_POINTER:C301($1; $ExcludeVar_ptr)
$ExcludeVar_ptr:=$1
C_LONGINT:C283($i)
For ($i; 1; Size of array:C274(PRJ_SRCH_SearchValues_aptr))  //array declared in form method
	If (PRJ_SRCH_SearchValues_aptr{$i}#$ExcludeVar_ptr)
		Case of 
			: (Type:C295(PRJ_SRCH_SearchValues_aptr{$i}->)=Is integer:K8:5)
				PRJ_SRCH_SearchValues_aptr{$i}->:=0
			: (Type:C295(PRJ_SRCH_SearchValues_aptr{$i}->)=Is string var:K8:2)
				PRJ_SRCH_SearchValues_aptr{$i}->:=""
			: (Type:C295(PRJ_SRCH_SearchValues_aptr{$i}->)=Is text:K8:3)
				PRJ_SRCH_SearchValues_aptr{$i}->:=""
			: (Type:C295(PRJ_SRCH_SearchValues_aptr{$i}->)=Is real:K8:4)
				PRJ_SRCH_SearchValues_aptr{$i}->:=0
			: (Type:C295(PRJ_SRCH_SearchValues_aptr{$i}->)=Is date:K8:7)
				PRJ_SRCH_SearchValues_aptr{$i}->:=!00-00-00!
				
		End case 
		
	End if 
	
End for 
If (PRJ_SRCH_StrPrjMgr_s="")
	PRJ_SRCH_StrPrjMgr_atxt:=0
End if 
If (PRJ_SRCH_AttributeKey_txt="")
	PRJ_SRCH_Attributes_atxt:=0
End if 