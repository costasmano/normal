//%attributes = {"invisible":true}
//Method: MAP_SetLabelFields
//Description
// Set the fields to be used in the point label
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/28/16, 14:42:44
	// ----------------------------------------------------
	//Created : 
	Mods_2016_11
	// Modified by: Costas Manousakis-(Designer)-(12/9/16 16:35:33)
	Mods_2016_12
	//  `use the field names set by SET FIELD TITLES
End if 
//
ARRAY TEXT:C222($AllBridgeFields_atxt; 0)
ARRAY LONGINT:C221($AllBridgeFields_aL; 0)
GET FIELD TITLES:C804([Bridge MHD NBIS:1]; $AllBridgeFields_atxt; $AllBridgeFields_aL)

ARRAY TEXT:C222($LabelFieldNames; 0)
ARRAY POINTER:C280(KML_LabelFields_aptr; 0)

APPEND TO ARRAY:C911(KML_LabelFields_aptr; ->[Bridge MHD NBIS:1]BDEPT:1)
APPEND TO ARRAY:C911(KML_LabelFields_aptr; ->[Bridge MHD NBIS:1]BIN:3)

ARRAY LONGINT:C221($fieldNos_aL; Size of array:C274(KML_LabelFields_aptr))
ARRAY TEXT:C222($LabelFieldNames; Size of array:C274(KML_LabelFields_aptr))
C_LONGINT:C283($loop_L; $table_L; $numFields_L; $sortFldIndx_L)

For ($loop_L; 1; Size of array:C274($fieldNos_aL))
	$fieldNos_aL{$loop_L}:=Field:C253(KML_LabelFields_aptr{$loop_L})
	$sortFldIndx_L:=Find in array:C230($AllBridgeFields_aL; $fieldNos_aL{$loop_L})
	
	If ($sortFldIndx_L>0)
		$LabelFieldNames{$loop_L}:=$AllBridgeFields_atxt{$sortFldIndx_L}
	Else 
		$LabelFieldNames{$loop_L}:=Field name:C257(KML_Fields_aptr{$loop_L})
	End if 
End for 
ARRAY TEXT:C222($AvailableFields_atxt; 0)
ARRAY LONGINT:C221($AvailableFields_aL; 0)
$table_L:=Table:C252(->[Bridge MHD NBIS:1])
C_POINTER:C301($Field_ptr)
$numFields_L:=Size of array:C274($AllBridgeFields_atxt)
For ($loop_L; 1; $numFields_L)
	If (Is field number valid:C1000($table_L; $AllBridgeFields_aL{$loop_L}))
		If (Find in array:C230($fieldNos_aL; $AllBridgeFields_aL{$loop_L})>0)
		Else 
			$Field_ptr:=Field:C253($table_L; $AllBridgeFields_aL{$loop_L})
			Case of 
				: (Type:C295($Field_ptr->)=Is BLOB:K8:12)
				: (Type:C295($Field_ptr->)=Is picture:K8:10)
				Else 
					APPEND TO ARRAY:C911($AvailableFields_atxt; $AllBridgeFields_atxt{$loop_L})
					APPEND TO ARRAY:C911($AvailableFields_aL; $AllBridgeFields_aL{$loop_L})
			End case 
			
		End if 
		
	End if 
End for 

C_LONGINT:C283(UseList_HL; OmitList_HL)
C_BOOLEAN:C305(TWOLIST_MOVEONLY_B)
TWOLIST_MOVEONLY_B:=False:C215
UseList_HL:=ut_ArrayToHL(->$AvailableFields_atxt; ""; ->$AvailableFields_aL)
OmitList_HL:=ut_ArrayToHL(->$LabelFieldNames; ""; ->$fieldNos_aL)

C_TEXT:C284(vCancelBtntxt; vOKBtnTxt; vUseListLbl_txt; vOmitLbl_txt)
vCancelBtntxt:="Use Original"
vOKBtnTxt:="Proceed"
vUseListLbl_txt:="Available Bridge Fields"
vOmitLbl_txt:="Fields to be included in the Label"
C_BOOLEAN:C305($DoSum_b)
$DoSum_b:=False:C215
C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
C_TEXT:C284($Title_txt)
FORM GET PROPERTIES:C674("TwoListMove"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10; "Select Bridge Fields for the Label of the Bridge Point"; "ut_CloseCancel")
DIALOG:C40("TwoListMove")
CLOSE WINDOW:C154($Win_l)

If (OK=1)
	C_LONGINT:C283($num_selected_L)
	$num_selected_L:=Count list items:C380(OmitList_HL)
	If ($num_selected_L>0)
		C_LONGINT:C283($ref)
		C_TEXT:C284($Name)
		ARRAY POINTER:C280(KML_LabelFields_aptr; $num_selected_L)
		For ($loop_L; 1; $num_selected_L)
			GET LIST ITEM:C378(OmitList_HL; $loop_L; $Ref; $Name)
			KML_LabelFields_aptr{$loop_L}:=Field:C253($table_L; $Ref)
		End for 
		
	Else 
		ALERT:C41("There were no Fields selected! Using Original set!")
		
	End if 
	
End if 
If (Is a list:C621(UseList_HL))
	CLEAR LIST:C377(UseList_HL; *)
End if 
If (Is a list:C621(OmitList_HL))
	CLEAR LIST:C377(OmitList_HL; *)
End if 
//End MAP_SetLabelFields