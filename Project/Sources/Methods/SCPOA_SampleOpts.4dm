//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/30/11, 19:16:04
	// ----------------------------------------------------
	// Method: SCPOA_SampleOpts
	// Description
	// 
	// 
	// Parameters
	// $1 : $ValuesArray_ptr
	// $2 : $FieldVar_ptr
	// $3 : $OtherVar_ptr
	// $4 : $CheckBoxArr_ptr
	// $5 : $VarName_txt
	// $6 : $FormEvent (Optional)
	// ----------------------------------------------------
	
	Mods_2011_05
End if 
C_POINTER:C301($1; $ValuesArray_ptr; $2; $FieldVar_ptr; $3; $OtherVar_ptr; $4; $CheckBoxArr_ptr)
C_TEXT:C284($5; $VarName_txt)
C_LONGINT:C283($FormEvent)
If (Count parameters:C259>5)
	C_LONGINT:C283($6)
	$FormEvent:=$6
Else 
	$FormEvent:=Form event code:C388
End if 

$ValuesArray_ptr:=$1
$FieldVar_ptr:=$2
$OtherVar_ptr:=$3
$CheckBoxArr_ptr:=$4
$VarName_txt:=$5
C_LONGINT:C283($index_l)
Case of 
	: ($FormEvent=On Load:K2:1)
		$index_l:=Find in array:C230($ValuesArray_ptr->; $FieldVar_ptr->)
		If (($index_l<=0) & ($FieldVar_ptr->#""))
			$index_l:=Find in array:C230($ValuesArray_ptr->; "Other")
			$OtherVar_ptr->:=$FieldVar_ptr->
		End if 
		
		If (($index_l<=0) & ($FieldVar_ptr->=""))
			$ValuesArray_ptr->:=0
			SCPOA_SetEnterable_Var($OtherVar_ptr; False:C215)
		Else 
			$ValuesArray_ptr->:=$index_l
			If (($ValuesArray_ptr->{$index_l}="Other") & SCPOA_EditRecord_b)
				SCPOA_SetEnterable_Var($OtherVar_ptr; True:C214)
			Else 
				SCPOA_SetEnterable_Var($OtherVar_ptr; False:C215)
			End if 
			
		End if 
		SCPOA_Array2CkBoxArr($index_l; $CheckBoxArr_ptr)
	: ($FormEvent=On Clicked:K2:4)
		
		$index_l:=$ValuesArray_ptr->
		If ($index_l>0)
			$FieldVar_ptr->:=$ValuesArray_ptr->{$index_l}
			
			If ($ValuesArray_ptr->{$index_l}="Other")
				SCPOA_SetEnterable_Var($OtherVar_ptr; True:C214)
			Else 
				SCPOA_SetEnterable_Var($OtherVar_ptr; False:C215)
			End if 
			//SCPOA_Array2CheckBox ($index_l;->SCPOA_2CEvtSampCont_L;->SCPOA_2CEvtSamp10m_L;->SCPOA_2CEvtSamp30m_L;->SCPOA_2CEvtSamp1hr_L;->SCPOA_2CEvtSampOth_L)
			SCPOA_Array2CkBoxArr($index_l; $CheckBoxArr_ptr)
			
			[ScourPOA:132]BIN:2:=[ScourPOA:132]BIN:2
			
		End if 
End case 