//%attributes = {"invisible":true}
//----------------------------------------------
// PRJ_LoadPage2Bins
// User name (OS): cjmiller
// Date and time: 04/07/06, 14:41:03
//----------------------------------------------
// Description
// 
//
// Parameters
//----------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_2006_CJMv2  //03/29/07, 10:39:25`Modify to use new method for selecting new / existing bins
	Mods_2007_CJMv2  //04/19/07, 09:52:19`Make bin select dd visible or invisible
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
C_LONGINT:C283($Loc_l; $Loop_l)
ARRAY TEXT:C222(PRJ_SelectedBins_as; 0)  //Command Replaced was o_ARRAY string length was 3
C_TEXT:C284($PRJ_ExistingBins_txt; $PRJ_NewBins_txt; $PRJ_SelectedBins_txt; PRJ_SelectedBins_txt; $PRJ_PrimaryExistingBins_txt; $PRJ_PrimaryNewBins_txt)
$PRJ_ExistingBins_txt:=""
$PRJ_NewBins_txt:=""
PRJ_SetUpPrimaryBinDD
$Loc_l:=Find in array:C230(PRJ_SelectedBins_as; [PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34)
If ($Loc_l<1)
	PRJ_SelectedBins_as:=0
Else 
	PRJ_SelectedBins_as:=$Loc_l
End if 
PRJ_SelectedBins_txt:=""
QUERY:C277([PRJ_ProjectDetailsIncludedBINS:122]; [PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectID_l:1=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1)

If (Records in selection:C76([PRJ_ProjectDetailsIncludedBINS:122])>0)
	
	ORDER BY:C49([PRJ_ProjectDetailsIncludedBINS:122]; [PRJ_ProjectDetailsIncludedBINS:122]PDB_BIN_s:2; <)
	
	ARRAY TEXT:C222($PRJ_SelectedBins_atxt; 0)
	ARRAY BOOLEAN:C223($NewBins_ab; 0)
	SELECTION TO ARRAY:C260([PRJ_ProjectDetailsIncludedBINS:122]PDB_BIN_s:2; $PRJ_SelectedBins_atxt; [PRJ_ProjectDetailsIncludedBINS:122]PDB_NewBIN_b:4; $NewBins_ab)
	
	For ($Loop_l; 1; Size of array:C274($PRJ_SelectedBins_atxt))
		QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=$PRJ_SelectedBins_atxt{$Loop_l})
		$PRJ_SelectedBins_txt:=$PRJ_SelectedBins_atxt{$Loop_l}+" - "+f_TrimStr([Bridge MHD NBIS:1]Item7:65; True:C214; True:C214)+" / "+f_TrimStr([Bridge MHD NBIS:1]Item6A:63; True:C214; True:C214)
		
		If ($PRJ_SelectedBins_atxt{$Loop_l}=[PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34)
			If ($NewBins_ab{$Loop_l})
				$PRJ_PrimaryNewBins_txt:=$PRJ_SelectedBins_txt
			Else 
				$PRJ_PrimaryExistingBins_txt:=$PRJ_SelectedBins_txt
			End if 
			
		Else 
			If ($NewBins_ab{$Loop_l})
				If ($PRJ_NewBins_txt="")
					$PRJ_NewBins_txt:=$PRJ_SelectedBins_txt
				Else 
					$PRJ_NewBins_txt:=$PRJ_NewBins_txt+Char:C90(Carriage return:K15:38)+$PRJ_SelectedBins_txt
				End if 
			Else 
				If ($PRJ_ExistingBins_txt="")
					$PRJ_ExistingBins_txt:=$PRJ_SelectedBins_txt
				Else 
					$PRJ_ExistingBins_txt:=$PRJ_ExistingBins_txt+Char:C90(Carriage return:K15:38)+$PRJ_SelectedBins_txt
				End if 
				
			End if 
			
		End if 
	End for 
	Case of 
		: ($PRJ_ExistingBins_txt="") & ($PRJ_PrimaryExistingBins_txt="")
		: ($PRJ_ExistingBins_txt="") & ($PRJ_PrimaryExistingBins_txt#"")
			$PRJ_ExistingBins_txt:=$PRJ_PrimaryExistingBins_txt
		: ($PRJ_ExistingBins_txt#"") & ($PRJ_PrimaryExistingBins_txt="")
			$PRJ_ExistingBins_txt:=$PRJ_ExistingBins_txt+Char:C90(Carriage return:K15:38)
		Else 
			$PRJ_ExistingBins_txt:=$PRJ_PrimaryExistingBins_txt+Char:C90(Carriage return:K15:38)+$PRJ_ExistingBins_txt
	End case 
	If (Length:C16($PRJ_ExistingBins_txt)>0)
		
		If (Character code:C91($PRJ_ExistingBins_txt[[Length:C16($PRJ_ExistingBins_txt)]])=13)
		Else 
			$PRJ_ExistingBins_txt:=$PRJ_ExistingBins_txt+Char:C90(Carriage return:K15:38)
		End if 
	End if 
	Case of 
		: ($PRJ_NewBins_txt="") & ($PRJ_PrimaryNewBins_txt="")
		: ($PRJ_NewBins_txt="") & ($PRJ_PrimaryNewBins_txt#"")
			$PRJ_NewBins_txt:=$PRJ_PrimaryNewBins_txt
		: ($PRJ_NewBins_txt#"") & ($PRJ_PrimaryNewBins_txt="")
			$PRJ_NewBins_txt:=$PRJ_NewBins_txt+Char:C90(Carriage return:K15:38)
		Else 
			$PRJ_NewBins_txt:=$PRJ_PrimaryNewBins_txt+Char:C90(Carriage return:K15:38)+$PRJ_NewBins_txt
	End case 
	If (Length:C16($PRJ_NewBins_txt)>0)
		
		If (Character code:C91($PRJ_NewBins_txt[[Length:C16($PRJ_NewBins_txt)]])=13)
		Else 
			$PRJ_NewBins_txt:=$PRJ_NewBins_txt+Char:C90(Carriage return:K15:38)
		End if 
	End if 
	PRJ_SelectedBins_txt:=""
	If ($PRJ_ExistingBins_txt#"")
		PRJ_SelectedBins_txt:="Existing: "+Char:C90(Carriage return:K15:38)+$PRJ_ExistingBins_txt
	Else 
		PRJ_SelectedBins_txt:="No Existing bins selected yet"
	End if 
	If ($PRJ_NewBins_txt#"")
		PRJ_SelectedBins_txt:=PRJ_SelectedBins_txt+Char:C90(Carriage return:K15:38)+"New: "+Char:C90(Carriage return:K15:38)+$PRJ_NewBins_txt
	Else 
		PRJ_SelectedBins_txt:=PRJ_SelectedBins_txt+Char:C90(Carriage return:K15:38)+"No New Bins selected yet"
	End if 
	
	ARRAY TEXT:C222($PRJ_SelectedBins_atxt; 0)
	ARRAY BOOLEAN:C223($NewBins_ab; 0)
Else 
	$PRJ_NewBins_txt:="No New Bins selected yet"
	$PRJ_ExistingBins_txt:="No Existing bins selected yet"
	PRJ_SelectedBins_txt:=$PRJ_ExistingBins_txt+Char:C90(Carriage return:K15:38)+$PRJ_NewBins_txt
End if 
C_LONGINT:C283($left; $top; $right; $bottom)

OBJECT GET COORDINATES:C663(*; "SelPrimaryBin"; $left; $top; $right; $bottom)
If ($left<281)
Else 
	OBJECT MOVE:C664(*; "SelPrimaryBin@"; -146; 0)
End if 
//End PRJ_LoadPage2Bins