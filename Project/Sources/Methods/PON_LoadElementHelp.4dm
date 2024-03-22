//%attributes = {"invisible":true}
// Method: PON_LoadElementHelp
// Description
// load the help for an element.if defect only defect language
// if master or prot system load associated defect language
// 
// Parameters
// $0 :$HelpText_txt
// $1 :$ElemKey_L
// $2 :$Child_b(optional)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/19/15, 17:21:20
	// ----------------------------------------------------
	//Created : 
	Mods_2015_02
	// Modified by: Costas Manousakis-(Designer)-(1/29/16 17:02:42)
	Mods_2016_01_bug
	//  `changes to read the element notes and split them into notes and Commentary
	// Modified by: Costas Manousakis-(Designer)-(6/22/17 14:07:45)
	Mods_2017_06_bug
	//  `for application versions other than 11 use the v13 version of the template.
	// Modified by: Costas Manousakis-(Designer)-(3/22/19 11:11:49)
	Mods_2019_03
	//  `use ut_DOM_LoadXML to switch from Resource files to Parameters table.
	// Modified by: Costas Manousakis-(Designer)-(3/26/19 10:53:01)
	Mods_2019_03
	//  `use method RES_Load_to_Blob to load the required web template
End if 
//
C_TEXT:C284($0)
C_LONGINT:C283($1)

C_LONGINT:C283($elemKey_L)
$elemKey_L:=$1
C_BOOLEAN:C305($Child_b)
$Child_b:=False:C215
If (Count parameters:C259>1)
	C_BOOLEAN:C305($2)
	$Child_b:=$2
Else 
	ARRAY LONGINT:C221(PON_HLP_Defects_aL; 0)
	ARRAY TEXT:C222(PON_HLP_Defects_atxt; 0)
	ARRAY TEXT:C222(PON_HLP_Defect_S1_atxt; 0)
	ARRAY TEXT:C222(PON_HLP_Defect_S2_atxt; 0)
	ARRAY TEXT:C222(PON_HLP_Defect_S3_atxt; 0)
	ARRAY TEXT:C222(PON_HLP_Defect_S4_atxt; 0)
	
End if 
C_TEXT:C284($HelpText_txt; PON_DEFECT_ELEM_TREE; PON_DEFECT_LANG_TREE)
C_LONGINT:C283(PON_HLP_ElementNo_L)
C_TEXT:C284(PON_HLP_ElementDesc_txt; PON_HLP_ElementCmts_txt; PON_HLP_ElementNote_txt; PON_HLP_ElementType_txt)

$HelpText_txt:=""

If (PON_DEFECT_ELEM_TREE="")
	PON_DEFECT_ELEM_TREE:=ut_DOM_LoadXML("NBE"; "Element_DefectTree.xml")
End if 
If (PON_DEFECT_LANG_TREE="")
	PON_DEFECT_LANG_TREE:=ut_DOM_LoadXML("NBE"; "Defect_Language.xml")
End if 
C_TEXT:C284($Elem_cmnts_txt; $ElmCmntary_txt)
QUERY:C277([PON_ELEM_DEFS:178]; [PON_ELEM_DEFS:178]ELEM_KEY:1=$elemKey_L)
$Elem_cmnts_txt:=[PON_ELEM_DEFS:178]ELEM_NOTES:19
C_LONGINT:C283($Commentary_L)
$Commentary_L:=Position:C15("<Commentary>"; $Elem_cmnts_txt)
If ($Commentary_L>0)
	$ElmCmntary_txt:=Substring:C12($Elem_cmnts_txt; $Commentary_L)
	$ElmCmntary_txt:=Replace string:C233($ElmCmntary_txt; "<Commentary>"; "")
	$Elem_cmnts_txt:=Substring:C12($Elem_cmnts_txt; 1; ($Commentary_L-1))
End if 

