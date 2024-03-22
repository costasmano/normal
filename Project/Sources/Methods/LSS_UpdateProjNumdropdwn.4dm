//%attributes = {"invisible":true}
//Method: LSS_UpdateProjNumdropdwn
//Description
// update the project number dropdown on the list box
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): manousakisc
	//User (4D) : Designer
	//Date and time: 06/14/23, 19:13:21
	// ----------------------------------------------------
	//Created : 
	Mods_2023_LSSNew
End if 
//

C_POINTER:C301($Projnodropdwn_ptr)
C_LONGINT:C283($currIndx_L; $CurrPrjnum_L; $zeroval_L)

$Projnodropdwn_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "LSS_ProjNumdropdwn")
//save current state of dropdown
$currIndx_L:=$Projnodropdwn_ptr->
$CurrPrjnum_L:=$Projnodropdwn_ptr->{$currIndx_L}
$zeroval_L:=$Projnodropdwn_ptr->{0}

ARRAY LONGINT:C221($Projbuilts_aL; 0)
ARRAY LONGINT:C221($projremoved_aL; 0)
C_COLLECTION:C1488($projnobuilt_c; $projnorem_c)
$projnobuilt_c:=ds:C1482.LSS_Inventory.all().distinct("LSS_ProjNoBuilt_L")
$projnorem_c:=ds:C1482.LSS_Inventory.all().distinct("LSS_ProjNoRemoved_L")
//convert to arrays
COLLECTION TO ARRAY:C1562($projnobuilt_c; $Projbuilts_aL)
COLLECTION TO ARRAY:C1562($projnorem_c; $projremoved_aL)
C_LONGINT:C283($loop_L)
For ($loop_L; 1; Size of array:C274($projremoved_aL))
	
	If (Find in array:C230($Projbuilts_aL; $projremoved_aL{$Loop_L})<1)
		APPEND TO ARRAY:C911($Projbuilts_aL; $projremoved_aL{$Loop_L})
	End if 
End for 
SORT ARRAY:C229($Projbuilts_aL)
If ($Projbuilts_aL{1}=0)
	DELETE FROM ARRAY:C228($Projbuilts_aL; 1; 1)
End if 
INSERT IN ARRAY:C227($Projbuilts_aL; 0; 2)
$Projbuilts_aL{1}:=-1  //a negative number displays as "ALL"
$Projbuilts_aL{2}:=0  // zero displays as "Any project"

COPY ARRAY:C226($Projbuilts_aL; $Projnodropdwn_ptr->)

Case of 
	: ($currIndx_L=0)
		$Projnodropdwn_ptr->:=0  // nothing was selected
		$Projnodropdwn_ptr->{0}:=-10  // set it to a value not in the dropdown
	: ($currIndx_L<=2)
		$Projnodropdwn_ptr->:=$currIndx_L
		$Projnodropdwn_ptr->{0}:=$CurrPrjnum_L
	Else 
		If (Find in array:C230($Projbuilts_aL; $CurrPrjnum_L)>0)
			//previously selected proj num is in current list
			$Projnodropdwn_ptr->:=Find in array:C230($Projbuilts_aL; $CurrPrjnum_L)  //select the same
			$Projnodropdwn_ptr->{0}:=$CurrPrjnum_L  // and save as zero element
		Else 
			//the proj num has been removed - clear all
			$Projnodropdwn_ptr->:=0  // nothing was selected
			$Projnodropdwn_ptr->{0}:=-10  // set it to a value not in the dropdown
			
		End if 
End case 


//End LSS_UpdateProjNumdropdwn