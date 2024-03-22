//%attributes = {"invisible":true}
//Method: INSP_LoadElmLabelsforReport
//Description
// Load the Element Labels for a report
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 12/27/12, 15:42:20
	// ----------------------------------------------------
	//Created : 
	Mods_2012_12
End if 
//

C_TEXT:C284($1; $ElementType_txt; $ElementNumbers_txt; $T_final; $ElementLbls_txt; $SaveType_txt)
INSP_TypeSearch_txt:=$1
C_LONGINT:C283($MaxOffset_L; $Offset_L; $Position_L; $Loop_l; $Size_l; $ElementPosition_l; $ElementDictPos_l)
C_TEXT:C284(INSP_ElementNumbers_txt; INSP_TypeSearch_txt)
Begin SQL
	SELECT [Inspection Type].[ElementNumbers_txt] FROM [Inspection Type]
	WHERE [Inspection Type].CODE = :INSP_TypeSearch_txt
	into :INSP_ElementNumbers_txt
End SQL

$MaxOffset_L:=Length:C16(INSP_ElementNumbers_txt)
ARRAY INTEGER:C220(INSP_NewElementNumbers_ai; 0)
ARRAY TEXT:C222($NewElementNumbers_atxt; 0)
ARRAY TEXT:C222(INSP_NewElementLabels_atxt; 0)

$Offset_L:=1
Repeat 
	$Position_L:=Position:C15("\r"; INSP_ElementNumbers_txt; $Offset_L)
	If ($Position_L>0)
		$ElementType_txt:=Substring:C12(INSP_ElementNumbers_txt; $Offset_L; $Position_L-$Offset_L)  //N58, n60 etc
		$Offset_L:=$Position_L+1
		$Position_L:=Position:C15("\r"; INSP_ElementNumbers_txt; $Offset_L)  //element numbers 100, 101, etc
		If ($Position_L>0)
			$ElementNumbers_txt:=Substring:C12(INSP_ElementNumbers_txt; $Offset_L; $Position_L-$Offset_L)  //element numbers 100, 101, etc 
			$Offset_L:=$Position_L+1
			$Position_L:=Position:C15("\r"; INSP_ElementNumbers_txt; $Offset_L)  //element labels 1.,2.,a. etc
			
			If ($Position_L>0)
				$ElementLbls_txt:=Substring:C12(INSP_ElementNumbers_txt; $Offset_L; $Position_L-$Offset_L)  // `element labels 1.,2.,a. etc
				$Offset_L:=$Position_L+1
			Else 
				$ElementLbls_txt:=Substring:C12(INSP_ElementNumbers_txt; $Offset_L)
				$Offset_L:=$MaxOffset_L
			End if 
		Else 
			$Offset_L:=$MaxOffset_L
		End if 
		ut_NewTextToArray($ElementNumbers_txt; ->$NewElementNumbers_atxt; ",")
		ut_NewTextToArray($ElementLbls_txt; ->INSP_NewElementLabels_atxt; ",")
	Else 
		$Offset_L:=$MaxOffset_L
	End if 
	
Until ($Offset_L>=$MaxOffset_L)
ARRAY INTEGER:C220(INSP_NewElementNumbers_ai; Size of array:C274($NewElementNumbers_atxt))

C_LONGINT:C283($loop_L)
For ($loop_L; 1; Size of array:C274(INSP_NewElementNumbers_ai))
	INSP_NewElementNumbers_ai{$loop_L}:=Num:C11($NewElementNumbers_atxt{$loop_L})
End for 

//End INSP_LoadElmLabelsforReport