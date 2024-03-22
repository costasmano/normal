//%attributes = {"invisible":true}
//LSS_FillPage1_FM
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 
//----------------------------------------------------
//Method: 
//Description
//This method will load data from element safety into variables on the form. 
//You should call Compiler_NewInspReports before to make sure all are typed
//Assume that [Inspection Type]ElementNumbers_txt is filled as follows
// ----------------------------------------------------


If (False:C215)
	// Modified by: Costas Manousakis-(Designer)-(9/6/16 10:26:37)
	Mods_2016_09
	//  `changed label for Inventory Number HS -HIN, SI - SIN
	
End if 

C_TEXT:C284($1; $InspectionType_txt; $ElementType_txt; $ElementNumbers_txt; $T_final; $ElementLbls_txt)
$InspectionType_txt:=$1
Case of 
	: ([LSS_Inventory:165]LSS_Category_s:2="Sign") | ([LSS_Inventory:165]LSS_InventoryType_s:28="HS")
		TemplateMIN_Sin_txt:="HIN"
	: ([LSS_Inventory:165]LSS_Category_s:2="Light") | ([LSS_Inventory:165]LSS_InventoryType_s:28="LI")
		TemplateMIN_Sin_txt:="LIN"
	: ([LSS_Inventory:165]LSS_Category_s:2="Signal") | ([LSS_Inventory:165]LSS_InventoryType_s:28="SI")
		TemplateMIN_Sin_txt:="SIN"
	: ([LSS_Inventory:165]LSS_Category_s:2="ITS") | ([LSS_Inventory:165]LSS_InventoryType_s:28="IT")
		TemplateMIN_Sin_txt:="IIN"
End case 
QUERY:C277([LSS_refInspectionType:167]; [LSS_refInspectionType:167]LSS_InspectionTypeId_s:1=$InspectionType_txt)
Case of 
	: (Substring:C12($InspectionType_txt; 1; 2)="IT")
		vInspTitlePr:=[LSS_refInspectionType:167]LSS_Description_txt:2+" ITS Inspection"
		
	: (Substring:C12($InspectionType_txt; 1; 2)="HS")
		vInspTitlePr:=[LSS_refInspectionType:167]LSS_Description_txt:2+" HIGHWAY SIGN Inspection"
	: (Substring:C12($InspectionType_txt; 1; 2)="LI")
		vInspTitlePr:=[LSS_refInspectionType:167]LSS_Description_txt:2+" OVERHEAD LIGHT Inspection"
	: (Substring:C12($InspectionType_txt; 1; 2)="SI")
		vInspTitlePr:=[LSS_refInspectionType:167]LSS_Description_txt:2+" SIGNAL Inspection"
		
End case 

C_LONGINT:C283($MaxOffset_L; $Offset_L; $Position_L; $Loop_l; $Size_l; $ElementPosition_l; $ElementDictPos_l; $InnerLoop_l)
C_POINTER:C301($VTptr; $VRptr; $VDptr; $VUptr; $vRemptr)
$Position_L:=Find in array:C230(v_171_001_atxt; [LSS_Inventory:165]LSS_StructureTypeId_s:25)
LSS_StructureType_txt:=""
If ($Position_L>0)
	LSS_StructureType_txt:=v_171_003_atxt{$Position_L}
End if 

$Position_L:=Find in array:C230(v_170_001_atxt; [LSS_Inventory:165]LSS_StructureMaterialId_s:15)
LSS_StructureMaterial_txt:=""
If ($Position_L>0)
	LSS_StructureMaterial_txt:=v_170_002_atxt{$Position_L}
End if 

$Position_L:=Find in array:C230(v_169_001_atxt; [LSS_Inventory:165]LSS_StructureCoatingId_s:16)
LSS_StructureCoating_txt:=""
If ($Position_L>0)
	LSS_StructureCoating_txt:=v_169_002_atxt{$Position_L}
End if 

ARRAY TEXT:C222(LSS_ElementLabel_atxt; 0)
ARRAY TEXT:C222(LSS_ElementRemarks_atxt; 0)
ARRAY BOOLEAN:C223(LSS_ElementHeader_ab; 0)
ARRAY TEXT:C222(LSS_ElementHeaderNo_atxt; 0)


