//%attributes = {"invisible":true}
If (False:C215)
	//G_InspConsCompany
	
	Mods_2005_CM07
	// Modified by: costasmanousakis-(Designer)-(11/18/10 16:16:28)
	Mods_2010_11
	//  `Chnaged logic of cleaning up the company name-use a while loop;
	//  `Increased limit to 25 chars from 20 ;  added a call to G_FitPrintObject
End if 
C_TEXT:C284(vConsQCCompany; $vStripped_str)  // Command Replaced was o_C_STRING length was 80
vConsQCCompany:=[Inspections:27]Agency:156
vConsQCCompany:=Replace string:C233(vConsQCCompany; ","; " ")
vConsQCCompany:=Replace string:C233(vConsQCCompany; "-"; " ")
vConsQCCompany:=Replace string:C233(vConsQCCompany; "/"; " ")
vConsQCCompany:=Replace string:C233(vConsQCCompany; "."; " ")
vConsQCCompany:=Replace string:C233(vConsQCCompany; "&"; " ")
vConsQCCompany:=(Replace string:C233(vConsQCCompany; "  "; " "))
C_LONGINT:C283($i; $j; $vLastSpace_L)
$i:=Position:C15("  "; vConsQCCompany)
While ($i>0)
	vConsQCCompany:=(Replace string:C233(vConsQCCompany; "  "; " "))
	$i:=Position:C15("  "; vConsQCCompany)
End while 

While (Length:C16(vConsQCCompany)>25)
	$vLastSpace_L:=-1
	For ($j; Length:C16(vConsQCCompany); 1; -1)
		If (Substring:C12(vConsQCCompany; $j; 1)=" ")
			$vLastSpace_L:=$j
			$j:=0
		End if 
		
	End for 
	If ($vLastSpace_L>0)
		vConsQCCompany:=Substring:C12(vConsQCCompany; 1; ($vLastSpace_L-1))
	End if 
	
End while 
G_FitPrintObject(->vConsQCCompany; 7; 6; 0)