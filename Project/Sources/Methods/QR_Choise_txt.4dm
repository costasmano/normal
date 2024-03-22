//%attributes = {"shared":true}
// Method: QR_Choise_txt
// Description (CAN USE 4D command Choose)
// Return a text value from a list based on the first parameter. Must be Gt 0.
// If it is larger than the number of choises passed in the last choise will be returned
// ex.
// $Res_txt := QR_Choise_txt(2;"Opt A";"Opt AA";"Opt AB"; "Opt B"; "Opt BA" ;" Opt BB") - > "Opt AA"
// $Res_txt := QR_Choise_txt(20;"Opt A";"Opt AA";"Opt AB"; "Opt B"; "Opt BA" ;" Opt BB") - > "Opt BB"
// $Res_txt := QR_Choise_txt(0;"Opt A";"Opt AA";"Opt AB"; "Opt B"; "Opt BA" ;" Opt BB") - > ""

// Parameters
// $0: $RetValue_txt
// $1 : $Index_L - must be Gt 0 
// {$2} : Choise texts
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/26/10, 10:59:23
	// ----------------------------------------------------
	
	Mods_2010_05
End if 
C_TEXT:C284($0; $RetValue_txt)
$RetValue_txt:=""
C_LONGINT:C283($1; $Index_L)
$Index_L:=$1
C_TEXT:C284(${2})
If (Count parameters:C259>1)
	If ($Index_L>0)
		If ($Index_L<Count parameters:C259)
			$RetValue_txt:=${$Index_L+1}
		Else 
			$RetValue_txt:=${Count parameters:C259}
		End if 
		
	End if 
	
End if 

$0:=$RetValue_txt