//%attributes = {"invisible":true}
//Method: ut_LimitLength
//Description
//
//ut_limitLength(self;size)
//Used for string variables where length is no longer set by 4D (Only needed for input forms)
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 02/20/18, 17:04:33
	// ----------------------------------------------------
	//Created : 
	Mods_2018_02
	Mods_2018_05  //Fix defect where if fewer characters not allowed
End if 
C_POINTER:C301($1; $Field_Ptr)
C_LONGINT:C283($2; $MaxChars_l)

C_TEXT:C284($CurrentValue_txt)

$Field_Ptr:=$1
$MaxChars_l:=$2

Case of 
	: (Form event code:C388=On After Edit:K2:43)
		If ($MaxChars_l>0)
			$CurrentValue_txt:=Get edited text:C655
			
			Case of 
				: (Length:C16($CurrentValue_txt)>$MaxChars_l)
					Self:C308->:=Substring:C12($CurrentValue_txt; 1; $MaxChars_l)
					BEEP:C151
					
					
				: (Length:C16($CurrentValue_txt)=0)
					Self:C308->:=""
					BEEP:C151
				Else 
					Self:C308->:=Substring:C12($CurrentValue_txt; 1; $MaxChars_l)
			End case 
		End if 
End case 
//End ut_LimitLength