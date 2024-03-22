//%attributes = {"invisible":true}
//Method: ut_ArraysToText
//Description
// convert arrays to tab delim text
// Parameters
// $0 : $Text_txt
// $1 : Field Separator
// ${2} : pointers to arrays
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/06/19, 14:30:22
	// ----------------------------------------------------
	//Created : 
	Mods_2019_06_bug
	
	C_TEXT:C284(ut_ArraysToText; $0)
	C_TEXT:C284(ut_ArraysToText; $1)
	C_POINTER:C301(ut_ArraysToText; ${2})
	
	// Modified by: Costas Manousakis-(Designer)-(10/24/19 16:14:15)
	Mods_2019_10_bug
	//  `changed methodology to build an array of text blocks first and then combine into the result
	Mods_2019_11_bug  //Moved Project retrieve code from development into bug fix 
	//and back as there were a few changes made in testing
	//Modified by: Chuck Miller (11/5/19 13:28:12)
End if 
//
C_TEXT:C284($0)
C_TEXT:C284($1)
C_POINTER:C301(${2})

//C_POINTER($arrays_ptr)
//$arrays_ptr:=$1
C_TEXT:C284($result_txt; $FieldSeparator_txt)
$result_txt:=""
$FieldSeparator_txt:=$1
C_BOOLEAN:C305($csv_b)
$csv_b:=($FieldSeparator_txt=",")
C_LONGINT:C283($Params_L)
//$Params_L:=Size of array($arrays_ptr->)
$Params_L:=Count parameters:C259
If ($Params_L>1)
	C_LONGINT:C283($arraySize_L)
	C_POINTER:C301($arr_ptr)
	C_LONGINT:C283($param_L)
	
	$arr_ptr:=$2
	
	$arraySize_L:=Size of array:C274($arr_ptr->)
	
	For ($param_L; 3; $Params_L)
		$arr_ptr:=${$param_L}
		If (Size of array:C274($arr_ptr->)#$arraySize_L)
			//can't do this - arrays not equal size
			$arraySize_L:=-1
		End if 
		
	End for 
	If ($arraySize_L>0)
		C_LONGINT:C283($Rows_L; $Dumm_L)
		C_TEXT:C284($arrName_txt; $line_txt)
		//make header with names of arrays
		$arr_ptr:=${2}
		RESOLVE POINTER:C394($arr_ptr; $arrName_txt; $Dumm_L; $Dumm_L)
		$result_txt:=$result_txt+$arrName_txt
		
		For ($param_L; 3; $Params_L)
			$arr_ptr:=${$param_L}
			RESOLVE POINTER:C394($arr_ptr; $arrName_txt; $Dumm_L; $Dumm_L)
			$result_txt:=$result_txt+$FieldSeparator_txt+$arrName_txt
		End for 
		
		$result_txt:=$result_txt+"\n"
		C_OBJECT:C1216($progressObj_o)
		$progressObj_o:=ProgressNew("Creating CSV Document"; $arraySize_L; False:C215; ""; 3)
		
		ARRAY TEXT:C222($block_atxt; 1)
		C_LONGINT:C283($BlockCount_L; $Limit_L)
		$BlockCount_L:=1
		$Limit_L:=100*1000  // 100,000 char limit per block
		$block_atxt{$BlockCount_L}:=""
		//add the rows
		For ($Rows_L; 1; $arraySize_L)
			UpdateProgressNew($progressObj_o; $Rows_L)
			
			$line_txt:=""
			
			$arr_ptr:=${2}
			
			Case of 
				: ((Type:C295($arr_ptr->)=Date array:K8:20) | (Type:C295($arr_ptr->)=Integer array:K8:18) | (Type:C295($arr_ptr->)=LongInt array:K8:19) | (Type:C295($arr_ptr->)=Real array:K8:17) | (Type:C295($arr_ptr->)=Time array:K8:29))
					$line_txt:=$line_txt+String:C10($arr_ptr->{$Rows_L})
				: ((Type:C295($arr_ptr->)=String array:K8:15) | (Type:C295($arr_ptr->)=Text array:K8:16))
					If ($csv_b)
						If (Position:C15("\n"; $arr_ptr->{$Rows_L})>0)
							//ALERT("carriage ret")
						End if 
						If (Position:C15("\t"; $arr_ptr->{$Rows_L})>0)
							//ALERT("tab")
						End if 
						
						$line_txt:=$line_txt+Char:C90(Double quote:K15:41)+Replace string:C233($arr_ptr->{$Rows_L}; Char:C90(Double quote:K15:41); Char:C90(Double quote:K15:41)+Char:C90(Double quote:K15:41))+Char:C90(Double quote:K15:41)
					Else 
						$line_txt:=$line_txt+$arr_ptr->{$Rows_L}
					End if 
					
				: (Type:C295($arr_ptr->)=Boolean array:K8:21)
					$line_txt:=$line_txt+Choose:C955($arr_ptr->{$Rows_L}; "True"; "False")
					
			End case 
			
			For ($param_L; 3; $Params_L)
				
				$arr_ptr:=${$param_L}
				
				Case of 
					: ((Type:C295($arr_ptr->)=Date array:K8:20) | (Type:C295($arr_ptr->)=Integer array:K8:18) | (Type:C295($arr_ptr->)=LongInt array:K8:19) | (Type:C295($arr_ptr->)=Real array:K8:17) | (Type:C295($arr_ptr->)=Time array:K8:29))
						$line_txt:=$line_txt+$FieldSeparator_txt+String:C10($arr_ptr->{$Rows_L})
					: ((Type:C295($arr_ptr->)=String array:K8:15) | (Type:C295($arr_ptr->)=Text array:K8:16))
						If ($csv_b)
							If (Position:C15("\n"; $arr_ptr->{$Rows_L})>0)
								//ALERT("carriage ret")
							End if 
							If (Position:C15("\t"; $arr_ptr->{$Rows_L})>0)
								//ALERT("tab")
							End if 
							
							$line_txt:=$line_txt+$FieldSeparator_txt+Char:C90(Double quote:K15:41)+Replace string:C233($arr_ptr->{$Rows_L}; Char:C90(Double quote:K15:41); Char:C90(Double quote:K15:41)+Char:C90(Double quote:K15:41))+Char:C90(Double quote:K15:41)
						Else 
							$line_txt:=$line_txt+$FieldSeparator_txt+$arr_ptr->{$Rows_L}
						End if 
						
					: (Type:C295($arr_ptr->)=Boolean array:K8:21)
						$line_txt:=$line_txt+$FieldSeparator_txt+Choose:C955($arr_ptr->{$Rows_L}; "True"; "False")
						
				End case 
				
			End for 
			
			//$result_txt:=$result_txt+$line_txt+"\n"
			$block_atxt{$BlockCount_L}:=$block_atxt{$BlockCount_L}+$line_txt+"\n"
			If (Length:C16($block_atxt{$BlockCount_L})>$Limit_L)
				//exceeded the limit - start a new block
				APPEND TO ARRAY:C911($block_atxt; "")
				$BlockCount_L:=Size of array:C274($block_atxt)
				$block_atxt{$BlockCount_L}:=""
			End if 
			
		End for 
		Progress QUIT(OB Get:C1224($progressObj_o; "progress"; Is longint:K8:6))
		
		$BlockCount_L:=Size of array:C274($block_atxt)
		$progressObj_o:=ProgressNew("Creating final text"; $BlockCount_L; False:C215; ""; 3)
		
		C_LONGINT:C283($block_L)
		For ($block_L; 1; Size of array:C274($block_atxt))
			UpdateProgressNew($progressObj_o; $block_L)
			If ($block_atxt{$block_L}#"")
				$result_txt:=$result_txt+$block_atxt{$block_L}
			End if 
		End for 
		Progress QUIT(OB Get:C1224($progressObj_o; "progress"; Is longint:K8:6))
		
	End if 
	
End if 

$0:=$result_txt
//End ut_ArraysToText