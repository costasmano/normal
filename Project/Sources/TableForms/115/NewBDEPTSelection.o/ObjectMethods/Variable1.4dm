// ----------------------------------------------------
// Object Method: IncludedBins_txt
// User name (OS): cjmiller
// Date and time: 04/15/08, 14:48:38
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2008_v55  //r004 `04/15/08, 14:48:40     
End if 
Case of 
	: (Form event code:C388=On Display Detail:K2:22)
		QUERY:C277([PRJ_ProjectDetailsIncludedBINS:122]; [PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectID_l:1=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1)
		ARRAY TEXT:C222($allRelBINS_as; 0)  //Command Replaced was o_ARRAY string length was 3
		ARRAY BOOLEAN:C223($NewOld_b; 0)
		SELECTION TO ARRAY:C260([PRJ_ProjectDetailsIncludedBINS:122]PDB_BIN_s:2; $allRelBINS_as; [PRJ_ProjectDetailsIncludedBINS:122]PDB_NewBIN_b:4; $NewOld_b)
		C_LONGINT:C283($i)
		SORT ARRAY:C229($allRelBINS_as; $NewOld_b)
		C_TEXT:C284($NewOnes_txt; $oldOnes_txt)
		$NewOnes_txt:=""
		$oldOnes_txt:=""
		For ($i; 1; Size of array:C274($allRelBINS_as))
			If ($NewOld_b{$i})
				$NewOnes_txt:=$NewOnes_txt+","+$allRelBINS_as{$i}
			Else 
				$oldOnes_txt:=$oldOnes_txt+","+$allRelBINS_as{$i}
			End if 
			
		End for 
		$NewOnes_txt:=Substring:C12($NewOnes_txt; 2)
		$oldOnes_txt:=Substring:C12($oldOnes_txt; 2)
		If ($oldOnes_txt#"")
			$oldOnes_txt:="Exist : "+$oldOnes_txt
			If ($NewOnes_txt#"")
				$oldOnes_txt:=$oldOnes_txt+<>sCR
			End if 
		End if 
		If ($NewOnes_txt#"")
			$NewOnes_txt:="New : "+$NewOnes_txt
		End if 
		
		Self:C308->:=$oldOnes_txt+$NewOnes_txt
End case 

//End Object Method: IncludedBins_txt