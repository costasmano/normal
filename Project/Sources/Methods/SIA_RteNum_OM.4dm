//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/30/08, 09:27:18
	// ----------------------------------------------------
	// Method: SIA_RteNum_OM
	// Description
	// object method for the vRteNum object in the SIA input forms
	// 
	// Parameters
	// $1 : $Field_ptr
	// $2 : $RteNum_ptr
	// $3 : $FDescr_ptr
	// $4 : $Descr_ptr
	// $5 : $FormEvent (Optional)
	// ----------------------------------------------------
	
	Mods_2008_CM_5403
End if 
C_POINTER:C301($1; $Field_ptr; $2; $RteNum_ptr; $3; $FDescr_ptr; $4; $Descr_ptr)
C_TEXT:C284($prefix)  // Command Replaced was o_C_STRING length was 5
C_TEXT:C284($code)  // Command Replaced was o_C_STRING length was 2
C_TEXT:C284($R2v7Rte)  // Command Replaced was o_C_STRING length was 3
$Field_ptr:=$1
$RteNum_ptr:=$2
$FDescr_ptr:=$3
$Descr_ptr:=$4
C_LONGINT:C283($FormEvent)
If (Count parameters:C259>4)
	C_LONGINT:C283($5)
	$FormEvent:=$5
Else 
	$FormEvent:=Form event code:C388
End if 

Case of 
	: ($FormEvent=On Load:K2:1)
		$prefix:=Substring:C12($Field_ptr->; 1; 5)
		
		If (($prefix="WATER") | ($prefix="OTHER") | ($prefix="MBTA ") | ($prefix="COMB ") | ($prefix="HWY  ") | ($prefix="RR   "))
			$RteNum_ptr->:=""
		Else 
			$RteNum_ptr->:=Substring:C12($Field_ptr->; 3; 3)
		End if 
	: ($FormEvent=On Data Change:K2:15)
		$code:=Substring:C12($FDescr_ptr->; 1; 2)
		
		$R2v7Rte:=Replace string:C233(Replace string:C233($RteNum_ptr->; " "; ""); "_"; "")
		If (Length:C16($R2v7Rte)=1)
			$Field_ptr->:=$Code+"  "+$R2v7Rte+" "+$Descr_ptr->
		End if 
		If (Length:C16($R2v7Rte)=2)
			$Field_ptr->:=$Code+" "+$R2v7Rte+" "+$Descr_ptr->
		End if 
		If (Length:C16($R2v7Rte)=3)
			$Field_ptr->:=$Code+$R2v7Rte+" "+$Descr_ptr->
		End if 
		If (Length:C16($R2v7Rte)=0)
			$Field_ptr->:=$Code+"    "+$Descr_ptr->
		End if 
		PushChange(1; $Field_ptr)
End case 