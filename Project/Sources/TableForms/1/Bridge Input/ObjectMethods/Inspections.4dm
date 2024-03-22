//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 02/21/12, 15:00:25
//----------------------------------------------------
//Method: Object Method: [Bridge MHD NBIS];"Bridge Input".Inspections
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_02  //r001
	//Modified by: Charles Miller (2/21/12 15:00:28)
	// Modified by: Costas Manousakis-(Designer)-(3/19/21 17:30:09)
	Mods_2021_03
	//  `Check if there are any records hilighted (set LBSetBrgInsp)
	
End if 

Case of 
	: (Form event code:C388=On Display Detail:K2:22)
		SIA_OnDisplayDetail
	: (Form event code:C388=On Double Clicked:K2:5)
		SIA_ControlDoubleClick
	: (Form event code:C388=On Clicked:K2:4)
		C_LONGINT:C283($column_l; $row_l)
		OBJECT SET VISIBLE:C603(*; "MoveInspectionReport@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "ViewApprovedInspectionButton"; False:C215)
		
		LISTBOX GET CELL POSITION:C971(*; "Inspections"; $column_l; $row_l)
		READ ONLY:C145([Combined Inspections:90])
		READ ONLY:C145([Inspections:27])
		READ ONLY:C145([Inspection Type:31])
		If ($row_l>=1) & ($row_l<=Records in selection:C76([Combined Inspections:90]))
			
			If (Records in set:C195("LBSetBrgInsp")=1)
				
				GOTO SELECTED RECORD:C245([Combined Inspections:90]; $Row_L)
				
				QUERY:C277([Inspections:27]; [Inspections:27]InspID:2=[Combined Inspections:90]NBISInspID:2)
				QUERY:C277([Inspection Type:31]; [Inspection Type:31]Code:1=[Inspections:27]Insp Type:6)
				C_TEXT:C284($PDFInspectionName_txt)
				$PDFInspectionName_txt:=[Bridge MHD NBIS:1]BDEPT:1+"-"+[Bridge MHD NBIS:1]BIN:3+"-"+\
					String:C10(Year of:C25([Inspections:27]Insp Date:78); "0000")+"-"+\
					String:C10(Month of:C24([Inspections:27]Insp Date:78); "00")+"-"+\
					String:C10(Day of:C23([Inspections:27]Insp Date:78); "00")+"-"+\
					[Inspection Type:31]Description:2+".PDF"
				$PDFInspectionName_txt:=Replace string:C233($PDFInspectionName_txt; "/"; "_")
				$PDFInspectionName_txt:=Replace string:C233($PDFInspectionName_txt; ":"; "_")
				v_1_230_atxt:=Find in array:C230(v_1_230_atxt; "@"+$PDFInspectionName_txt)
				OBJECT SET VISIBLE:C603(*; "ViewApprovedInspectionButton"; (v_1_230_atxt>0))
			Else 
				OBJECT SET VISIBLE:C603(*; "ViewApprovedInspectionButton"; False:C215)
				
			End if 
			
		End if 
End case 

//End Object Method: [Bridge MHD NBIS].Bridge Design.BridgeDesign