SET QUERY DESTINATION:C396(Into set:K19:2; "$MySet")
QUERY:C277([LSS_ElementInspection:163]; [LSS_ElementInspection:163]LSS_InspectionId_s:3=[LSS_Inspection:164]LSS_InspectionId_s:1)
SET QUERY DESTINATION:C396(Into current selection:K19:1)
ARRAY LONGINT:C221($v_163_002_aL; 0)
ARRAY TEXT:C222($v_163_007_atxt; 0)
ARRAY BOOLEAN:C223($LSS_ElementHeader_ab; 0)

Begin SQL
	select
	[LSS_Element].[LSS_ElementId_L], 
	[LSS_Element].[LSS_ElementDescription_s], 
	[LSS_Element].[LSS_ElementHeader_b] 
	from
	[LSS_Element]
	into
	:$v_163_002_aL, 
	:$v_163_007_atxt,
	:$LSS_ElementHeader_ab;
End SQL

LSS_FillNames


$MaxOffset_L:=Length:C16([LSS_refInspectionType:167]LSS_AllowedElements_txt:3)

$Offset_L:=1
Repeat 
	$Position_L:=Position:C15("\r"; [LSS_refInspectionType:167]LSS_AllowedElements_txt:3; $Offset_L)
	If ($Position_L>0)
		$ElementType_txt:=Substring:C12([LSS_refInspectionType:167]LSS_AllowedElements_txt:3; $Offset_L; $Position_L-$Offset_L)  //1,10,44,38
		APPEND TO ARRAY:C911(LSS_ElementLabel_atxt; $ElementType_txt)
		APPEND TO ARRAY:C911(LSS_ElementRemarks_atxt; "")
		APPEND TO ARRAY:C911(LSS_ElementHeader_ab; True:C214)
		APPEND TO ARRAY:C911(LSS_ElementHeaderNo_atxt; $ElementType_txt)
		$Offset_L:=$Position_L+1
		$Position_L:=Position:C15("\r"; [LSS_refInspectionType:167]LSS_AllowedElements_txt:3; $Offset_L)  //element numbers 2,3,4, etc
		If ($Position_L>0)
			$ElementNumbers_txt:=Substring:C12([LSS_refInspectionType:167]LSS_AllowedElements_txt:3; $Offset_L; $Position_L-$Offset_L)  //element numbers 2,3,4, etc 
			$Offset_L:=$Position_L+1
			$Position_L:=Position:C15("\r"; [LSS_refInspectionType:167]LSS_AllowedElements_txt:3; $Offset_L)  //element labels 1.,2.,a. etc
			
			If ($Position_L>0)
				$ElementLbls_txt:=Substring:C12([LSS_refInspectionType:167]LSS_AllowedElements_txt:3; $Offset_L; $Position_L-$Offset_L)  // `element labels 1.,2.,a. etc
				$Offset_L:=$Position_L+1
			Else 
				$ElementLbls_txt:=Substring:C12([LSS_refInspectionType:167]LSS_AllowedElements_txt:3; $Offset_L)
				$Offset_L:=$MaxOffset_L
			End if 
		Else 
			$Offset_L:=$MaxOffset_L
		End if 
		ARRAY TEXT:C222($ElementNumbers_atxt; 0)
		ARRAY TEXT:C222($ElementNumberLabels_atxt; 0)
		ut_NewTextToArray($ElementNumbers_txt; ->$ElementNumbers_atxt; ",")
		ut_NewTextToArray($ElementLbls_txt; ->$ElementNumberLabels_atxt; ",")
		
	Else 
		$Offset_L:=$MaxOffset_L
	End if 
	ARRAY LONGINT:C221($ElementNumbers_aL; Size of array:C274($ElementNumbers_atxt))
	C_LONGINT:C283($loop_L)
	For ($loop_L; 1; Size of array:C274($ElementNumbers_atxt))
		$ElementNumbers_aL{$loop_L}:=Num:C11($ElementNumbers_atxt{$loop_L})
	End for 
	
	USE SET:C118("$MySet")
	//QUERY SELECTION WITH ARRAY([LSS_ElementInspection];[LSS_ElementInspection]LSS_SectionID_L=Num($ElementType_txt))
	QUERY SELECTION WITH ARRAY:C1050([LSS_ElementInspection:163]LSS_ElementId_L:2; $ElementNumbers_aL)
	
	$Size_l:=0
	ARRAY LONGINT:C221($ElementNo_al; $Size_l)
	ARRAY TEXT:C222($Deficiency_as; $Size_l)  //Deficiencies//Command Replaced was o_ARRAY string length was 3
	ARRAY TEXT:C222($Urgency_as; $Size_l)  //Command Replaced was o_ARRAY string length was 3
	ARRAY TEXT:C222($Description_as; $Size_l)  //Command Replaced was o_ARRAY string length was 40
	ARRAY TEXT:C222($Rating_as; $Size_l)  //Command Replaced was o_ARRAY string length was 1
	ARRAY TEXT:C222($Remarks_atxt; $Size_l)
	$Size_l:=Records in selection:C76([LSS_ElementInspection:163])
	ARRAY LONGINT:C221($ElementNo_al; $Size_l)
	ARRAY TEXT:C222($Deficiency_as; $Size_l)  //Deficiencies//Command Replaced was o_ARRAY string length was 3
	ARRAY TEXT:C222($Urgency_as; $Size_l)  //Command Replaced was o_ARRAY string length was 3
	ARRAY TEXT:C222($Description_as; $Size_l)  //Command Replaced was o_ARRAY string length was 40
	ARRAY TEXT:C222($Rating_as; $Size_l)  //Command Replaced was o_ARRAY string length was 1
	ARRAY TEXT:C222($Remarks_atxt; $Size_l)
	SELECTION RANGE TO ARRAY:C368(1; $Size_l; [LSS_ElementInspection:163]LSS_ElementId_L:2; $ElementNo_al; [LSS_ElementInspection:163]LSS_Rating_s:4; $Rating_as; [LSS_ElementInspection:163]LSS_Deficiency_s:5; $Deficiency_as; [LSS_ElementInspection:163]LSS_Urgency_s:6; $Urgency_as; [LSS_ElementInspection:163]LSS_Description_txt:7; $Description_as; [LSS_ElementInspection:163]LSS_Remarks_txt:8; $Remarks_atxt)
	
	
	For ($Loop_l; 1; Size of array:C274($ElementNo_al))
		//Jan-2002 : Remove spaces from Deficiency
		$Deficiency_as{$Loop_l}:=Replace string:C233($Deficiency_as{$Loop_l}; " "; "")
		//Apr-2002 : Remove spaces from Priority
		$Urgency_as{$Loop_l}:=Replace string:C233($Urgency_as{$Loop_l}; " "; "")
		If ($Deficiency_as{$Loop_l}="N")
			$Deficiency_as{$Loop_l}:="-"  //default display of no deficiency
		End if 
		//If (Length($Urgency_as{$Loop_l})#0)
		//$Urgency_as{$Loop_l}:=$Deficiency_as{$Loop_l}+"-"+$Urgency_as{$Loop_l}  `if there is a prio combine def+prio
		//Else 
		//$Urgency_as{$Loop_l}:=$Deficiency_as{$Loop_l}  ` else set it to deficiency alone            
		//End if 
		
	End for 
	
	C_LONGINT:C283($ReturnLengthLimit_L)
	$ReturnLengthLimit_L:=32
	//$ReturnLengthLimit_L:=INSP_ReturnCMLength
	
	
	ARRAY TEXT:C222($Letters_atxt; 0)
	ARRAY TEXT:C222($Letters_atxt; 26)
	$Letters_atxt{1}:="a"
	$Letters_atxt{2}:="b"
	$Letters_atxt{3}:="c"
	$Letters_atxt{4}:="d"
	$Letters_atxt{5}:="e"
	$Letters_atxt{6}:="f"
	$Letters_atxt{7}:="g"
	$Letters_atxt{8}:="h"
	$Letters_atxt{9}:="i"
	$Letters_atxt{10}:="j"
	$Letters_atxt{11}:="k"
	$Letters_atxt{12}:="l"
	$Letters_atxt{13}:="m"
	$Letters_atxt{14}:="n"
	$Letters_atxt{15}:="o"
	$Letters_atxt{16}:="p"
	$Letters_atxt{17}:="q"
	$Letters_atxt{18}:="r"
	$Letters_atxt{19}:="s"
	$Letters_atxt{20}:="t"
	$Letters_atxt{21}:="u"
	$Letters_atxt{22}:="v"
	$Letters_atxt{23}:="w"
	$Letters_atxt{24}:="x"
	$Letters_atxt{25}:="y"
	$Letters_atxt{26}:="z"
	For ($Loop_l; 1; Size of array:C274($ElementNumberLabels_atxt))
		For ($InnerLoop_l; 1; Size of array:C274($Letters_atxt))
			If (Position:C15($Letters_atxt{$InnerLoop_l}; $ElementNumberLabels_atxt{$Loop_l})>0)
				$ElementNumberLabels_atxt{$Loop_l}:=$Letters_atxt{$InnerLoop_l}+"."
				$InnerLoop_l:=Size of array:C274($Letters_atxt)+1
			End if 
		End for 
	End for 
	C_BOOLEAN:C305($SetLabelArray_b)
	C_TEXT:C284($ID_txt; $Rating_txt)
	$Rating_txt:=""
	C_LONGINT:C283($Query_L)
	$Query_L:=Num:C11($ElementType_txt)
	$ID_txt:=[LSS_Inspection:164]LSS_InspectionId_s:1
	Begin SQL
		select [LSS_ElementInspection].[LSS_Rating_s]
		from
		[LSS_ElementInspection]
		where
		[LSS_ElementInspection].[LSS_InspectionId_s] = :$ID_txt
		and 
		[LSS_ElementInspection].[LSS_ElementId_L] = :$Query_L
		into
		:$Rating_txt
	End SQL
	
	$VRptr:=Get pointer:C304("VR"+$ElementType_txt+"_0")
	$VRptr->:=$Rating_txt
	
	For ($Loop_l; 1; Size of array:C274($ElementNumbers_atxt))
		$SetLabelArray_b:=False:C215
		
		$ElementPosition_l:=Find in array:C230($ElementNo_al; Num:C11($ElementNumbers_atxt{$Loop_l}))
		$ElementDictPos_l:=Find in array:C230($v_163_002_aL; Num:C11($ElementNumbers_atxt{$Loop_l}))
		If ($ElementPosition_l>0)
			If (Length:C16($Remarks_atxt{$ElementPosition_l})>0)
				APPEND TO ARRAY:C911(LSS_ElementLabel_atxt; "")
				APPEND TO ARRAY:C911(LSS_ElementRemarks_atxt; $Remarks_atxt{$ElementPosition_l})
				APPEND TO ARRAY:C911(LSS_ElementHeader_ab; False:C215)
				APPEND TO ARRAY:C911(LSS_ElementHeaderNo_atxt; $ElementType_txt)
				$SetLabelArray_b:=True:C214
				
			End if 
		End if 
		$VTptr:=Get pointer:C304("VT"+$ElementType_txt+"_"+String:C10($Loop_l))
		$VRptr:=Get pointer:C304("VR"+$ElementType_txt+"_"+String:C10($Loop_l))
		$VDptr:=Get pointer:C304("VD"+$ElementType_txt+"_"+String:C10($Loop_l))
		$VUptr:=Get pointer:C304("VU"+$ElementType_txt+"_"+String:C10($Loop_l))
		
		$VTptr->:=""
		$VRptr->:=""
		$VDptr->:="-"
		$VUptr->:=""
		
		If ($ElementPosition_l>0)
			
			Case of 
				: (Length:C16($Description_as{$ElementPosition_l})>0)
					$VTptr->:=$ElementNumberLabels_atxt{$Loop_l}+" "+$Description_as{$ElementPosition_l}
				Else 
					If (Position:C15("Blank "; $v_163_007_atxt{$ElementDictPos_l})>0)
						
					Else 
						$VTptr->:=$ElementNumberLabels_atxt{$Loop_l}+" "+$v_163_007_atxt{$ElementDictPos_l}
					End if 
			End case 
			If ($SetLabelArray_b)
				LSS_ElementLabel_atxt{Size of array:C274(LSS_ElementLabel_atxt)}:=$VTptr->
				$SetLabelArray_b:=False:C215
			End if 
			//$VTptr->:=$Priority_as{$ElementPosition_l}
			If (($Rating_as{$ElementPosition_l}="") & ($Deficiency_as{$ElementPosition_l}="") & ($Urgency_as{$ElementPosition_l}=""))
				//leaves deficiency as "-"
			Else 
				$VRptr->:=$Rating_as{$ElementPosition_l}
				$VDptr->:=$Deficiency_as{$ElementPosition_l}
				$VUptr->:=$Urgency_as{$ElementPosition_l}
			End if 
		Else 
			If ($ElementDictPos_l>0)
				If (Position:C15("Blank "; $v_163_007_atxt{$ElementDictPos_l})>0)
					
				Else 
					$VTptr->:=$ElementNumberLabels_atxt{$Loop_l}+" "+$v_163_007_atxt{$ElementDictPos_l}
				End if 
				
			End if 
		End if 
	End for 
	
Until ($Offset_L>=$MaxOffset_L)
CLEAR SET:C117("$MySet")
//End insp_LoadESForReport