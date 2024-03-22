//%attributes = {"invisible":true}
//Method: NTI_CalculateRating
//Description
// calculate element rating based on quantities in CSs and total quantity
// uses dom TREE NTI_CSWTFACTORSTREE_txt
// Parameters
// $0 : $Rating_L
// $1 : $TotQ_r
// $2 : $CS1_r
// $3 : $CS2_r
// $4 : $CS3_r
// $5 : $CS4_r

// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/12/18, 15:53:00
	// ----------------------------------------------------
	//Created : 
	Mods_2018_01
	//
	C_LONGINT:C283(NTI_CalculateRating; $0)
	C_REAL:C285(NTI_CalculateRating; $1)
	C_REAL:C285(NTI_CalculateRating; $2)
	C_REAL:C285(NTI_CalculateRating; $3)
	C_REAL:C285(NTI_CalculateRating; $4)
	C_REAL:C285(NTI_CalculateRating; $5)
	
End if 
//
C_LONGINT:C283($0)
C_REAL:C285($1; $2; $3; $4; $5)
$0:=-1  //-1 signals some error
If (NTI_CSWTFACTORSTREE_txt#"")  //check if it is defined
	C_LONGINT:C283($CS_L)
	C_TEXT:C284($CSBranch_txt)
	ARRAY REAL:C219($CSWts_ar; 4)
	C_TEXT:C284($prevOnErrCall_txt)
	$prevOnErrCall_txt:=Method called on error:C704
	4DError_b:=False:C215
	ON ERR CALL:C155("4D_Errors")
	For ($CS_L; 1; 4)
		
		$CSBranch_txt:=DOM Find XML element:C864(NTI_CSWTFACTORSTREE_txt; "NTI_CSWTFACTORS/CS"+String:C10($CS_L))
		DOM GET XML ATTRIBUTE BY NAME:C728($CSBranch_txt; "WEIGHT"; $CSWts_ar{$CS_L})
	End for 
	ON ERR CALL:C155($prevOnErrCall_txt)
	C_REAL:C285($CondRating_r)
	If (Not:C34(4DError_b))
		$CondRating_r:=($2*$CSWts_ar{1})+($3*$CSWts_ar{2})+($4*$CSWts_ar{3})+($5*$CSWts_ar{4})
		$CondRating_r:=$CondRating_r/$1
		$CondRating_r:=Round:C94($CondRating_r; 0)
		$0:=$CondRating_r
	End if 
	
End if 

//End NTI_CalculateRating