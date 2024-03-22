//%attributes = {"invisible":true}

// ----------------------------------------------------
// User name (OS): administrator
// Date and time: 06/26/14, 15:23:09
// ----------------------------------------------------
// Method: LSS_CreateElementInputArrays
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1)

C_LONGINT:C283($Offset_L; $MaxOffset_L)
$MaxOffset_L:=Length:C16($1)

$Offset_L:=0
ARRAY TEXT:C222($ElementNumbers_atxt; 0)
ARRAY TEXT:C222($ElementNumberLabels_atxt; 0)
ARRAY LONGINT:C221($ElementNumbers_aL; 0)
C_TEXT:C284($ElementType_txt; $ElementNumbers_txt; $ElementLbls_txt)
Repeat 
	$Position_L:=Position:C15("\r"; $1; $Offset_L)
	If ($Position_L>0)
		$ElementType_txt:=Substring:C12($1; $Offset_L; $Position_L-$Offset_L)  //N58, n60 etc
		$Offset_L:=$Position_L+1
		$Position_L:=Position:C15("\r"; $1; $Offset_L)  //element numbers 100, 101, etc
		If ($Position_L>0)
			$ElementNumbers_txt:=Substring:C12($1; $Offset_L; $Position_L-$Offset_L)  //element numbers 100, 101, etc 
			$Offset_L:=$Position_L+1
			$Position_L:=Position:C15("\r"; $1; $Offset_L)  //element labels 1.,2.,a. etc
			
			If ($Position_L>0)
				$ElementLbls_txt:=Substring:C12($1; $Offset_L; $Position_L-$Offset_L)  // `element labels 1.,2.,a. etc
				$Offset_L:=$Position_L+1
			Else 
				$ElementLbls_txt:=Substring:C12($1; $Offset_L)
				$Offset_L:=$MaxOffset_L
			End if 
		Else 
			$Offset_L:=$MaxOffset_L
		End if 
		APPEND TO ARRAY:C911($ElementNumbers_atxt; $ElementType_txt)
		APPEND TO ARRAY:C911($ElementNumberLabels_atxt; "")
		
		ut_NewTextToArray($ElementNumbers_txt; ->$ElementNumbers_atxt; ",")
		ut_NewTextToArray($ElementLbls_txt; ->$ElementNumberLabels_atxt; ",")
		
	Else 
		$Offset_L:=$MaxOffset_L
	End if 
	
Until ($Offset_L>=$MaxOffset_L)

$Offset_L:=Size of array:C274($ElementNumbers_atxt)
CLEAR VARIABLE:C89(v_163_006_atxt)
CLEAR VARIABLE:C89(v_163_005_atxt)
CLEAR VARIABLE:C89(v_163_008_atxt)
CLEAR VARIABLE:C89(v_163_004_atxt)
//CLEAR VARIABLE(v_163_013_atxt)

CLEAR VARIABLE:C89(v_163_002_aL)
CLEAR VARIABLE:C89(LSS_ElementHeader_ab)
CLEAR VARIABLE:C89(v_163_007_atxt)
CLEAR VARIABLE:C89(LSS_ElemListBackColor_AL)
ARRAY TEXT:C222(v_163_006_atxt; $Offset_L)
ARRAY TEXT:C222(v_163_005_atxt; $Offset_L)
ARRAY TEXT:C222(v_163_008_atxt; $Offset_L)
ARRAY TEXT:C222(v_163_004_atxt; $Offset_L)
//ARRAY TEXT(v_163_013_atxt;$Offset_L)

ARRAY LONGINT:C221(v_163_002_aL; $Offset_L)
ARRAY BOOLEAN:C223(LSS_ElementHeader_ab; $Offset_L)
ARRAY TEXT:C222(v_163_007_atxt; $Offset_L)
ARRAY LONGINT:C221(LSS_ElemListBackColor_AL; $Offset_L)
SET QUERY DESTINATION:C396(Into set:K19:2; "$ElemInspSet")
QUERY:C277([LSS_ElementInspection:163]; [LSS_ElementInspection:163]LSS_InspectionId_s:3=[LSS_Inspection:164]LSS_InspectionId_s:1)
SET QUERY DESTINATION:C396(Into current selection:K19:1)
C_LONGINT:C283($ID_L; $Position_L; $Loop_l)
C_LONGINT:C283($Count_L; $HeaderCount_L)
$HeaderCount_L:=0
C_TEXT:C284($Description_txt)
C_BOOLEAN:C305($Custom_b)
For ($Loop_l; 1; $Offset_L)
	v_163_002_aL{$Loop_l}:=Num:C11($ElementNumbers_atxt{$Loop_l})
	$ID_L:=v_163_002_aL{$Loop_l}
	Begin SQL
		SELECT 
		[LSS_Element].[LSS_ElementDescription_s] 
		FROM
		[LSS_Element]
		WHERE
		[LSS_Element].[LSS_ElementId_L] = :$ID_L
		INTO
		:$Description_txt;
	End SQL
	
	USE SET:C118("$ElemInspSet")
	QUERY SELECTION:C341([LSS_ElementInspection:163]; [LSS_ElementInspection:163]LSS_ElementId_L:2=v_163_002_aL{$Loop_l})
	SET QUERY DESTINATION:C396(Into variable:K19:4; $Count_L)
	QUERY:C277([LSS_Element:162]; [LSS_Element:162]LSS_ElementId_L:1=v_163_002_aL{$Loop_l}; *)
	QUERY:C277([LSS_Element:162]; [LSS_Element:162]LSS_ElementHeader_b:3=True:C214)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	
	
	v_163_006_atxt{$Loop_l}:=[LSS_ElementInspection:163]LSS_Urgency_s:6
	v_163_005_atxt{$Loop_l}:=[LSS_ElementInspection:163]LSS_Deficiency_s:5
	v_163_008_atxt{$Loop_l}:=[LSS_ElementInspection:163]LSS_Remarks_txt:8
	v_163_004_atxt{$Loop_l}:=[LSS_ElementInspection:163]LSS_Rating_s:4
	//v_163_013_atxt{$Loop_l}:=[LSS_ElementInspection]LSS_DamagePreviousCondition_s
	
	If ([LSS_ElementInspection:163]LSS_Description_txt:7#"")
		v_163_007_atxt{$Loop_l}:=$ElementNumberLabels_atxt{$Loop_l}+" "+[LSS_ElementInspection:163]LSS_Description_txt:7
	Else 
		If (Position:C15("blank element"; $Description_txt)>0)
			v_163_007_atxt{$Loop_l}:=$ElementNumberLabels_atxt{$Loop_l}+" blank element"
		Else 
			v_163_007_atxt{$Loop_l}:=$ElementNumberLabels_atxt{$Loop_l}+" "+$Description_txt
		End if 
	End if 
	If ($Count_L=1)
		LSS_ElemListBackColor_AL{$Loop_l}:=7601673  //1572982`1573022
		$HeaderCount_L:=$HeaderCount_L+1
		LSS_ElementHeader_ab{$Loop_l}:=True:C214
		v_163_007_atxt{$Loop_L}:=String:C10($HeaderCount_L; "0.0")+v_163_007_atxt{$Loop_L}
	Else 
		LSS_ElementHeader_ab{$Loop_l}:=False:C215
		LSS_ElemListBackColor_AL{$Loop_L}:=16777215
	End if 
	
End for 
CLEAR SET:C117("$ElemInspSet")