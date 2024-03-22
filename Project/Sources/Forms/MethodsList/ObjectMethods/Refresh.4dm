//Method: MethodsList.Button1
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/29/17, 15:45:07
	// ----------------------------------------------------
	//Created : 
	Mods_2017_08
End if 

//
C_POINTER:C301($dateAfter_ptr; $dateBefore_ptr)
$dateAfter_ptr:=OBJECT Get data source:C1265(*; "DateAfter")
$dateBefore_ptr:=OBJECT Get data source:C1265(*; "DateBefore")
C_DATE:C307($dateAfter_d; $dateBefore_d)
Case of 
	: (Type:C295($dateAfter_ptr->)=Is date:K8:7)
		$dateAfter_d:=$dateAfter_ptr->
	: (Type:C295($dateAfter_ptr->)=Is text:K8:3)
		$dateAfter_d:=Date:C102($dateAfter_ptr->)
		
End case 
Case of 
	: (Type:C295($dateBefore_ptr->)=Is date:K8:7)
		$dateBefore_d:=$dateBefore_ptr->
	: (Type:C295($dateBefore_ptr->)=Is text:K8:3)
		$dateBefore_d:=Date:C102($dateBefore_ptr->)
End case 

DEV_BuildModDateName
C_LONGINT:C283($filterProg_L)

If ($dateAfter_d#!00-00-00!)
	$filterProg_L:=Progress New
	Progress SET TITLE($filterProg_L; "Filtering")
	Progress SET MESSAGE($filterProg_L; "Mod dates on or after "+String:C10($dateAfter_d))
	
	C_LONGINT:C283($loop_L; $TrimFrom_L)
	C_TEXT:C284($dateafter_txt)
	$dateafter_txt:=Substring:C12(String:C10($dateAfter_d; ISO date:K1:8); 1; 10)
	$TrimFrom_L:=0
	For ($loop_L; 1; Size of array:C274(LBGeneric_atxt))
		If (Substring:C12(LBGeneric_atxt{$loop_L}; 1; 10)>=$dateafter_txt)
			$TrimFrom_L:=$loop_L
		Else 
			$loop_L:=Size of array:C274(LBGeneric_atxt)+1
		End if 
		
	End for 
	
	If ($TrimFrom_L>0)
		DELETE FROM ARRAY:C228(LBGeneric_atxt; ($TrimFrom_L+1); Size of array:C274(LBGeneric_atxt))
	End if 
	Progress QUIT($filterProg_L)
	
End if 


If ($dateBefore_d#!00-00-00!)
	$filterProg_L:=Progress New
	Progress SET TITLE($filterProg_L; "Filtering")
	Progress SET MESSAGE($filterProg_L; "Mod dates on or before "+String:C10($dateBefore_d))
	C_LONGINT:C283($loop_L; $TrimFrom_L)
	C_TEXT:C284($dateafter_txt)
	$dateafter_txt:=Substring:C12(String:C10($dateBefore_d; ISO date:K1:8); 1; 10)
	$TrimFrom_L:=0
	For ($loop_L; 1; Size of array:C274(LBGeneric_atxt))
		If (Substring:C12(LBGeneric_atxt{$loop_L}; 1; 10)>$dateafter_txt)
			$TrimFrom_L:=$loop_L
		Else 
			$loop_L:=Size of array:C274(LBGeneric_atxt)+1
		End if 
		
	End for 
	
	If ($TrimFrom_L>0)
		DELETE FROM ARRAY:C228(LBGeneric_atxt; 1; $TrimFrom_L)
	End if 
	
	Progress QUIT($filterProg_L)
	
End if 

C_TEXT:C284($title_txt)
$title_txt:=Get window title:C450
C_LONGINT:C283($countPos_L)
C_BOOLEAN:C305($match_b)
ARRAY LONGINT:C221($posFound_aL; 0)
ARRAY LONGINT:C221($lenFound_aL; 0)

$match_b:=Match regex:C1019("(.*)( \\()(\\d+)(\\))$"; $title_txt; 1; $posFound_aL; $lenFound_aL)
If ($match_b)
	//the main title is the first pattern in the match regex
	$title_txt:=Substring:C12($title_txt; $posFound_aL{1}; $lenFound_aL{1})
End if 

SET WINDOW TITLE:C213($title_txt+" ("+String:C10(Size of array:C274(LBGeneric_atxt))+")")

//End MethodsList.Button1