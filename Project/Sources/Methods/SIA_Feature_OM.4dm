//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/14/08, 11:46:03
	// ----------------------------------------------------
	// Method: SIA_Feature_OM
	// Description
	// Object method for the Feature pulldown object in the various SIA and secondary record input forms.
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2008_CM_5403
	// Modified by: costasmanousakis-(Designer)-(9/10/08 09:01:34)
	Mods_2008_CM_5404
	//  `Fixed a bug in compiled where the case of I, ST, and US was not handled properly
	//  `causing runtime errors
	// Modified by: costasmanousakis-(Designer)-(2/24/10 15:46:31)
	Mods_2010_02
	//  `Fixed a bug where for a new record the route variable was not getting unlocked for I,US,ST features
	//  `on the first go around.
End if 
C_POINTER:C301($1; $Field_ptr; $2; $FDescrA_ptr; $3; $FDescrV_ptr; $4; $FCodesA_ptr; $5; $RteNumV_ptr)
C_POINTER:C301($6; $SuffixV_ptr; $7; $DescrV_ptr)
$Field_ptr:=$1
$FDescrA_ptr:=$2
$FDescrV_ptr:=$3
$FCodesA_ptr:=$4
$RteNumV_ptr:=$5
$SuffixV_ptr:=$6
$DescrV_ptr:=$7
C_LONGINT:C283($FormEvent)
If (Count parameters:C259>7)
	C_LONGINT:C283($8)
	$FormEvent:=$8
Else 
	$FormEvent:=Form event code:C388
End if 

C_TEXT:C284($Prefix)  // Command Replaced was o_C_STRING length was 5
C_TEXT:C284($code)  // Command Replaced was o_C_STRING length was 5
C_TEXT:C284($R2v7Rte)  // Command Replaced was o_C_STRING length was 3

REDRAW:C174($FDescrA_ptr->)
C_LONGINT:C283($FDescrAIndx_L)
$FDescrAIndx_L:=$FDescrA_ptr->
If ((Form event code:C388=On Clicked:K2:4) & ($FDescrA_ptr->>0))
	$FDescrV_ptr->:=$FDescrA_ptr->{$FDescrAIndx_L}
