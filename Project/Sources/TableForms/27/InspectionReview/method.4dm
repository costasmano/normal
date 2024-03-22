//Method: Form Method: [Inspections];"InspectionReview"
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
	//----------------------------------------------------
	//User name (OS): Charles Miller
	//Date and time: 06/28/13, 14:35:50
	//----------------------------------------------------
	
	Mods_2005_CM05
	Mods_2005_CM12
	// Modified by: costasmanousakis-(Designer)-(12/5/2005 11:41:38)
	Mods_2005_CM19
	// Modified by: costasmanousakis-(Designer)-(6/2/2006 14:17:07)
	Mods_2006_CM04
	// Modified by: costasmanousakis-(Designer)-(11/1/2007 14:36:53)
	Mods_2007_CM12_5302
	// Modified by: costasmanousakis-(Designer)-(6/2/10 09:54:42)
	Mods_2010_06
	//  `Use new method INSP_SortReviewList at the on load event; don't do anything at the On Header.
	//  `Sorting will be done at the buttons.
	//  `Also added grey bar picture on the header and footer of the form
	// Modified by: costasmanousakis-(Designer)-(8/27/10 14:08:02)
	Mods_2010_08
	//  `Removed the disbaling of the Print button
	Mods_2013_03  //r001 ` Add code to set headings for MBTA engineers
	//Modified by: Charles Miller (3/7/13 17:02:22)
	
	// Modified by: manousakisc (5/31/2013)
	Mods_2013_05
	//  `Added Redraw Window at end of on Close Detail
	Mods_2013_06  //r001 ` Change titles from
	//QC'D, QA'D to Revwd Aprvd
	//by removed MBTA text objects and renaming notMBTA object names back to Text
	//Modified by: Charles Miller (6/28/13 14:32:32)
	// Modified by: Costas Manousakis-(Designer)-(10/24/13 11:19:02)
	Mods_2013_10
	//  `use  method  INSP_IsInspRoutine_b to check if inspection is a routine one
	// Modified by: Costas Manousakis-(Designer)-(10/31/13 14:36:47)
	Mods_2013_10
	//  `Added sorting by complete, reviewed, approved columns ;
	//  `Adjusted size of forms and moved objects to fit the new sort buttons.
	// Modified by: Costas Manousakis-(Designer)-(8/11/14 12:40:06)
	Mods_2014_08
	//  `Added inspection type TOV to the INSP_IsInspRoutine_b check
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		C_TEXT:C284($CurrUser_txt)
		$CurrUser_txt:=<>CurrentUser_Name
		
		//initialize sort buttons.    
		C_LONGINT:C283(SortBdept; SortBIN; SorttmLdr; SortInspType; SortInspDate; SortInspCompl; SortInspApprove; SortInspReview)  //Command Replaced was o_C_INTEGER
		C_BOOLEAN:C305(vbSortedHeader)
		C_TEXT:C284(vInspTitle)  // Command Replaced was o_C_STRING length was 255
		C_TEXT:C284(vTmLeader)  // Command Replaced was o_C_STRING length was 44
		C_LONGINT:C283(vPicButtonReview; vPicButtonAppr)  //Command Replaced was o_C_INTEGER
		vbSortedHeader:=False:C215
		C_POINTER:C301(MultiLevelTbl)
		MultiLevelTbl:=->[Inspections:27]
		ARRAY POINTER:C280(aPtrSortField; 0)
		ARRAY POINTER:C280(aPtrSortOrder; 0)
		SortInspDate:=0
		SortBIN:=0
		SortBdept:=1
		SorttmLdr:=0
		SortInspType:=0
		SortInspCompl:=0
		SortInspApprove:=0
		SortInspReview:=0
		
		//ORDER BY([Inspections];[Bridge MHD NBIS]BDEPT;>)
		
		If (vApproveLvl=0)
			OBJECT SET ENABLED:C1123(*; "ApproveButton"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		End if 
		
		If (Type:C295(InspRespDescSel_atxt)#String array:K8:15)  // not a string array
			If (Size of array:C274(InspRespDescSel_atxt)>0)
			Else 
				OBJECT SET ENABLED:C1123(*; "InspResp Select"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
				OBJECT SET VISIBLE:C603(*; "InspResp Select@"; False:C215)
			End if 
			
		End if 
		INSP_SortReviewList
		
	: ((Form event code:C388=On Header:K2:17) & Not:C34(vbSortedHeader))
		If (False:C215)
			INSP_SortReviewList
		End if 
		
	: (Form event code:C388=On Display Detail:K2:22)
		If ([Inspections:27]InitialInsp:9)
			vInspTitle:="Initial "+[Inspection Type:31]Description:2
		Else 
			vInspTitle:=[Inspection Type:31]Description:2
		End if 
		If (INSP_IsInspRoutine_b | ([Inspections:27]Insp Type:6="TOV"))
			C_BOOLEAN:C305($vbCombined)
			If (Substring:C12(<>Version; 1; (Position:C15(" "; <>Version)-1))>="5.0")
				$vbCombined:=[Inspections:27]InspRtnSpcMemFlag:209
			Else 
				$vbCombined:=(G_Insp_CountSpMs>0)
			End if 
			If ($vbCombined)
				vInspTitle:=vInspTitle+" & Spec.Mem."
			End if 
		End if 
		vTmLeader:=Get_Description(->aPeople; ->aPeople_ID; ->[Inspections:27]TeamLeader:4)
		vPicButtonReview:=[Inspections:27]InspReviewed:12
		vPicButtonAppr:=[Inspections:27]InspApproved:167
		
	: (Form event code:C388=On Open Detail:K2:23)
		READ ONLY:C145([Bridge MHD NBIS:1])
		C_LONGINT:C283(vlInspRevWWid; vlInspRevWHt)
		C_LONGINT:C283($vlLeft; $vlTop; $vlRight; $vlBot)
		GET WINDOW RECT:C443($vlLeft; $vlTop; $vlRight; $vlBot)
		vlInspRevWWid:=$vlRight-$vlLeft
		vlInspRevWHt:=$vlBot-$vlTop
		$vlRight:=$vlLeft+740
		$vlBot:=$vlTop+540
		If ($vlRight>(Screen width:C187-5))
			$vlLeft:=Screen width:C187-740-5
			If ($vlLeft<1)
				$vlLeft:=1
			End if 
			$vlRight:=Screen width:C187-5
		End if 
		If ($vlBot>(Screen height:C188-5))
			$vlTop:=Screen height:C188-540-5
			If ($vlTop<15)
				$vlTop:=15
			End if 
			$vlBot:=Screen height:C188-5
		End if 
		
		C_LONGINT:C283(INSPRV_CurrID_L; INSPRV_NumInSel_L)
		INSPRV_CurrID_L:=Selected record number:C246([Inspections:27])
		INSPRV_NumInSel_L:=Records in selection:C76([Inspections:27])
		SET WINDOW RECT:C444($vlLeft; $vlTop; $vlRight; $vlBot)
		COPY NAMED SELECTION:C331([Inspections:27]; "TempInspectsOpen")
		
	: (Form event code:C388=On Close Detail:K2:24)
		If (Records in selection:C76([Inspections:27])=0)
			USE NAMED SELECTION:C332("TempInspectsOpen")
		End if 
		CLEAR NAMED SELECTION:C333("TempInspectsOpen")
		
		If (Records in selection:C76([Inspections:27])#INSPRV_NumInSel_L)
			COPY NAMED SELECTION:C331([Inspections:27]; "UserRegionA")
			RegionTitle
			
			If (INSPRV_CurrID_L<=Records in selection:C76([Inspections:27]))
			Else 
				INSPRV_CurrID_L:=Records in selection:C76([Inspections:27])
			End if 
			GOTO SELECTED RECORD:C245([Inspections:27]; INSPRV_CurrID_L)
			CLEAR SET:C117("UserSet")
			CREATE EMPTY SET:C140([Inspections:27]; "UserSet")
			ADD TO SET:C119([Inspections:27]; "UserSet")
			HIGHLIGHT RECORDS:C656
			
		End if 
		C_LONGINT:C283($vlLeft; $vlTop; $vlRight; $vlBot)
		GET WINDOW RECT:C443($vlLeft; $vlTop; $vlRight; $vlBot)
		SET WINDOW RECT:C444($vlLeft; $vlTop; $vlLeft+vlInspRevWWid; $vlTop+vlInspRevWHt)
		
		READ WRITE:C146([Bridge MHD NBIS:1])
		REDRAW WINDOW:C456
		
	: (Form event code:C388=On Outside Call:K2:11)
		If (<>fQuit)
			CANCEL:C270
		End if 
		
	: (Form event code:C388=On Activate:K2:9)
		UpdatFilesPalet
	: (Form event code:C388=On Deactivate:K2:10)
		UpdatFilesPalet
		//REDRAW(◊asWindows)
		
End case 
//End Form Method: [Inspections]InspectionReview

