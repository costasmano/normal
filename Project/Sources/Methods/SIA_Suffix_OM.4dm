//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/30/08, 09:26:00
	// ----------------------------------------------------
	// Method: SIA_Suffix_OM
	// Description
	// object method for the Suffix object in the SIA input forms
	// 
	// Parameters
	// $1 : $Field_ptr
	// $2 : $Suffix_ptr
	// $3 : $FDescr_ptr
	// $4 : $Descr_ptr
	// $5 : $RteNum_ptr
	// $6 : $FormEvent (Optional)
	// ----------------------------------------------------
	
	Mods_2008_CM_5403
End if 
C_POINTER:C301($1; $Field_ptr; $2; $Suffix_ptr; $3; $FDescr_ptr; $4; $Descr_ptr; $5; $RteNum_ptr)
$Field_ptr:=$1
$Suffix_ptr:=$2
$FDescr_ptr:=$3
$Descr_ptr:=$4
$RteNum_ptr:=$5
C_LONGINT:C283($FormEvent)
If (Count parameters:C259>5)
	C_LONGINT:C283($6)
	$FormEvent:=$6
Else 
	$FormEvent:=Form event code:C388
End if 

C_TEXT:C284($Code)  // Command Replaced was o_C_STRING length was 2
C_TEXT:C284($R2vRte)  // Command Replaced was o_C_STRING length was 3
Case of 
		
	: ($FormEvent=On Load:K2:1)
		If (Substring:C12($Field_ptr->; 8; 1)="/")
			$Suffix_ptr->:=1
		End if 
		
	: ($FormEvent=On Clicked:K2:4)
		$Code:=Substring:C12($FDescr_ptr->; 1; 2)
		
		If ($Code="ST")
			If ($Suffix_ptr->=1)
				$Descr_ptr->:=Insert string:C231($Descr_ptr->; "A/"; 1)
			End if 
			If ($Suffix_ptr->=0)
				If (Substring:C12($Descr_ptr->; 2; 1)="/")
					$Descr_ptr->:=Delete string:C232($Descr_ptr->; 1; 2)
				End if 
				If (Substring:C12($Descr_ptr->; 2; 1)#"/")
					$Descr_ptr->:=Insert string:C231($Descr_ptr->; ""; 1)
				End if 
			End if 
		Else 
			$Suffix_ptr->:=0
			If (Substring:C12($Descr_ptr->; 2; 1)="/")
				$Descr_ptr->:=Delete string:C232($Descr_ptr->; 1; 2)
			End if 
			If (Substring:C12($Descr_ptr->; 2; 1)#"/")
				$Descr_ptr->:=Insert string:C231($Descr_ptr->; ""; 1)
			End if 
		End if 
		
		If (($Code="ST") | ($Code="I ") | ($Code="US"))
			$R2vRte:=Replace string:C233(Replace string:C233($RteNum_ptr->; " "; ""); "_"; "")
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
End case 