Case of 
	: ([PON_ELEM_DEFS:178]ELEM_SMART_FLAG:4="Y")
		If ($Child_b)
		Else 
			PON_HLP_ElementType_txt:="Defect"
			PON_HLP_ElementNo_L:=$elemKey_L
			PON_HLP_ElementDesc_txt:=[PON_ELEM_DEFS:178]ELEM_LONGNAME:11
		End if 
		APPEND TO ARRAY:C911(PON_HLP_Defects_aL; $elemKey_L)
		APPEND TO ARRAY:C911(PON_HLP_Defects_atxt; [PON_ELEM_DEFS:178]ELEM_LONGNAME:11)
		
		
		C_TEXT:C284($defectRef_txt; $stateRef_txt)
		ARRAY TEXT:C222($DefectRefs_atxt; 0)
		$defectRef_txt:=DOM Find XML element:C864(PON_DEFECT_LANG_TREE; "Root/Defect"; $DefectRefs_atxt)
		
		C_LONGINT:C283($loop_L; $defectVal_L)
		For ($loop_L; 1; Size of array:C274($DefectRefs_atxt))
			DOM GET XML ELEMENT VALUE:C731($DefectRefs_atxt{$loop_L}; $defectVal_L)
			If ($elemKey_L=$defectVal_L)
				ARRAY TEXT:C222($StateRefs_atxt; 0)
				$stateRef_txt:=DOM Find XML element:C864($DefectRefs_atxt{$loop_L}; "Defect/State"; $StateRefs_atxt)
				ARRAY TEXT:C222($StateLang_atxt; Size of array:C274($StateRefs_atxt))
				C_LONGINT:C283($loop2_L; $state_L)
				For ($loop2_L; 1; Size of array:C274($StateRefs_atxt))
					DOM GET XML ELEMENT VALUE:C731($StateRefs_atxt{$loop2_L}; $state_L)
					DOM GET XML ATTRIBUTE BY NAME:C728($StateRefs_atxt{$loop2_L}; "Language"; $StateLang_atxt{$loop2_L})
					Case of 
						: ($state_L=1)
							APPEND TO ARRAY:C911(PON_HLP_Defect_S1_atxt; $StateLang_atxt{$loop2_L})
						: ($state_L=2)
							APPEND TO ARRAY:C911(PON_HLP_Defect_S2_atxt; $StateLang_atxt{$loop2_L})
						: ($state_L=3)
							APPEND TO ARRAY:C911(PON_HLP_Defect_S3_atxt; $StateLang_atxt{$loop2_L})
						: ($state_L=4)
							APPEND TO ARRAY:C911(PON_HLP_Defect_S4_atxt; $StateLang_atxt{$loop2_L})
					End case 
				End for 
				
				$loop_L:=Size of array:C274($DefectRefs_atxt)+1
				
			End if 
			
		End for 
		
	Else 
		// find allowed defects
		PON_HLP_ElementType_txt:="Element"
		If ([PON_ELEM_DEFS:178]ELEM_PROTECT_SYS:3="Y")
			PON_HLP_ElementType_txt:="Protective System"
		End if 
		PON_HLP_ElementNo_L:=$elemKey_L
		PON_HLP_ElementDesc_txt:=[PON_ELEM_DEFS:178]ELEM_LONGNAME:11
		C_TEXT:C284($defectRef_txt)
		ARRAY TEXT:C222($ElementRefs_atxt; 0)
		$defectRef_txt:=DOM Find XML element:C864(PON_DEFECT_ELEM_TREE; "Root/Element"; $ElementRefs_atxt)
		C_LONGINT:C283($loop_L; $defectVal_L; $ElementVal_L)
		
		For ($loop_L; 1; Size of array:C274($ElementRefs_atxt))
			
			DOM GET XML ELEMENT VALUE:C731($ElementRefs_atxt{$loop_L}; $ElementVal_L)
			
			If ($elemKey_L=$ElementVal_L)
				$defectRef_txt:=DOM Find XML element:C864($ElementRefs_atxt{$loop_L}; "Element/Defect"; $DefectRefs_atxt)
				
				C_LONGINT:C283($loop2_L)
				For ($loop2_L; 1; Size of array:C274($DefectRefs_atxt))
					DOM GET XML ELEMENT VALUE:C731($DefectRefs_atxt{$loop2_L}; $defectVal_L)
					$HelpText_txt:=PON_LoadElementHelp($defectVal_L; True:C214)  // doing a child
				End for 
				$loop_L:=Size of array:C274($ElementRefs_atxt)+1
			End if 
			
		End for 
		
End case 
If ($Child_b)
Else 
	C_BLOB:C604($template_blb)
	C_TEXT:C284($templVers_txt)
	$templVers_txt:=Substring:C12(Application version:C493; 1; 2)
	
	If ($templVers_txt="11")
		
	Else 
		//all others use the v13 version
		$templVers_txt:="13"
	End if 
	
	//THETEMPLATE_NEEDSFIX:=True  ` ****   DESIGNER Note to watch out for this
	//the templates have to change to use 4DHTMLVAR (v11) / 4DHTMLTEXT (v13) for the PON_HLP_ElementCmts_txt and PON_HLP_ElementNote_txt variables
	//When building need to make sure we get the templates from the Dev server - they are fixed.
	//also on boston server fixed - need to copy them to External 16-feb-16
	//DOCUMENT TO BLOB(Get 4D folder(Current resources folder)+"NBE"+<>PL_DirectorySep_s+"Pon_HelpTemplate_v"+$templVers_txt+".xml";$template_blb)
	$template_blb:=RES_Load_to_Blob("NBE"; "Pon_HelpTemplate_v"+$templVers_txt+".xml")
	PON_HLP_ElementCmts_txt:=$Elem_cmnts_txt
	PON_HLP_ElementNote_txt:=$ElmCmntary_txt
	PROCESS 4D TAGS:C816($template_blb; $template_blb)
	$HelpText_txt:=BLOB to text:C555($template_blb; UTF8 text without length:K22:17)
End if 
$0:=$HelpText_txt
//End PON_LoadElementHelp