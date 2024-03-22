//%attributes = {"invisible":true}
If (False:C215)
	//Procedure: CheckStructureType
	//MHD Bridge Inspection
	//Created By: Albert Leung
	//Date:  7/21/2003
	
	//Purpose: checks differences between other reports and inspection report.
	//Checks only Item 43 and Item 107.
	//Uses: [Dialogs];"CheckStructureType"
	
	// Modified by: costasmanousakis-(Designer)-(8/22/2007 15:46:13)
	Mods_2007_CM12_5301
	Mods_2009_03  //CJM  r001   `03/06/09, 14:18:05`Upgrade from open form window to open window
End if 

C_TEXT:C284(vtxtStructTypeInsp)  // Command Replaced was o_C_STRING length was 255
C_TEXT:C284(vtxtStructTypeSIA)  // Command Replaced was o_C_STRING length was 255
C_TEXT:C284(vtxtItem107Insp)  // Command Replaced was o_C_STRING length was 255
C_TEXT:C284(vtxtItem107SIA)  // Command Replaced was o_C_STRING length was 255
C_TEXT:C284(vItem43a_temp)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vItem43b_temp)  // Command Replaced was o_C_STRING length was 2
C_BOOLEAN:C305(vblnChkItem43)
C_BOOLEAN:C305(vblnChkItem107)
C_BOOLEAN:C305($blnDoCheck)

vItem43a_temp:=Substring:C12([Inspections:27]Item 43:140; 1; 1)
vItem43b_temp:=Substring:C12([Inspections:27]Item 43:140; 2; 2)
vtxtStructTypeInsp:=Get_Description(-><>aMaterial; -><>aMatCode; ->vItem43a_temp)+" "+Get_Description(-><>aDesign; -><>aDesignCod; ->vItem43b_temp)
vItem43a_temp:=Substring:C12([Bridge MHD NBIS:1]Item43:75; 1; 1)
vItem43b_temp:=Substring:C12([Bridge MHD NBIS:1]Item43:75; 2; 2)
vtxtStructTypeSIA:=Get_Description(-><>aMaterial; -><>aMatCode; ->vItem43a_temp)+" "+Get_Description(-><>aDesign; -><>aDesignCod; ->vItem43b_temp)
vtxtItem107Insp:=Get_Description(-><>aDeck; -><>aDeckCod; ->[Inspections:27]Item 107:141)
vtxtItem107SIA:=Get_Description(-><>aDeck; -><>aDeckCod; ->[Bridge MHD NBIS:1]Item107:79)
vblnChkItem43:=([Inspections:27]Item 43:140#[Bridge MHD NBIS:1]Item43:75)
vblnChkItem107:=([Inspections:27]Item 107:141#[Bridge MHD NBIS:1]Item107:79)
//Do the check
$blnDoCheck:=(vblnChkItem43 | vblnChkItem107)
$blnDoCheck:=($blnDoCheck & Not:C34([Inspections:27]DoNotShowDialogDependency:196))
If ($blnDoCheck)
	
	C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
	C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
	C_TEXT:C284($Title_txt)
	FORM GET PROPERTIES:C674([Dialogs:21]; "CheckStructureType"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
	$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10; $Title_txt; "ut_CloseCancel")
	//$FormWindow:=Open form window([Dialogs];"CheckStructureType";(Plain no zoom box window ))
	DIALOG:C40([Dialogs:21]; "CheckStructureType")
	CLOSE WINDOW:C154($Win_l)
	If (OK=1)
		If (blnStructureType=1)
			[Inspections:27]Item 43:140:=[Bridge MHD NBIS:1]Item43:75
			PushChange(1; ->[Inspections:27]Item 43:140)
			INSP_Item43Desc
		End if 
		If (blnItem107=1)
			[Inspections:27]Item 107:141:=[Bridge MHD NBIS:1]Item107:79
			PushChange(1; ->[Inspections:27]Item 107:141)
			INSP_Item107Desc
		End if 
	End if 
End if 