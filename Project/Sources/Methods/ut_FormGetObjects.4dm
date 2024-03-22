//%attributes = {"invisible":true}
//Method: ut_FormGetObjects
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 06/19/18, 16:18:44
	// ----------------------------------------------------
	//Created : 
	Compiler_Utilities
End if 
//


C_TEXT:C284($1; $FormName_txt)
$FormName_txt:=$1

C_POINTER:C301($2; $ReportBlob_ptr)
C_BOOLEAN:C305($3; $ReportonMissingOnly_B; $DoNotReport_B)

$ReportBlob_ptr:=$2
$ReportonMissingOnly_B:=$3
ARRAY POINTER:C280($VariableArray_aPTR; 0)
C_LONGINT:C283($Find_L; $i; $OBJType_L)
ARRAY LONGINT:C221($pages_aL; 0)
FORM GET OBJECTS:C898($ObjectArray_atxt; $VariableArray_aPTR; $pages_aL)
C_LONGINT:C283($ObjFontSize_L; $OBJType_L)
C_BOOLEAN:C305($ReportMe_B)
C_TEXT:C284($VariableName_txt; $ObjStyleSheet_txt; $ObjFont_txt)
C_LONGINT:C283($TableNUmber_L; $FieldNumber_L)
For ($i; 1; Size of array:C274($VariableArray_aPTR))
	
	$VariableName_txt:=""
	$ObjStyleSheet_txt:=""
	$ObjFont_txt:=""
	$ObjFontSize_L:=0
	RESOLVE POINTER:C394($VariableArray_aPTR{$i}; $VariableName_txt; $TableNUmber_L; $FieldNumber_L)
	$OBJType_L:=OBJECT Get type:C1300(*; $ObjectArray_atxt{$i})
	$ReportMe_B:=False:C215
	Case of 
		: ($OBJType_L=0)
		: ($OBJType_L=2)
		: ($OBJType_L=4)
		: ($OBJType_L>=7) & ($OBJType_L<=10)  //List box
		: ($OBJType_L>37)
		: ($OBJType_L>=18) & ($OBJType_L<=21)
		: ($OBJType_L=14)
		: ($OBJType_L=24)
		: ($OBJType_L>=27) & ($OBJType_L<=29)
		: ($OBJType_L>=31) & ($OBJType_L<=36)
		Else 
			$ReportMe_B:=True:C214
	End case 
	If (($VariableName_txt="") & ($TableNUmber_L=0) & ($FieldNumber_L=0))
		If ($ReportMe_B)
			$ObjStyleSheet_txt:=OBJECT Get style sheet:C1258(*; $ObjectArray_atxt{$i})
			$ObjFont_txt:=OBJECT Get font:C1069(*; $ObjectArray_atxt{$i})
			$ObjFontSize_L:=OBJECT Get font size:C1070(*; $ObjectArray_atxt{$i})
		End if 
	Else 
		
		$ObjStyleSheet_txt:=""
		$ObjFont_txt:=""
		$ObjFontSize_L:=0
		If ($ReportMe_B)
			$ObjStyleSheet_txt:=OBJECT Get style sheet:C1258(*; $ObjectArray_atxt{$i})
			$ObjFont_txt:=OBJECT Get font:C1069(*; $ObjectArray_atxt{$i})
			$ObjFontSize_L:=OBJECT Get font size:C1070(*; $ObjectArray_atxt{$i})
		End if 
		If ($TableNUmber_L>0)
			If ($FieldNumber_L>0)
				$VariableName_txt:=Field name:C257($TableNUmber_L; $FieldNumber_L)
			Else 
				$VariableName_txt:=Table name:C256($TableNUmber_L)
			End if 
		End if 
	End if 
	If ($ReportMe_B)
		If ($ReportonMissingOnly_B)
			If ($ObjStyleSheet_txt="") & ($ObjFont_txt="")
				TEXT TO BLOB:C554($FormName_txt+Char:C90(Tab:K15:37)+\
					$VariableName_txt+Char:C90(Tab:K15:37)+\
					$ObjectArray_atxt{$i}+Char:C90(Tab:K15:37)+\
					String:C10($OBJType_L)+Char:C90(Tab:K15:37)+\
					$ObjStyleSheet_txt+Char:C90(Tab:K15:37)+\
					$ObjFont_txt+Char:C90(Tab:K15:37)+\
					String:C10($ObjFontSize_L)+Char:C90(Tab:K15:37)+\
					String:C10($pages_aL{$i})+Char:C90(Carriage return:K15:38)\
					; $ReportBlob_ptr->; UTF8 text without length:K22:17; *)
			End if 
		Else 
			TEXT TO BLOB:C554($FormName_txt+Char:C90(Tab:K15:37)+\
				$VariableName_txt+Char:C90(Tab:K15:37)+\
				$ObjectArray_atxt{$i}+Char:C90(Tab:K15:37)+\
				String:C10($OBJType_L)+Char:C90(Tab:K15:37)+\
				$ObjStyleSheet_txt+Char:C90(Tab:K15:37)+\
				$ObjFont_txt+Char:C90(Tab:K15:37)+\
				String:C10($ObjFontSize_L)+Char:C90(Tab:K15:37)+\
				String:C10($pages_aL{$i})+Char:C90(Carriage return:K15:38)\
				; $ReportBlob_ptr->; UTF8 text without length:K22:17; *)
		End if 
	End if 
	
End for 
//End ut_FormGetObjects

