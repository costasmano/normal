//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/29/07, 16:32:44
	// ----------------------------------------------------
	// Method: PRJ_LTR_LetterDate
	// Description
	// 
	// 
	// Parameters
	// $1 : $DateFld_Ptr
	// $2 : $DateFldDesc_txt
	// ----------------------------------------------------
	
	Mods_2007_CM12_5302
End if 
C_POINTER:C301($1; $DateFld_Ptr)
C_TEXT:C284($2; $DateFldDesc_txt)
$DateFld_Ptr:=$1
$DateFldDesc_txt:=$2
C_DATE:C307(PRJ_LTR_SKLTRToDE_d)
If ($DateFld_Ptr->=!00-00-00!)
	$DateFld_Ptr->:=Current date:C33(*)
	PRJ_LTR_SKLTRToDE_d:=$DateFld_Ptr->
Else 
	If ($DateFld_Ptr->#Current date:C33(*))
		CONFIRM:C162("Change date of <"+$DateFldDesc_txt+"> to today's date? or use existing date"+" ("+String:C10($DateFld_Ptr->)+")"; "Change"; "Exist")
		If (OK=1)
			$DateFld_Ptr->:=Current date:C33(*)
			PRJ_LTR_SKLTRToDE_d:=$DateFld_Ptr->
		Else 
			PRJ_LTR_SKLTRToDE_d:=$DateFld_Ptr->
		End if 
	End if 
End if 

