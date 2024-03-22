//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method: INSP_VerifySIAChanges
// Description
// Verify the changes to be made on the SIA record.
// Uses what is store in the ptr_changes array 1
// 
// Parameters
// $0 : $Proceed_b
// $1 : $Stack_L of ptr_changes
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/20/07, 12:28:54
	// ----------------------------------------------------
	
	Mods_2007_CM_5401
	// Modified by: costasmanousakis-(Designer)-(2/13/08 14:16:29)
	Mods_2008_CM_5402
	//  `Give CancelButton label invisible. so that only the PROCEED button is shown
	// Modified by: costasmanousakis-(Designer)-(6/2/08 10:47:01)
	Mods_2008_CM_5403
	//  `Fix translation of boolean fields
	Mods_2009_03  //CJM  r001   `03/06/09, 15:13:28`Upgrade from open form window to open window
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
	Mods_2011_09  // CJ Miller`09/22/11, 11:18:56      ` Remove $vIndex from get field properties as it was not defined correctly and not used
	// Modified by: costasmanousakis-(Designer)-(10/27/11 09:35:47)
	Mods_2011_10
	//  `Added missing CLOSE WINDOW at the end
	// Modified by: Costas Manousakis-(Designer)-(9/1/15 10:39:08)
	Mods_2015_09
	//  `The TwoListMove dialog is a Project Form now
	// Modified by: Costas Manousakis-(Designer)-(11/28/16 14:46:43)
	Mods_2016_11
	//  `clear HLists at the end
End if 
C_BOOLEAN:C305($0; $Proceed_b)
C_LONGINT:C283($1; $level)
$level:=$1
$Proceed_b:=False:C215
C_LONGINT:C283($NumChgs_L)
$NumChgs_L:=Size of array:C274(ptr_Changes{$level})
If ($NumChgs_L>0)
	ARRAY TEXT:C222(INSPVerifChgs_atxt; $NumChgs_L)
	//assemble changes in text array
	C_LONGINT:C283($vType; $vLength; $vIndex; $i; $k)
	C_POINTER:C301($Fld)
	C_TEXT:C284($vsFldName)
	For ($i; 1; $NumChgs_L)
		$fld:=ptr_Changes{$level}{$i}
		GET FIELD PROPERTIES:C258($fld; $vType; $vLength)
		$vsFldName:=Field name:C257($fld)
		INSPVerifChgs_atxt{$i}:="["+$vsFldName+"] To :"
		Case of 
			: ($vType=Is alpha field:K8:1)  //Alpha
				INSPVerifChgs_atxt{$i}:=INSPVerifChgs_atxt{$i}+$fld->+"  From :"+Old:C35($fld->)
			: ($vType=Is real:K8:4)  //Real
				INSPVerifChgs_atxt{$i}:=INSPVerifChgs_atxt{$i}+String:C10($fld->)+"  From :"+String:C10(Old:C35($fld->))
			: ($vType=Is text:K8:3)  //Text
				INSPVerifChgs_atxt{$i}:=INSPVerifChgs_atxt{$i}+$fld->
			: ($vType=Is picture:K8:10)  //Picture
				INSPVerifChgs_atxt{$i}:=INSPVerifChgs_atxt{$i}+"New size="+String:C10(Picture size:C356($fld->))
			: ($vType=Is date:K8:7)  //Date
				INSPVerifChgs_atxt{$i}:=INSPVerifChgs_atxt{$i}+String:C10($fld->)+"  From :"+String:C10(Old:C35($fld->))
			: ($vType=Is boolean:K8:9)  //Boolean
				INSPVerifChgs_atxt{$i}:=INSPVerifChgs_atxt{$i}+f_Boolean2String($fld->; "YN")+"  From :"+f_Boolean2String(Old:C35($fld->); "YN")
			: ($vType=Is integer:K8:5)  //Integer
				INSPVerifChgs_atxt{$i}:=INSPVerifChgs_atxt{$i}+String:C10($fld->)+"  From :"+String:C10(Old:C35($fld->))
			: ($vType=Is longint:K8:6)  //Longint
				INSPVerifChgs_atxt{$i}:=INSPVerifChgs_atxt{$i}+String:C10($fld->)+"  From :"+String:C10(Old:C35($fld->))
			: ($vType=Is time:K8:8)  //Time
				INSPVerifChgs_atxt{$i}:=INSPVerifChgs_atxt{$i}+String:C10($fld->)+"  From :"+String:C10(Old:C35($fld->))
			: ($vType=Is BLOB:K8:12)  //Blob
				INSPVerifChgs_atxt{$i}:=INSPVerifChgs_atxt{$i}+"New size="+String:C10(BLOB size:C605($fld->))
		End case 
	End for 
	
	For ($i; $NumChgs_L; 1; -1)
		Case of 
			: (Position:C15(Field name:C257(->[Bridge MHD NBIS:1]DateModified:194); INSPVerifChgs_atxt{$i})>0)
				DELETE FROM ARRAY:C228(INSPVerifChgs_atxt; $i)
			: (Position:C15(Field name:C257(->[Bridge MHD NBIS:1]TimeModified:195); INSPVerifChgs_atxt{$i})>0)
				DELETE FROM ARRAY:C228(INSPVerifChgs_atxt; $i)
			: (Position:C15(Field name:C257(->[Bridge MHD NBIS:1]Modified By:191); INSPVerifChgs_atxt{$i})>0)
				DELETE FROM ARRAY:C228(INSPVerifChgs_atxt; $i)
		End case 
		
	End for 
	C_LONGINT:C283(UseList_HL; OmitList_HL)
	UseList_HL:=ut_ArrayToHL(->INSPVerifChgs_atxt)
	OmitList_HL:=New list:C375
	C_TEXT:C284(vCancelBtntxt; vOKBtnTxt; vUseListLbl_txt; vOmitLbl_txt)
	vCancelBtntxt:="INVISIBLE"
	vOKBtnTxt:="Proceed"
	vUseListLbl_txt:="Changes to be made to the SIA Record"
	vOmitLbl_txt:="Changes to be Omitted"
	//Display 
	
	C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
	C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
	C_TEXT:C284($Title_txt)
	FORM GET PROPERTIES:C674("TwoListMove"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
	$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10; $Title_txt; "ut_CloseCancel")
	//$winID:=Open form window([Dialogs];"TwoListMove")
	DIALOG:C40("TwoListMove")
	If (OK=1)
		If (Count list items:C380(UseList_HL)>0)
			If (Count list items:C380(OmitList_HL)>0)
				For ($i; $NumChgs_L; 1; -1)
					$fld:=ptr_Changes{$level}{$i}
					GET FIELD PROPERTIES:C258($fld; $vType; $vLength)
					$vsFldName:=Field name:C257($fld)
					$K:=ut_FindInHList(OmitList_HL; $vsFldName)
					If ($K>0)
						//it has been omitted  `set the field to old value
						$fld->:=Old:C35($fld->)
						//remove from the list of changes
						DELETE FROM ARRAY:C228(ptr_Changes{$level}; $i)
					End if 
				End for 
				
			End if 
			$Proceed_b:=True:C214
			
		Else 
			$Proceed_b:=False:C215
		End if 
		
	Else 
		$Proceed_b:=False:C215
	End if 
	CLOSE WINDOW:C154
	If (Is a list:C621(UseList_HL))
		CLEAR LIST:C377(UseList_HL; *)
	End if 
	If (Is a list:C621(OmitList_HL))
		CLEAR LIST:C377(OmitList_HL; *)
	End if 
	
End if 
$0:=$Proceed_b