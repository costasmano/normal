//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_ControlSelect
// User name (OS): cjmiller
// Date and time: 01/19/06, 10:46:23
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_2007_CJMv2  //04/30/07, 12:00:48`Fix compiler errors
	Mods_2007_CJM_v5303  //r004 `10/23/07, 11:17:52`Add code to control change from chapter 85
	Mods_2007_CJM_v5303  //r004 `10/23/07, 16:31:28 `Add code to allow for overide  consultant
	Mods_2022_05  //Changed code to use Listboxes when available 
End if 
READ ONLY:C145(*)

NewWindow(710; 570; 0; 0; "")
If (False:C215)
	DIALOG:C40([PRJ_ProjectDetails:115]; "Selection.dlg")
End if 
C_BOOLEAN:C305($Complete_b)
$Complete_b:=False:C215
C_BOOLEAN:C305($UseLB_B)
$UseLB_B:=ut_UseListBox("PRJ_Select"+<>SelectionOption_txt)
//Repeat 
//RESUME PROCESS(Current process)
//SHOW PROCESS(Current process)
BRING TO FRONT:C326(Current process:C322)
C_LONGINT:C283($Width_l; $Height_l)

Case of 
	: (<>SelectionOption_txt="Bridge")
		
		SET WINDOW TITLE:C213("Select Bridge")
		PRJ_GetSelectedBridges
		If ($UseLB_B)
			FORM GET PROPERTIES:C674([Bridge MHD NBIS:1]; "PRJ_Selection_LB"; $Width_l; $Height_l)
			ut_ResizeWindow(Frontmost window:C447; $Width_l; 570)
			DIALOG:C40([Bridge MHD NBIS:1]; "PRJ_Selection_LB")
		Else 
			FORM SET OUTPUT:C54([Bridge MHD NBIS:1]; "PRJ_Selection.o")
			FORM SET INPUT:C55([Bridge MHD NBIS:1]; "PRJ_Empty")
			
			FORM GET PROPERTIES:C674([Bridge MHD NBIS:1]; "PRJ_Selection.o"; $Width_l; $Height_l)
			ut_ResizeWindow(Frontmost window:C447; $Width_l; 570)
			
			MODIFY SELECTION:C204([Bridge MHD NBIS:1]; *)
		End if 
	: (<>SelectionOption_txt="FederalAid")
		SET WINDOW TITLE:C213("Select Federal Aid")
		PRJ_GetTableofListsSelection("FederalAid")
		
		If ($UseLB_B)
			FORM GET PROPERTIES:C674([TableOfLists:125]; "PRJ_Selection_LB"; $Width_l; $Height_l)
			ut_ResizeWindow(Frontmost window:C447; $Width_l; 570)
			DIALOG:C40([TableOfLists:125]; "PRJ_Selection_LB")
		Else 
			FORM SET OUTPUT:C54([TableOfLists:125]; "PRJ_Selection.o")
			FORM SET INPUT:C55([TableOfLists:125]; "PRJ_Empty")
			
			FORM GET PROPERTIES:C674([TableOfLists:125]; "PRJ_Selection.o"; $Width_l; $Height_l)
			ut_ResizeWindow(Frontmost window:C447; $Width_l; 570)
			MODIFY SELECTION:C204([TableOfLists:125]; *)
		End if 
		
		
		
		
	: (<>SelectionOption_txt="Program")
		SET WINDOW TITLE:C213("Select Program")
		PRJ_GetTableofListsSelection("Program")
		
		
		If ($UseLB_B)
			FORM GET PROPERTIES:C674([TableOfLists:125]; "PRJ_Selection_LB"; $Width_l; $Height_l)
			ut_ResizeWindow(Frontmost window:C447; $Width_l; 570)
			DIALOG:C40([TableOfLists:125]; "PRJ_Selection_LB")
		Else 
			FORM SET OUTPUT:C54([TableOfLists:125]; "PRJ_Selection.o")
			FORM SET INPUT:C55([TableOfLists:125]; "PRJ_Empty")
			FORM GET PROPERTIES:C674([TableOfLists:125]; "PRJ_Selection.o"; $Width_l; $Height_l)
			ut_ResizeWindow(Frontmost window:C447; $Width_l; 570)
			MODIFY SELECTION:C204([TableOfLists:125]; *)
		End if 
		
	: (<>SelectionOption_txt="ProjectFile") | (<>SelectionOption_txt="FromChapter85")
		SET WINDOW TITLE:C213("Select Project File")
		PRJ_GetSelectedProjectFiles
		
		If ($UseLB_B)
			FORM GET PROPERTIES:C674([PRJ_ProjectFile:117]; "PRJ_FileSelection_LB"; $Width_l; $Height_l)
			ut_ResizeWindow(Frontmost window:C447; $Width_l; 570)
			DIALOG:C40([PRJ_ProjectFile:117]; "PRJ_FileSelection_LB")
		Else 
			FORM GET PROPERTIES:C674([PRJ_ProjectFile:117]; "PRJ_Selection.o"; $Width_l; $Height_l)
			FORM SET OUTPUT:C54([PRJ_ProjectFile:117]; "PRJ_Selection.o")
			FORM SET INPUT:C55([PRJ_ProjectFile:117]; "PRJ_Empty")
			ut_ResizeWindow(Frontmost window:C447; $Width_l; 570)
			MODIFY SELECTION:C204([PRJ_ProjectFile:117]; *)
		End if 
		
		
	: (<>SelectionOption_txt="Bins")  //not used any longer
		READ WRITE:C146([PRJ_ProjectDetailsIncludedBINS:122])
		FORM GET PROPERTIES:C674([PRJ_ProjectDetailsIncludedBINS:122]; "BinSelection.dlg"; $Width_l; $Height_l)
		ut_ResizeWindow(Frontmost window:C447; $Width_l; $Height_l)
		SET WINDOW TITLE:C213("Select Included Bins")
		QUERY:C277([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PRJ_ProjectID_l:1=Num:C11(<>PRJ_SelectedData_txt))
		<>PRJ_SelectedData_txt:=""
		PRJ_SetUpBinArrays
		DIALOG:C40([PRJ_ProjectDetailsIncludedBINS:122]; "BinSelection.dlg")
		READ ONLY:C145([PRJ_ProjectDetailsIncludedBINS:122])
	: (<>SelectionOption_txt="DesignContract")
		SET WINDOW TITLE:C213("Select Design Contract")
		PRJ_GetSelectedDesignContracts
		If ($UseLB_B)
			FORM GET PROPERTIES:C674([PRJ_DesignContracts:123]; "PRJ_Selection_lb"; $Width_l; $Height_l)
			ut_ResizeWindow(Frontmost window:C447; $Width_l; 570)
			DIALOG:C40([PRJ_DesignContracts:123]; "PRJ_Selection_lb")
		Else 
			FORM GET PROPERTIES:C674([PRJ_DesignContracts:123]; "PRJ_Selection.o"; $Width_l; $Height_l)
			ut_ResizeWindow(Frontmost window:C447; $Width_l; 570)
			FORM SET OUTPUT:C54([PRJ_DesignContracts:123]; "PRJ_Selection.o")
			FORM SET INPUT:C55([PRJ_DesignContracts:123]; "PRJ_Empty")
			MODIFY SELECTION:C204([PRJ_DesignContracts:123]; *)
		End if 
		
		
		
	: (<>SelectionOption_txt="Consultant") | (<>SelectionOption_txt="OverideConsultant")
		QUERY:C277([Conslt_Name:127]; [Conslt_Name:127]ConsultantName_s:2=<>PRJ_SelectedData_txt+"@")
		
		If ($UseLB_B)
			FORM GET PROPERTIES:C674([Conslt_Name:127]; "PRJ_Selection_LB"; $Width_l; $Height_l)
			ut_ResizeWindow(Frontmost window:C447; $Width_l; 570)
			DIALOG:C40([Conslt_Name:127]; "PRJ_Selection_LB")
		Else 
			FORM GET PROPERTIES:C674([Conslt_Name:127]; "PRJ_Selection.o"; $Width_l; $Height_l)
			ut_ResizeWindow(Frontmost window:C447; $Width_l; 700)
			FORM SET OUTPUT:C54([Conslt_Name:127]; "PRJ_Selection.o")
			FORM SET INPUT:C55([Conslt_Name:127]; "PRJ_Empty")
			MODIFY SELECTION:C204([Conslt_Name:127]; *)
			
		End if 
		
		
		
End case 
<>ProjectSelectionProcess_l:=0
//Until ($Complete_b) | (<>fQuit)
//End PRJ_ControlSelect