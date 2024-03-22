//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/01/11, 19:29:42
	// ----------------------------------------------------
	// Method: SCPOA_CheckBox_OM
	// Description
	// 
	// 
	// Parameters
	// $1 : $FieldVar_ptr
	// $2 : $OtherVar_ptr
	// $3 : $CheckBoxArr_ptr
	// $4 : $ChkBox_ptr
	// $5 : $FormEvent (Optional)
	// ----------------------------------------------------
	
	Mods_2011_05
End if 
C_POINTER:C301($1; $FieldVar_ptr; $2; $OtherVar_ptr; $3; $CheckBoxArr_ptr; $4; $ChkBox_ptr)
$FieldVar_ptr:=$1
$OtherVar_ptr:=$2
$CheckBoxArr_ptr:=$3
$ChkBox_ptr:=$4
C_LONGINT:C283($FormEvent_L)
C_POINTER:C301($genChkBox_ptr)
If (Count parameters:C259>4)
	C_LONGINT:C283($5)
	$FormEvent_L:=$5
Else 
	$FormEvent_L:=Form event code:C388
End if 

C_LONGINT:C283($loop_L; $myValue_L)
C_TEXT:C284($mylabel_txt)
C_POINTER:C301($genChkBox_ptr)
Case of 
	: ($FormEvent_L=On Load:K2:1)
		//any of the checkboxes checked?
		C_LONGINT:C283($whoischecked_L)
		$whoischecked_L:=0
		ARRAY TEXT:C222($boxlabels__atxt; 0)
		For ($loop_L; 1; Size of array:C274($CheckBoxArr_ptr->))
			$genChkBox_ptr:=$CheckBoxArr_ptr->{$loop_L}
			$mylabel_txt:=OBJECT Get format:C894($genChkBox_ptr->)
			APPEND TO ARRAY:C911($boxlabels__atxt; $mylabel_txt)
			If ($genChkBox_ptr->=1)
				$whoischecked_L:=$loop_L
			End if 
			
		End for 
		If ($whoischecked_L=0)
			//nobody - see if there is a value 
			If ($FieldVar_ptr->#"")
				//there is a value - find who should be checked - match the labels
				C_LONGINT:C283($whoisit_L)
				$whoisit_L:=Find in array:C230($boxlabels__atxt; $FieldVar_ptr->)
				If ($whoisit_L>0)
					//Check the box - probably not called "Other"
					$genChkBox_ptr:=$CheckBoxArr_ptr->{$whoisit_L}
					$genChkBox_ptr->:=1
					[ScourPOA:132]BIN:2:=[ScourPOA:132]BIN:2
				Else 
					$whoisit_L:=Find in array:C230($boxlabels__atxt; "Ohter@")
					If ($whoisit_L>0)
						$genChkBox_ptr:=$CheckBoxArr_ptr->{$whoisit_L}
						$genChkBox_ptr->:=1
						$OtherVar_ptr->:=$FieldVar_ptr->
						[ScourPOA:132]BIN:2:=[ScourPOA:132]BIN:2
					Else 
						//Don't know what to do here
					End if 
					
				End if 
				
			End if 
			
		End if 
		
	: ($FormEvent_L=On Data Change:K2:15)
		
	: ($FormEvent_L=On Clicked:K2:4)
		$myValue_L:=$ChkBox_ptr->
		C_BOOLEAN:C305($UncheckOthers_b)
		$mylabel_txt:=OBJECT Get format:C894($ChkBox_ptr->)
		If ($myValue_L=1)  //I got checked
			$UncheckOthers_b:=True:C214
			//The other button?
			If ($mylabel_txt="Other@")
				$UncheckOthers_b:=True:C214
				GOTO OBJECT:C206($OtherVar_ptr->)
				
			Else 
				//check if there is text in the other descr
				If ($OtherVar_ptr->#"")
					CONFIRM:C162("Clear the value for 'Other' : ["+$OtherVar_ptr->+"] ?")
					If (OK=1)
						$OtherVar_ptr->:=""
					Else 
						//set my$ChkBox_ptr back to 0
						$ChkBox_ptr->:=0
						$UncheckOthers_b:=False:C215
					End if 
					
				Else 
					//Blank in descr so ok to uncheck
				End if 
				
			End if 
			If ($UncheckOthers_b)
				//Uncheck all others
				For ($loop_L; 1; Size of array:C274($CheckBoxArr_ptr->))
					$genChkBox_ptr:=$CheckBoxArr_ptr->{$loop_L}
					If ($genChkBox_ptr#$ChkBox_ptr)
						$genChkBox_ptr->:=0
					End if 
					
				End for 
				
			End if 
			//if the Other check box is on Enable entry to the desc field
		Else 
			If ($mylabel_txt="Other@")
				//Other was unchecked
				If ($OtherVar_ptr->#"")
					CONFIRM:C162("Clear the 'Other' value : ["+$OtherVar_ptr->+"] ?")
					If (OK=1)
						$OtherVar_ptr->:=""
					Else 
						//set my$ChkBox_ptr back to 1
						$ChkBox_ptr->:=1
					End if 
				End if 
				
			End if 
			
		End if 
		//Update the field variable
		For ($loop_L; 1; Size of array:C274($CheckBoxArr_ptr->))
			$genChkBox_ptr:=$CheckBoxArr_ptr->{$loop_L}
			$mylabel_txt:=OBJECT Get format:C894($genChkBox_ptr->)
			If ($genChkBox_ptr->=1)
				If ($mylabel_txt="Other@")
					If ($OtherVar_ptr->="")
						$FieldVar_ptr->:=$mylabel_txt
					Else 
						$FieldVar_ptr->:=$OtherVar_ptr->
					End if 
					
				Else 
					$FieldVar_ptr->:=$mylabel_txt
				End if 
				
			End if 
			
		End for 
		
		[ScourPOA:132]BIN:2:=[ScourPOA:132]BIN:2  //mark as an edit
		
	: ($FormEvent_L=On Double Clicked:K2:5)
		
End case 

If (($FormEvent_L=On Load:K2:1) | ($FormEvent_L=On Clicked:K2:4))
	//see what the settings should be for the other variable
	C_BOOLEAN:C305($EnableDesc_b)
	$EnableDesc_b:=False:C215
	For ($loop_L; 1; Size of array:C274($CheckBoxArr_ptr->))
		$genChkBox_ptr:=$CheckBoxArr_ptr->{$loop_L}
		$mylabel_txt:=OBJECT Get format:C894($genChkBox_ptr->)
		If ($mylabel_txt="Other@")
			If ($genChkBox_ptr->=1)
				$EnableDesc_b:=True:C214
			End if 
			
		End if 
		
	End for 
	SCPOA_SetEnterable_Var($OtherVar_ptr; ($EnableDesc_b & SCPOA_EditRecord_b))
End if 