//%attributes = {"invisible":true}
//Method: LSS_FillDamagePage_1
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 07/19/18, 14:19:41
	// ----------------------------------------------------
	//Created : 
	Mods_2018_07
End if 

FORM_FixHairLine
C_TEXT:C284(vDamageDate)  // Command Replaced was o_C_STRING length was 80


If ([LSS_Inspection:164]LSS_Damage_d:52#!00-00-00!)
	vDamageDate:=String:C10([LSS_Inspection:164]LSS_Damage_d:52; Internal date short:K1:7)
Else 
	vDamageDate:="UNKNOWN"
End if 



//
C_TEXT:C284($1; $InspectionType_txt; $ElementType_txt; $ElementNumbers_txt; $T_final; $ElementLbls_txt)
$InspectionType_txt:=$1
C_LONGINT:C283($MaxOffset_L; $Offset_L; $Position_L; $Loop_l; $Size_l; $ElementPosition_l; $ElementDictPos_l; $InnerLoop_l; $Page1ElementCount_L)
C_TEXT:C284($InspType_txt)

Case of 
	: ([LSS_Inventory:165]LSS_Category_s:2="Sign") | ([LSS_Inventory:165]LSS_InventoryType_s:28="HS")
		$InspType_txt:="HS"
		$Page1ElementCount_L:=4
	: ([LSS_Inventory:165]LSS_Category_s:2="Light") | ([LSS_Inventory:165]LSS_InventoryType_s:28="LI")
		$InspType_txt:="LI"
		$Page1ElementCount_L:=5
	: ([LSS_Inventory:165]LSS_Category_s:2="Signal") | ([LSS_Inventory:165]LSS_InventoryType_s:28="SI")
		$InspType_txt:="SI"
		$Page1ElementCount_L:=5
	: ([LSS_Inventory:165]LSS_Category_s:2="ITS") | ([LSS_Inventory:165]LSS_InventoryType_s:28="IT")
		$Page1ElementCount_L:=5
		$InspType_txt:="IT"
End case 
C_TEXT:C284($InventoryID_txt)
$InspType_txt:=$InspType_txt+"%"
$InventoryID_txt:=[LSS_Inspection:164]LSS_InventoryId_s:2
C_DATE:C307($r_inspection_d; $i_inspection_d)
$r_inspection_d:=!00-00-00!
$i_inspection_d:=$r_inspection_d
C_TEXT:C284($InspType1_txt)
$InspType1_txt:=$InspType_txt
Begin SQL
	select
	[LSS_refInspectionType].[LSS_InspectionTypeId_s]
	from
	[LSS_refInspectionType]
	where
	[LSS_refInspectionType].[LSS_InspectionTypeId_s] like :$InspType_txt
	and
	[LSS_refInspectionType].[LSS_Description_txt] = 'Routine'
	into
	:$InspType_txt;
	
	
	select
	[LSS_refInspectionType].[LSS_InspectionTypeId_s]
	from
	[LSS_refInspectionType]
	where
	[LSS_refInspectionType].[LSS_InspectionTypeId_s] like :$InspType1_txt
	and
	[LSS_refInspectionType].[LSS_Description_txt] = 'Initial'
	into
	:$InspType1_txt;
	
	select
	MAX([LSS_Inspection].[LSS_InspectionDate_d])
	from
	[LSS_Inspection]
	where
	[LSS_Inspection].[LSS_InspectionTypeId_s] = :$InspType_txt
	and
	[LSS_Inspection].[LSS_InventoryId_s] = :$InventoryID_txt
	
	into
	:$r_inspection_d;
	
	select
	MAX([LSS_Inspection].[LSS_InspectionDate_d])
	from
	[LSS_Inspection]
	where
	[LSS_Inspection].[LSS_InspectionTypeId_s] = :$InspType1_txt
	and
	[LSS_Inspection].[LSS_InventoryId_s] = :$InventoryID_txt
	
	into
	:$i_inspection_d;
End SQL
If ($r_inspection_d#!00-00-00!)
	OBJECT SET TITLE:C194(*; "LastRTNDate"; String:C10($r_inspection_d))
Else 
	If ($i_inspection_d#!00-00-00!)
		OBJECT SET TITLE:C194(*; "LastRTNDate"; String:C10($i_inspection_d))
	End if 
End if 
QUERY:C277([LSS_refInspectionType:167]; [LSS_refInspectionType:167]LSS_InspectionTypeId_s:1=$InspectionType_txt)
Case of 
	: (Substring:C12($InspectionType_txt; 1; 2)="IT")
		vInspTitlePr:=[LSS_refInspectionType:167]LSS_Description_txt:2+" ITS Inspection"
		
	: (Substring:C12($InspectionType_txt; 1; 2)="HS")
		vInspTitlePr:=[LSS_refInspectionType:167]LSS_Description_txt:2+" HIGHWAY SIGN Inspection"
		QUERY:C277([LSS_SignPanel:172]; [LSS_SignPanel:172]LSS_InspectionId_s:2=[LSS_Inspection:164]LSS_InspectionId_s:1)
		ORDER BY:C49([LSS_SignPanel:172]; [LSS_SignPanel:172]LSS_Panel_s:3; >)
		$Size_l:=Records in selection:C76([LSS_SignPanel:172])
		If ($Size_l>16)
			$Size_l:=16
		End if 
		C_POINTER:C301($Varible_ptr)
		For ($Loop_l; 1; $Size_l)
			GOTO SELECTED RECORD:C245([LSS_SignPanel:172]; $Loop_l)
			$Varible_ptr:=Get pointer:C304("LSS_Panel"+String:C10($Loop_l)+"_txt")
			$Varible_ptr->:=[LSS_SignPanel:172]LSS_Panel_s:3
			$Varible_ptr:=Get pointer:C304("LSS_Width"+String:C10($Loop_l)+"_txt")
			$Varible_ptr->:=[LSS_SignPanel:172]LSS_Width_s:4
			$Varible_ptr:=Get pointer:C304("LSS_Height"+String:C10($Loop_l)+"_txt")
			$Varible_ptr->:=[LSS_SignPanel:172]LSS_Height_s:5
			$Varible_ptr:=Get pointer:C304("LSS_Message"+String:C10($Loop_l)+"_txt")
			$Varible_ptr->:=[LSS_SignPanel:172]LSS_PanelMessage_txt:6
			$Varible_ptr:=Get pointer:C304("LSS_PanelType"+String:C10($Loop_l)+"_txt")
			$Varible_ptr->:=[LSS_SignPanel:172]LSS_PanelType_s:7
			$Varible_ptr:=Get pointer:C304("LSS_LanesOver"+String:C10($Loop_l)+"_txt")
			$Varible_ptr->:=[LSS_SignPanel:172]LSS_LanesPanelOver_txt:8
		End for 
	: (Substring:C12($InspectionType_txt; 1; 2)="LI")
		vInspTitlePr:=[LSS_refInspectionType:167]LSS_Description_txt:2+" OVERHEAD LIGHT Inspection"
	: (Substring:C12($InspectionType_txt; 1; 2)="SI")
		vInspTitlePr:=[LSS_refInspectionType:167]LSS_Description_txt:2+" SIGNAL Inspection"
		
End case 
CLEAR VARIABLE:C89(v_164_056_txt)
CLEAR VARIABLE:C89(v_164_059_txt)
C_LONGINT:C283($OLeft_L; $ORight_L; $OTop_L; $OBottom_L; $BWidth_l; $BHeight_L; $OWidth_L; $OHeight_L)
OBJECT GET COORDINATES:C663(*; "v_164_056_txt"; $OLeft_L; $OTop_L; $ORight_L; $OBottom_L)
$OWidth_L:=$ORight_L-$OLeft_L
$OHeight_L:=$OBottom_L-$OTop_L
$OHeight_L:=$OBottom_L-$OTop_L
C_TEXT:C284($text_txt)
v_164_056_txt:=""
$text_txt:=ST Get text:C1116([LSS_Inspection:164]LSS_DamageCause_txt:56; ST Start text:K78:15; ST End text:K78:16)
ST SET TEXT:C1115(v_164_056_txt; "CAUSE OF DAMAGE : "+$text_txt; ST Start text:K78:15; ST End text:K78:16)
$pos_L:=Length:C16("CAUSE OF DAMAGE : ")
ST SET ATTRIBUTES:C1093(v_164_056_txt; 1; $pos_L; Attribute bold style:K65:1; 1)
ST SET ATTRIBUTES:C1093(v_164_056_txt; 1; $pos_L; Attribute background color:K65:8; "LightGray")

OBJECT GET BEST SIZE:C717(*; "v_164_056_txt"; $BWidth_l; $BHeight_L; $OWidth_L)
If ($BHeight_L>$OHeight_L)
	v_164_056_txt:=""
	ST SET TEXT:C1115(v_164_056_txt; "CAUSE OF DAMAGE : "+Char:C90(Carriage return:K15:38)+"See REMARKS"+Char:C90(Carriage return:K15:38))
	ST SET ATTRIBUTES:C1093(v_164_056_txt; 1; $pos_L; Attribute bold style:K65:1; 1)
	ST SET ATTRIBUTES:C1093(v_164_056_txt; 1; $pos_L; Attribute background color:K65:8; "LightGray")
	
End if 

OBJECT GET COORDINATES:C663(*; "v_164_059_txt"; $OLeft_L; $OTop_L; $ORight_L; $OBottom_L)
$OWidth_L:=$ORight_L-$OLeft_L
$OHeight_L:=$OBottom_L-$OTop_L
$text_txt:=ST Get text:C1116([LSS_Inspection:164]LSS_Recommendations_txt:26; ST Start text:K78:15; ST End text:K78:16)
v_164_059_txt:=""
ST SET TEXT:C1115(v_164_059_txt; "RECOMMENDATIONS : "+$text_txt; ST Start text:K78:15; ST End text:K78:16)
$pos_L:=Length:C16("RECOMMENDATIONS : ")  //
ST SET ATTRIBUTES:C1093(v_164_059_txt; 1; $pos_L; Attribute bold style:K65:1; 1)
ST SET ATTRIBUTES:C1093(v_164_059_txt; 1; $pos_L; Attribute background color:K65:8; "LightGray")

OBJECT GET BEST SIZE:C717(*; "v_164_059_txt"; $BWidth_l; $BHeight_L; $OWidth_L)
If ($BHeight_L>$OHeight_L)
	v_164_059_txt:=""
	ST SET TEXT:C1115(v_164_059_txt; "RECOMMENDATIONS : "+Char:C90(Carriage return:K15:38)+"See REMARKS"+Char:C90(Carriage return:K15:38))
	ST SET ATTRIBUTES:C1093(v_164_059_txt; 1; $pos_L; Attribute bold style:K65:1; 1)
	ST SET ATTRIBUTES:C1093(v_164_059_txt; 1; $pos_L; Attribute background color:K65:8; "LightGray")
End if 

v_164_057_txt:=""
$text_txt:=ST Get text:C1116([LSS_Inspection:164]LSS_DamBostonOfficeRemarks_txt:59; ST Start text:K78:15; ST End text:K78:16)
ST SET TEXT:C1115(v_164_057_txt; "Remarks : "+$text_txt; ST Start text:K78:15; ST End text:K78:16)
$pos_L:=Length:C16("Remarks : ")  //
ST SET ATTRIBUTES:C1093(v_164_057_txt; 1; $pos_L; Attribute bold style:K65:1; 1)
ST SET ATTRIBUTES:C1093(v_164_057_txt; 1; $pos_L; Attribute background color:K65:8; "LightGray")


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
C_POINTER:C301($ptr)
C_BOOLEAN:C305($Complete_B)
C_LONGINT:C283($pos_L; $Start_L)
$Start_L:=0
$Complete_B:=False:C215
$Loop_l:=0
$Position_L:=0
$Complete_B:=False:C215
For ($Loop_l; 1; $Page1ElementCount_L)
	$ptr:=Get pointer:C304("vMember"+String:C10($Loop_l; "00"))
	$ptr->:=""
	$ptr:=Get pointer:C304("vCrack"+String:C10($Loop_l))
	$ptr->:=""
	$ptr:=Get pointer:C304("vWeld"+String:C10($Loop_l))
	$ptr->:=""
	$ptr:=Get pointer:C304("vRemarks"+String:C10($Loop_l; "00"))
	$ptr->:=""
	$ptr:=Get pointer:C304("vprevR"+String:C10($Loop_l; "00"))
	$ptr->:=""
	$ptr:=Get pointer:C304("vR"+String:C10($Loop_l; "00"))
	$ptr->:=""
	$ptr:=Get pointer:C304("vDEF"+String:C10($Loop_l; "00"))
	$ptr->:=""
End for 
$Loop_l:=0
Repeat 
	$Loop_l:=$Loop_l+1
	
	If ($Loop_l>Size of array:C274(LSS_Page1Postions_aL))
		$Complete_B:=True:C214
	Else 
		If (LSS_Page1Postions_aL{$Loop_l}=0)
		Else 
			$ptr:=Get pointer:C304("vMember"+String:C10($Loop_l; "00"))
			$ptr->:=v_163_007_atxt{LSS_Page1Postions_aL{$Loop_l}}
			$ptr:=Get pointer:C304("vCrack"+String:C10($Loop_l))
			$ptr->:=LSS_Crack_atxt{LSS_Page1Postions_aL{$Loop_l}}
			$ptr:=Get pointer:C304("vWeld"+String:C10($Loop_l))
			$ptr->:=v_163_014_atxt{LSS_Page1Postions_aL{$Loop_l}}
			$ptr:=Get pointer:C304("vRemarks"+String:C10($Loop_l; "00"))
			If (LSS_AddtoCommentsPAGE_AB{LSS_Page1Postions_aL{$Loop_l}})
				$ptr->:="See remarks in comments section."
			Else 
				$ptr->:=v_163_008_atxt{LSS_Page1Postions_aL{$Loop_l}}
			End if 
			Case of   //added this to fit text.
				: (Length:C16($ptr->)>29)
					OBJECT SET FONT SIZE:C165($ptr->; 8)
				: (Length:C16($ptr->)>27)
					OBJECT SET FONT SIZE:C165($ptr->; 9)
				: (Length:C16($ptr->)>24)
					OBJECT SET FONT SIZE:C165($ptr->; 10)
			End case 
			$ptr:=Get pointer:C304("vprevR"+String:C10($Loop_l; "00"))
			$ptr->:=v_163_013_atxt{LSS_Page1Postions_aL{$Loop_l}}
			$ptr:=Get pointer:C304("vR"+String:C10($Loop_l; "00"))
			$ptr->:=v_163_004_atxt{LSS_Page1Postions_aL{$Loop_l}}
			$ptr:=Get pointer:C304("vDEF"+String:C10($Loop_l; "00"))
			$ptr->:=v_163_005_atxt{LSS_Page1Postions_aL{$Loop_l}}+"-"+v_163_006_atxt{LSS_Page1Postions_aL{$Loop_l}}
			
		End if 
	End if 
Until ($Complete_B)

vAccident:=f_Boolean2String([LSS_Inspection:164]LSS_DamageAccidentReport_B:54; "YN")
LSS_FillNames
If (LSS_CountingPage_B)
	CANCEL:C270
End if 

//End LSS_FillDamagePage_1