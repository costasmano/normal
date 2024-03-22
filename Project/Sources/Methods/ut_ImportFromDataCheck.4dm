//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_ImportFromDataCheck
// User name (OS): charlesmiller
// Date and time: 03/13/09, 14:28:21
// ----------------------------------------------------
// Description
//This method controls import of data from data check or any other method. The file layout must be table number, then record,
//as the actual import uses receive variable and then recieve record 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2009_03  //CJM  r001   `03/13/09, 14:28:22
End if 
If (User in group:C338(Current user:C182; "Design Access Group"))
	C_LONGINT:C283(<>UserRunTimeProcessID_l)
	<>UserRunTimeProcessID_l:=Current process:C322
	
	
	C_LONGINT:C283(ImportCount_li)
	ImportCount_li:=0
	C_BOOLEAN:C305(ImportComplete_bl)
	ImportComplete_bl:=False:C215
	Repeat 
		
		C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
		C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
		C_TEXT:C284($Title_txt)
		FORM GET PROPERTIES:C674([Dialogs:21]; "Import_All"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
		$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10; $Title_txt; "ut_CloseCancel")
		DIALOG:C40([Dialogs:21]; "Import_All")
		CLOSE WINDOW:C154
		If (ImportComplete_bl=False:C215)
			ImportCount_li:=ImportCount_li+1
			C_TEXT:C284($Processname_txt)
			$Processname_txt:="Import Process # "+String:C10(ImportCount_li)
			ImportProcessID:=New process:C317("ut_ProcessDCImports"; 0; $Processname_txt; ImportCount_li)
			BRING TO FRONT:C326(ImportProcessID)
		End if 
	Until (ImportComplete_bl=True:C214)
	
	//End ut_ImportFromDataCheck
End if 
