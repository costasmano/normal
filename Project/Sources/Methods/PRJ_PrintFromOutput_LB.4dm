//%attributes = {"invisible":true}
//Method: PRJ_PrintFromOutput_LB
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 11/17/20, 14:42:55
	// ----------------------------------------------------
	//Created : 
	Mods_2020_11
	
	C_POINTER:C301(PRJ_PrintFromOutput_LB; $1)
	C_TEXT:C284(PRJ_PrintFromOutput_LB; $2; $3)
	
End if 
//
C_POINTER:C301($1; $Table_ptr)
$Table_ptr:=$1
C_TEXT:C284($2; $FormName_txt; $3; $ListBoxName_txt)
$FormName_txt:=$2
$ListBoxName_txt:=$3

C_TEXT:C284($menuChoise_txt)
C_BOOLEAN:C305($Exporting_b)

If (Shift down:C543)
	$menuChoise_txt:="Projis Update"
	$Exporting_b:=True:C214
Else 
	$menuChoise_txt:="Projis Update;Summary Page"
	$Exporting_b:=False:C215
End if 
$menuChoise_txt:=$menuChoise_txt+";Print ListBox"
C_LONGINT:C283($UserChoice_L)
If (Records in selection:C76([PRJ_ProjectDetails:115])>0)
	
	$UserChoice_L:=Pop up menu:C542($menuChoise_txt)
	Case of 
		: ($UserChoice_L=1)
			If ($Exporting_b)
				PRJ_ExpProjUpdate
			Else 
				PRJ_PrintProjisUpdate
			End if 
			
		: ($UserChoice_L=2)
			PRJ_PrintSummarySht
		: ($UserChoice_L=3)
			
		Else 
	End case 
	
Else 
	ALERT:C41("There are no Projects Listed!")
End if 
//End PRJ_PrintFromOutput_LB