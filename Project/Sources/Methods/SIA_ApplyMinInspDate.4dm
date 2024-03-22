//%attributes = {"invisible":true}
//Method: SIA_ApplyMinInspDate
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/11/18, 16:18:29
	// ----------------------------------------------------
	//Created : 
	Mods_2018_04
End if 
//
C_DATE:C307($Newdate_d)
$Newdate_d:=(Self:C308->)
If ($Newdate_d<Add to date:C393(Current date:C33(*); 0; 0; -35))
	
	CONFIRM:C162("You have entered a date for "+Field name:C257(Self:C308)+\
		" that is more than 35 days ago! Do you want to continue?"; \
		"Continue"; "Revert To Saved: "+String:C10(Old:C35(Self:C308->)))
	If (OK=0)
		Self:C308->:=Old:C35(Self:C308->)
	End if 
End if 

//End SIA_ApplyMinInspDate