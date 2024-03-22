//%attributes = {"invisible":true}
//Method: ut_ArraysToText_CSV
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
	C_TEXT:C284(ut_ArrayToText_CSV; $0)
	C_TEXT:C284(ut_ArrayToText_CSV; $1)
	C_POINTER:C301(ut_ArrayToText_CSV; ${2})
	
	
	
	
	Mods_2020_02  //Fix issue with , and " in same column
End if 
//
C_TEXT:C284($0)
C_TEXT:C284($1)
C_POINTER:C301(${2})

//C_POINTER($arrays_ptr)
//$arrays_ptr:=$1
C_TEXT:C284($result_txt; $FieldSeparator_txt)
$result_txt:=""
$FieldSeparator_txt:=""
C_BOOLEAN:C305($csv_b)
$csv_b:=($1=",")
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
	C_LONGINT:C283($Progress_L)
	If ($arraySize_L>0)
		C_LONGINT:C283($Interval_L)
		$Interval_L:=1
		Case of 
			: ($arraySize_L>20000)
				$Interval_L:=500
			: ($arraySize_L>10000)
				$Interval_L:=250
			: ($arraySize_L>5000)
				$Interval_L:=100
			: ($arraySize_L>1000)
				$Interval_L:=10
			Else 
		End case 
		C_OBJECT:C1216($progressObj_o)
		
		$progressObj_o:=ProgressNew("Creating CSV for export"; $arraySize_L; True:C214; ""; 3)
		
		C_LONGINT:C283($Rows_L; $Dumm_L)
		C_TEXT:C284($arrName_txt; $line_txt)
		//make header with names of arrays
		$arr_ptr:=${2}
		RESOLVE POINTER:C394($arr_ptr; $arrName_txt; $Dumm_L; $Dumm_L)
		//$result_txt:=$result_txt+$arrName_txt
		
		//For ($param_L;3;$Params_L)
		//$arr_ptr:=${$param_L}
		//RESOLVE POINTER($arr_ptr;$arrName_txt;$Dumm_L;$Dumm_L)
		//$result_txt:=$result_txt+$FieldSeparator_txt+$arrName_txt
		//End for 
		
		//$result_txt:=$result_txt+"\n"
		
		C_REAL:C285($Test_R)
		C_TEXT:C284($StartingData_txt)
		
		//add the rows
		For ($Rows_L; 1; $arraySize_L)
			If ($Rows_L%$Interval_L=0)
				UpdateProgressNew($progressObj_o; $Rows_L)
				
			End if 
			
			$line_txt:=""
			
			For ($param_L; 2; $Params_L)
				
				If ($line_txt="")
					$FieldSeparator_txt:=""
				Else 
					$FieldSeparator_txt:=$1
				End if 
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
							C_LONGINT:C283($CheckIfNumberLoop_L)
							C_BOOLEAN:C305($IsANumber_B)
							$IsANumber_B:=True:C214
							C_TEXT:C284($SubstringPart_txt)
							$CheckIfNumberLoop_L:=1
							Repeat 
								
								$SubstringPart_txt:=Substring:C12($arr_ptr->{$Rows_L}; $CheckIfNumberLoop_L; 1)
								Case of 
									: ($SubstringPart_txt="0")
									: ($SubstringPart_txt="1")
									: ($SubstringPart_txt="2")
									: ($SubstringPart_txt="3")
									: ($SubstringPart_txt="4")
									: ($SubstringPart_txt="5")
									: ($SubstringPart_txt="6")
									: ($SubstringPart_txt="7")
									: ($SubstringPart_txt="8")
									: ($SubstringPart_txt="9")
									: ($SubstringPart_txt=",")
									: ($SubstringPart_txt=".")
									: ($SubstringPart_txt="d")
									: ($SubstringPart_txt="e")
									Else 
										$CheckIfNumberLoop_L:=Length:C16($arr_ptr->{$Rows_L})+1
										$IsANumber_B:=False:C215
								End case 
								$CheckIfNumberLoop_L:=$CheckIfNumberLoop_L+1
							Until ($CheckIfNumberLoop_L>Length:C16($arr_ptr->{$Rows_L})) | Not:C34($IsANumber_B)
							$StartingData_txt:=$arr_ptr->{$Rows_L}
							
							If ($IsANumber_B)
								$line_txt:=$line_txt+$FieldSeparator_txt+Char:C90(Double quote:K15:41)+"="+Char:C90(Double quote:K15:41)+Char:C90(Double quote:K15:41)+$StartingData_txt+Char:C90(Double quote:K15:41)+Char:C90(Double quote:K15:41)+Char:C90(Double quote:K15:41)
								
								//$line_txt:=$line_txt+$FieldSeparator_txt+Char(Quote)+$arr_ptr->{$Rows_L}+Char(Quote)  //+Char(Quote)
							Else 
								If ($arr_ptr->{$Rows_L}="")
									$arr_ptr->{$Rows_L}:=" "
								End if 
								Case of 
									: (Position:C15(Char:C90(Double quote:K15:41); $arr_ptr->{$Rows_L})>0)
										
										$StartingData_txt:=$arr_ptr->{$Rows_L}
										If (Position:C15(Char:C90(Double quote:K15:41); $StartingData_txt)>0)
											ARRAY TEXT:C222($Parts_atxt; 0)
											ut_NewTextToArray($StartingData_txt; ->$Parts_atxt; Char:C90(Double quote:K15:41))
											C_LONGINT:C283($PartLoop_L)
											C_TEXT:C284($PartResult_txt; $EscapedDouble)
											$EscapedDouble:=Char:C90(Double quote:K15:41)+Char:C90(Double quote:K15:41)
											CLEAR VARIABLE:C89($PartResult_txt)
											$PartResult_txt:=$Parts_atxt{1}
											For ($PartLoop_L; 2; Size of array:C274($Parts_atxt))
												$PartResult_txt:=$PartResult_txt+$EscapedDouble+$Parts_atxt{$PartLoop_L}
											End for 
											$StartingData_txt:=Char:C90(Double quote:K15:41)+$PartResult_txt+Char:C90(Double quote:K15:41)
											$line_txt:=$line_txt+$FieldSeparator_txt+$StartingData_txt
										End if 
									: (Position:C15(","; $arr_ptr->{$Rows_L})>0) & ($csv_b)
										If (Position:C15(Char:C90(Double quote:K15:41); $StartingData_txt)>0)
											ARRAY TEXT:C222($Parts_atxt; 0)
											ut_NewTextToArray($StartingData_txt; ->$Parts_atxt; Char:C90(Double quote:K15:41))
											C_LONGINT:C283($PartLoop_L)
											C_TEXT:C284($PartResult_txt; $EscapedDouble)
											$EscapedDouble:=Char:C90(Double quote:K15:41)+Char:C90(Double quote:K15:41)
											CLEAR VARIABLE:C89($PartResult_txt)
											$PartResult_txt:=$Parts_atxt{1}
											For ($PartLoop_L; 2; Size of array:C274($Parts_atxt))
												$PartResult_txt:=$PartResult_txt+$EscapedDouble+$Parts_atxt{$PartLoop_L}
											End for 
											$StartingData_txt:=Char:C90(Double quote:K15:41)+$PartResult_txt+Char:C90(Double quote:K15:41)
										Else 
											$StartingData_txt:=Char:C90(Double quote:K15:41)+$arr_ptr->{$Rows_L}+Char:C90(Double quote:K15:41)  //Replace string($arr_ptr->{$Rows_L};",";" ")
											
										End if 
										
										$line_txt:=$line_txt+$FieldSeparator_txt+$StartingData_txt
									Else 
										$line_txt:=$line_txt+$FieldSeparator_txt+Char:C90(Double quote:K15:41)+$arr_ptr->{$Rows_L}+Char:C90(Double quote:K15:41)
								End case 
								
							End if 
						Else 
							$line_txt:=$line_txt+$FieldSeparator_txt+Char:C90(Double quote:K15:41)+$arr_ptr->{$Rows_L}+Char:C90(Double quote:K15:41)
						End if 
						
					: (Type:C295($arr_ptr->)=Boolean array:K8:21)
						$line_txt:=$line_txt+$FieldSeparator_txt+Choose:C955($arr_ptr->{$Rows_L}; "True"; "False")
						
				End case 
				
			End for 
			
			$result_txt:=$result_txt+$line_txt+"\n"
			
		End for 
		Progress QUIT(OB Get:C1224($progressObj_o; "progress"))
	End if 
	
End if 

$0:=$result_txt
//End ut_ArraysToText