//%attributes = {"invisible":true}
// Method: SIA_Description_OM
// Description
// Object method for the Description object in the various SIA and secondary record input forms
// 
// Parameters
// $1 : $Field_ptr
// $2 : $RteNum_ptr
// $3 : $FDescr_ptr
// $4 : $Descr_ptr
// $5 : $FormEvent (Optional)
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/30/08, 09:24:45
	// ----------------------------------------------------
	
	Mods_2008_CM_5403
	// Modified by: Costas Manousakis-(Designer)-(10/18/19 17:05:44)
	Mods_2019_10_bug
	//  `dont make change to the field, if a valid code has not been selected.
End if 
C_POINTER:C301($1; $Field_ptr; $2; $RteNum_ptr; $3; $FDescr_ptr; $4; $Descr_ptr)
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

C_TEXT:C284($code)  // **Replaced old C_STRING length 2
C_TEXT:C284($R2vRte)  // **Replaced old C_STRING length 3

Case of 
	: ($FormEvent=On Load:K2:1)
		$Descr_ptr->:=Substring:C12($Field_ptr->; 7; 18)
	: ($FormEvent=On Data Change:K2:15)
		
		If ($FDescr_ptr->="Select Code@")
			//Do nothing if there is no code selected - make sure the field is blank
			$Field_ptr->:=""
		Else 
			$code:=Substring:C12($FDescr_ptr->; 1; 2)
			If (($code="I ") | ($code="ST") | ($code="US"))
				
				$R2vrte:=Replace string:C233(Replace string:C233($RteNum_ptr->; " "; ""); "_"; "")
				If (Length:C16($R2vrte)=1)
					$Field_ptr->:=$Code+"  "+$R2vrte+" "+$Descr_ptr->
				End if 
				If (Length:C16($R2vrte)=2)
					$Field_ptr->:=$Code+" "+$R2vrte+" "+$Descr_ptr->
				End if 
				If (Length:C16($R2vrte)=3)
					$Field_ptr->:=$Code+$R2vrte+" "+$Descr_ptr->
				End if 
				If (Length:C16($R2vrte)=0)
					$Field_ptr->:=$Code+"    "+$Descr_ptr->
				End if 
			Else 
				$Field_ptr->:=Substring:C12($FDescr_ptr->; 1; 5)+" "+$Descr_ptr->
			End if 
			PushChange(1; $Field_ptr)
			
		End if 
		
End case 