End if 
Case of 
	: (($FormEvent=On Load:K2:1) | ($FDescrA_ptr->=0))
		$FDescrA_ptr->:=Find in array:C230($FCodesA_ptr->; Substring:C12($Field_ptr->; 1; 5))
		If ($FDescrA_ptr-><=0)  //Just in case nothing was found in array
			$FDescrA_ptr->:=0
			If ((Substring:C12($Field_ptr->; 1; 2)="I ") | (Substring:C12($Field_ptr->; 1; 2)="ST") | (Substring:C12($Field_ptr->; 1; 2)="US"))
				$FDescrA_ptr->:=Find in array:C230($FCodesA_ptr->; (Substring:C12($Field_ptr->; 1; 2)+"   "))
				$FDescrV_ptr->:=Substring:C12($Field_ptr->; 1; 2)
			Else 
				$FDescrV_ptr->:="Select Code..."
				$FDescrA_ptr->{0}:="?????"
			End if 
		Else 
			$FDescrV_ptr->:=$FDescrA_ptr->{$FDescrAIndx_L}
		End if 
		$Prefix:=Substring:C12($Field_ptr->; 1; 2)
		If (($Prefix="I ") | ($Prefix="US") | ($Prefix="ST"))
			OBJECT SET ENTERABLE:C238($RteNumV_ptr->; True:C214)
			OBJECT SET RGB COLORS:C628($RteNumV_ptr->; Col_paletteToRGB(Abs:C99(<>Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Editable)\256))  // **Replaced o OBJECT SET COLOR($RteNumV_ptr->; <>Color_Editable)
		Else 
			OBJECT SET ENTERABLE:C238($RteNumV_ptr->; False:C215)
			OBJECT SET RGB COLORS:C628($RteNumV_ptr->; Col_paletteToRGB(Abs:C99(<>Color_Not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_editable)\256))  // **Replaced o OBJECT SET COLOR($RteNumV_ptr->; <>Color_Not_editable)
		End if 
		If ($Prefix="ST")
			OBJECT SET ENABLED:C1123($SuffixV_ptr->; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		Else 
			OBJECT SET ENABLED:C1123($SuffixV_ptr->; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		End if 
		If ($FormEvent=On Load:K2:1)
			$prefix:=Substring:C12($Field_ptr->; 1; 5)
			Case of 
				: (($prefix="WATER") | ($prefix="OTHER") | ($prefix="MBTA ") | ($prefix="COMB ") | ($prefix="HWY  ") | ($prefix="RR   "))
					$RteNumV_ptr->:=""
				: (($prefix="I @") | ($prefix="ST@") | ($prefix="US@"))
					$RteNumV_ptr->:=Substring:C12($Field_ptr->; 3; 3)
				Else 
					$RteNumV_ptr->:=""
			End case 
			If ($prefix="ST@")
				If (Substring:C12($Field_ptr->; 8; 1)="/")
					$SuffixV_ptr->:=1
				Else 
					$SuffixV_ptr->:=0
				End if 
			Else 
				$SuffixV_ptr->:=0
			End if 
			$DescrV_ptr->:=Substring:C12($Field_ptr->; 7; 18)
		End if 
		
	: ($FormEvent=On Clicked:K2:4)
		If (Length:C16($Field_ptr->)>0)
			$Field_ptr->:=Change string:C234($Field_ptr->; $FCodesA_ptr->{$FDescrAIndx_L}; 1)
		Else 
			$Field_ptr->:=$FCodesA_ptr->{$FDescrAIndx_L}
		End if 
		
		$Prefix:=Substring:C12($Field_ptr->; 1; 5)
		// Added 10-16-00    
		If ($Prefix#"ST   ")
			$SuffixV_ptr->:=0
			If (Substring:C12($DescrV_ptr->; 2; 1)="/")
				$DescrV_ptr->:=Delete string:C232($DescrV_ptr->; 1; 2)
			End if 
			If (Substring:C12($DescrV_ptr->; 2; 1)#"/")
				$DescrV_ptr->:=Insert string:C231($DescrV_ptr->; ""; 1)
			End if 
		End if 
		// End of addition on 10-16-00   
		If (($Prefix="I    ") | ($Prefix="US   ") | ($Prefix="ST   "))
			OBJECT SET ENTERABLE:C238($RteNumV_ptr->; True:C214)
			OBJECT SET RGB COLORS:C628($RteNumV_ptr->; Col_paletteToRGB(Abs:C99(<>Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Editable)\256))  // **Replaced o OBJECT SET COLOR($RteNumV_ptr->; <>Color_Editable)
			GOTO OBJECT:C206($RteNumV_ptr->)
			If ($Prefix="ST   ")
				OBJECT SET ENABLED:C1123($SuffixV_ptr->; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			Else 
				OBJECT SET ENABLED:C1123($SuffixV_ptr->; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			End if 
			
			$code:=Substring:C12($FDescrV_ptr->; 1; 2)
			$R2v7Rte:=Replace string:C233(Replace string:C233($RteNumV_ptr->; " "; ""); "_"; "")
			If (Length:C16($R2v7Rte)=1)
				$Field_ptr->:=$Code+"  "+$R2v7Rte+" "+$DescrV_ptr->
			End if 
			If (Length:C16($R2v7Rte)=2)
				$Field_ptr->:=$Code+" "+$R2v7Rte+" "+$DescrV_ptr->
			End if 
			If (Length:C16($R2v7Rte)=3)
				$Field_ptr->:=$Code+$R2v7Rte+" "+$DescrV_ptr->
			End if 
			If (Length:C16($R2v7Rte)=0)
				$Field_ptr->:=$Code+"    "+$DescrV_ptr->
			End if 
		Else 
			$RteNumV_ptr->:="   "
			OBJECT SET ENTERABLE:C238($RteNumV_ptr->; False:C215)
			OBJECT SET RGB COLORS:C628($RteNumV_ptr->; Col_paletteToRGB(Abs:C99(<>Color_Not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_editable)\256))  // **Replaced o OBJECT SET COLOR($RteNumV_ptr->; <>Color_Not_editable)
			OBJECT SET ENABLED:C1123($SuffixV_ptr->; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			$Field_ptr->:=Substring:C12($FDescrV_ptr->; 1; 5)+" "+$DescrV_ptr->
		End if 
		PushChange(1; $Field_ptr)
End case 