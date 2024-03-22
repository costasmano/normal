//%attributes = {"invisible":true}
//Method: ut_WindowSize
//Description
//  ` Get curr window size and match window size to a previous dim
// Parameters
// $1 : $Task_txt "GET" | "MATCH" | "FITFORM" 
// $2 : $WindowW_ptr
// $3 : $WindowH_ptr
// $4 : $Tbl_ptr (optional)
// $5 : $FormName_txt (optional - required if $4 is passed)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/06/13, 09:31:51
	// ----------------------------------------------------
	//Created : 
	Mods_2013_06
End if 
//
C_TEXT:C284($1; $Task_txt)
$Task_txt:=$1
C_POINTER:C301($2; $WindowW_ptr)
$WindowW_ptr:=$2
C_POINTER:C301($3; $WindowH_ptr)
$WindowH_ptr:=$3

C_LONGINT:C283($WL; $WT; $WR; $WB; $WW; $WH; $NWW; $NWH)

Case of 
	: ($Task_txt="GET")
		GET WINDOW RECT:C443($WL; $WT; $WR; $WB)  //get current window size
		$WW:=$WR-$WL
		$WH:=$WB-$WT
		$WindowW_ptr->:=$WW
		$WindowH_ptr->:=$WH
		
	: ($Task_txt="MATCH")
		
		$WW:=$WindowW_ptr->
		$WH:=$WindowH_ptr->
		
		GET WINDOW RECT:C443($WL; $WT; $WR; $WB)  // get new window size
		$NWW:=$WR-$WL
		$NWH:=$WB-$WT
		
		//check sizes - resize only if the new w and/or ht are less than the previous
		If ($NWW<$WW)
			$NWW:=$WW-$NWW
		Else 
			$NWW:=0
		End if 
		
		If ($NWH<$WH)
			$NWH:=$WH-$NWH
		Else 
			$NWH:=0
		End if 
		//reset the window if necessary
		If (($NWH+$NWW)>0)
			SET WINDOW RECT:C444($WL; $WT; ($WR+$NWW); ($WB+$NWH))
		End if 
		
	: ($Task_txt="FITFORM")
		C_POINTER:C301($4; $Tbl_ptr)
		$Tbl_ptr:=$4
		C_TEXT:C284($5; $formName_txt)
		$formName_txt:=$5
		C_LONGINT:C283($frmW_L; $frmH_L)
		FORM GET PROPERTIES:C674($Tbl_ptr->; $formName_txt; $frmW_L; $frmH_L)  //get form w and h
		
		GET WINDOW RECT:C443($WL; $WT; $WR; $WB)  //get current window size
		$WW:=$WR-$WL
		$WH:=$WB-$WT
		
		//check size - apply change only if needed
		If ($frmW_L>$WW)
			$NWW:=$frmW_L-$WW
		Else 
			$NWW:=0
		End if 
		If ($frmH_L>$WH)
			$NWH:=$frmH_L-$WH
		Else 
			$NWH:=0
		End if 
		
		If (($NWW+$NWH)>0)
			SET WINDOW RECT:C444($WL; $WT; ($WR+$NWW); ($WB+$NWH))
		End if 
		
End case 

//End ut_WindowSize