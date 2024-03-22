If (False:C215)
	//Object Method: [Bridge MHD NBIS].Bridge Input.bDuplicate 
	//[Bridge MHD NBIS];"CombinedInspections".bDuplicate
	//bDuplicate
	//Duplicate the current NBIS Inspection with its Elements and Images
	//and the current BMS inspection with it's elements
	//Created April-2004
	
	Mods_2005_CM06
	Mods_2005_CM12
	Mods_2005_CM15
	// Modified by: costasmanousakis-(Designer)-(1/4/2006 11:54:54)
	Mods_2006_CM01
	// Modified by: costasmanousakis-(Designer)-(12/12/07 16:40:23)
	Mods_2007_CM_5401
	// Modified by: costasmanousakis-(Designer)-(4/16/08 08:43:07)
	Mods_2008_CM_5403  // add call to BRG_RWAccess
	// Modified by: costasmanousakis-(Designer)-(8/20/08 08:16:54)
	Mods_2008_CM_5404
	//  `Use method INSP_UpdateInspList
	Mods_2009_03  //CJM  r001   `03/06/09, 12:20:40`Upgrade from open form window to open window
	// Modified by: costasmanousakis-(Designer)-(4/2/09 16:49:59)
	Mods_2009_04
	//  `Adjusted code to assume that the first record in the list is selected, 
	//  `unless there are no records.
	// Modified by: costasmanousakis-(Designer)-(4/10/09 11:15:11)
	Mods_2009_04
	//  `Adjusted code to use Selected record number before and after to keep the record highlighted.
	// Modified by: costasmanousakis-(Designer)-(4/20/10 10:49:46)
	Mods_2010_04
	//  `Use new method INSP_Approved_b to also account for Freezethaw inspections
	// Modified by: costasmanousakis-(Designer)-(11/1/11 15:34:54)
	Mods_2011_11
	//  `USe global var ◊CurrentUser_Name
	// Modified by: Costas Manousakis-(Designer)-(6/20/12 14:47:50)
	Mods_2012_06
	//  `Befoire getting the cell position of the listbox, check if there is anything in the hilite set
	// Modified by: Costas Manousakis-(Designer)-(1/2/13 11:47:44)
	Mods_2013_01
	//  `Added call to ut_Read_Write_Tables ("WRITE";.. to set tables to RW before copying
	// Modified by: Costas Manousakis-(Designer)-(5/22/13 16:36:57)
	Mods_2013_05
	//  `replaced ut_Read_Write_Tables with  INSP_Read_Write_Tables
	// Modified by: Costas Manousakis-(Designer)-(5/30/13 16:21:21)
	Mods_2013_05  //``` *** BUG FIX *****
	//  `Set name of listbox changed to LBSetBrgInsp
	// Modified by: Costas Manousakis-(Designer)-(6/12/19 12:58:40)
	Mods_2019_06
	//  `close all tables except the Bridge table when done
	Mods_NewDownloadCode  //Make changes to address new upload and download code
	//These methods moved from single user to DEV Server 
	//Add call to Synch_ReturnForward to reset new style vsForward
	//Modified by: Chuck Miller (1/11/22 10:57:26)
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		If ((User in group:C338(<>CurrentUser_Name; "MHDInspectionRWAccess") & BRG_RWAccess) | (<>CurrentUser_Name="Designer"))
			OBJECT SET VISIBLE:C603(Self:C308->; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(Self:C308->; False:C215)
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		C_LONGINT:C283(vbCombined; vbSpecial)  //Command Replaced was o_C_INTEGER
		C_TEXT:C284($msg1; $msg2; vTextMsg)
		C_TEXT:C284($FieldName)  // Command Replaced was o_C_STRING length was 40
		C_TEXT:C284($FieldName)  // Command Replaced was o_C_STRING length was 40
		C_LONGINT:C283($rec_L)
		C_LONGINT:C283($rec_L; $column_l)
		$rec_L:=Records in set:C195("LBSetBrgInsp")
		If ($rec_L>0)
			LISTBOX GET CELL POSITION:C971(*; "Inspections"; $column_l; $rec_L)
		End if 
		If ($rec_L<1) | ($rec_L>Records in selection:C76([Combined Inspections:90]))
			ALERT:C41("You must Select an Inspection first!")
		Else 
			GOTO SELECTED RECORD:C245([Combined Inspections:90]; $rec_L)
			LOAD RECORD:C52([Combined Inspections:90])
			RELATE ONE:C42([Combined Inspections:90]NBISInspID:2)
			LOAD RECORD:C52([Inspections:27])
			//Do not copy if inspection does not have final approval
			C_BOOLEAN:C305($InspApproved_b)
			
			$InspApproved_b:=INSP_Approved_b
			
			Case of 
				: (Not:C34($InspApproved_b) & (<>CurrentUser_Name#"Designer"))
					ALERT:C41("Cannot duplicate Inspection that has not been approved yet!")
				: ([Inspections:27]Insp Type:6="PON")
					$msg2:="Cannot duplicate Pontis Inspections!"+<>sCR
					$msg2:=$msg2+"Pontis Elements from past inspections can be copied "
					$msg2:=$msg2+"at the Pontis tab in the Inspection input form."
					ALERT:C41($msg2)
				Else 
					C_LONGINT:C283($v_NumPhotos; $v_NumSketches; $v_NumCharts; DupInsp_CopySpecMem_L; DupInsp_CopySketches_L; DupInsp_CopyPhotos_L; DupInsp_CopyCharts_L)
					C_BOOLEAN:C305(DupInsp_CopySpecMem_B; DupInsp_CopySketches_B; DupInsp_CopyPhotos_B; DupInsp_CopyCharts_B)
					QUERY:C277([Standard Photos:36]; [Standard Photos:36]InspID:1=[Inspections:27]InspID:2)
					SET QUERY DESTINATION:C396(Into variable:K19:4; $v_NumPhotos)
					QUERY SELECTION:C341([Standard Photos:36]; [Standard Photos:36]PictType:5=BMS Photo)
					SET QUERY DESTINATION:C396(Into variable:K19:4; $v_NumSketches)
					QUERY SELECTION:C341([Standard Photos:36]; [Standard Photos:36]PictType:5=BMS Sketch)
					SET QUERY DESTINATION:C396(Into variable:K19:4; $v_NumCharts)
					QUERY SELECTION:C341([Standard Photos:36]; [Standard Photos:36]PictType:5=BMS Chart)
					SET QUERY DESTINATION:C396(Into current selection:K19:1)
					
					DupInsp_CopySketches_B:=($v_NumSketches>0)
					DupInsp_CopyPhotos_B:=($v_NumPhotos>0)
					DupInsp_CopyCharts_B:=($v_NumCharts>0)
					
					//Choice to duplicate either special inspection or combined inspection
					$msg1:="You have selected a Combined Inspection."+<>sCR
					$msg1:=$msg1+"Please select one of two buttons below to duplicate either"+<>sCR
					$msg1:=$msg1+"a Special Inspection or a Combined Inspection."
					
					//Collect info for the tables Inspections, ElementsSafety and Standard Photos
					DupInsp_CopySpecMem_B:=False:C215
					If (([Combined Inspections:90]InspType:5="RT@") | ([Combined Inspections:90]InspType:5="CUL"))
						C_BOOLEAN:C305($vbCombined)
						If (Substring:C12(<>Version; 1; (Position:C15(" "; <>Version)-1))>="5.0")
							DupInsp_CopySpecMem_B:=[Inspections:27]InspRtnSpcMemFlag:209
						Else 
							DupInsp_CopySpecMem_B:=(G_Insp_CountSpMs>0)
						End if 
					End if 
					$msg2:="Do you wish to copy this "+[Inspection Type:31]Description:2
					If (DupInsp_CopySpecMem_B)
						$msg2:=$msg2+" & Special Member "
					End if 
					$msg2:=$msg2+" Inspection "
					$msg2:=$msg2+" dated "+String:C10([Combined Inspections:90]InspDate:4)+" and all its elements?"
					vTextMsg:=$msg2
					
					C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
					C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
					C_TEXT:C284($Title_txt)
					FORM GET PROPERTIES:C674([Dialogs:21]; "DuplicateInsp"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
					$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10; $Title_txt; "ut_CloseCancel")
					
					//$Win_l:=Open form window([Dialogs];"DuplicateInsp")
					
					DIALOG:C40([Dialogs:21]; "DuplicateInsp")
					CLOSE WINDOW:C154
					If (OK=1)
						INSP_Read_Write_Tables("WRITE")
						vsForward:=Synch_ReturnForward([Bridge MHD NBIS:1]Item2:60; [Bridge MHD NBIS:1]InspResp:173; [Inspections:27]Insp Type:6; 0)
						Duplicate_Inspection((DupInsp_CopySpecMem_L=1))
					End if 
					
					G_CloseAllTables(->[Bridge MHD NBIS:1])  //close all tables except the main one.
					INSP_UpdateInspList
			End case   //If Approved
		End if 
		
End case 