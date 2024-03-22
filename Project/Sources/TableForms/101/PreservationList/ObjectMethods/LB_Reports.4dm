// ----------------------------------------------------
//User name (OS): Costas Manousakis
//User (4D) : Designer
//Date and time: 01/17/12, 08:33:34
// ----------------------------------------------------
//Method: Object Method: SelectListBox.LB_Reports
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	//Created : 
	Mods_2012_01
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		// MUST NAME THE BUTTON VARIABLE TO THE SAME AS LB_Reports
		
		LB_Reports:=0
		
		QUERY:C277([zSpecialReports:106]; [zSpecialReports:106]Purpose:1=[LB_QueryTable:147]QueryName_s:1)
		ARRAY TEXT:C222(ButtonPopupButtonlabels_atxt; 0)
		ARRAY TEXT:C222(ButtonPopupCommands_atxt; 0)
		ButtonPopupButtonlabels_atxt:=0
		If (Records in selection:C76([zSpecialReports:106])>0)
			ORDER BY:C49([zSpecialReports:106]; [zSpecialReports:106]ReportName:2; >)
			SELECTION TO ARRAY:C260([zSpecialReports:106]ReportName:2; ButtonPopupButtonlabels_atxt; [zSpecialReports:106]MethodName:3; ButtonPopupCommands_atxt)
			ButtonpopupText:=ButtonPopupButtonlabels_atxt{1}
			C_LONGINT:C283($loop_L)
			For ($loop_L; 2; Size of array:C274(ButtonPopupButtonlabels_atxt))
				ButtonpopupText:=ButtonpopupText+";"+ButtonPopupButtonlabels_atxt{$loop_L}
			End for 
		Else 
			OBJECT SET VISIBLE:C603(LB_Reports; False:C215)
		End if 
		
	: ((Form event code:C388=On Alternative Click:K2:36) | (Form event code:C388=On Long Click:K2:37) | ((Form event code:C388=On Clicked:K2:4) & (LB_Reports=0)))
		LB_Reports:=Pop up menu:C542(ButtonpopupText)
		
		If ((LB_Reports>0) & (LB_Reports<=Size of array:C274(ButtonPopupCommands_atxt)))
			OBJECT SET TITLE:C194(Self:C308->; ButtonPopupButtonlabels_atxt{LB_Reports})
			
			Case of 
				: (ButtonPopupCommands_atxt{LB_Reports}="QRT_@")
					QUERY:C277([Templates:86]; [Templates:86]TemplateName:2=ButtonPopupCommands_atxt{LB_Reports})
					If (Records in selection:C76([Templates:86])=1)
						SHORT_MESSAGE("Executing Quick Report....")
						C_LONGINT:C283($QuickRptArea_L)
						$QuickRptArea_L:=QR New offscreen area:C735
						QR BLOB TO REPORT:C771($QuickRptArea_L; [Templates:86]Template_:3)
						QR SET DOCUMENT PROPERTY:C772($QuickRptArea_L; qr printing dialog:K14907:1; 1)
						If (False:C215)
							If (vRptDestOption_i>0)
								QR SET DESTINATION:C745($QuickRptArea_L; vRptDestOption_i)
								RptDestination:=vRptDestOption_i
							End if 
							Case of 
								: (RptDestination=1)
								: (RptDestination=2)
									C_LONGINT:C283($Cols_L; $ColNo_L; $hide_L; $Size_L; $RepeatV_L)
									C_TEXT:C284($Title_txt; $Obj_txt; $DispFormat_txt)
									$Cols_L:=QR Count columns:C764($QuickRptArea_L)
									For ($ColNo_L; 1; $Cols_L)
										QR GET INFO COLUMN:C766($QuickRptArea_L; $ColNo_L; $Title_txt; $Obj_txt; $hide_L; $Size_L; $RepeatV_L; $DispFormat_txt)
										$Title_txt:=Replace string:C233($Title_txt; Char:C90(13); " ")
										$DispFormat_txt:=Replace string:C233($DispFormat_txt; Char:C90(13); " ")
										QR SET INFO COLUMN:C765($QuickRptArea_L; $ColNo_L; $Title_txt; $Obj_txt; $hide_L; $Size_L; $RepeatV_L; $DispFormat_txt)
									End for 
									
							End case 
						End if 
						QR EXECUTE COMMAND:C791($QuickRptArea_L; qr cmd page setup:K14900:24)
						QR RUN:C746($QuickRptArea_L)
						CLOSE WINDOW:C154
						QR DELETE OFFSCREEN AREA:C754($QuickRptArea_L)
					Else 
						ALERT:C41("Error locating Quick report "+<>sQu+ButtonPopupButtonlabels_atxt{LB_Reports}+<>sQu+" : <"+ButtonPopupCommands_atxt{LB_Reports}+">")
					End if 
					
				Else 
					EXECUTE FORMULA:C63(ButtonPopupCommands_atxt{LB_Reports})
					
			End case 
			
			ButtonPopupButtonlabels_atxt:=LB_Reports
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		LB_Reports:=ButtonPopupButtonlabels_atxt
		If ((LB_Reports>0) & (LB_Reports<=Size of array:C274(ButtonPopupCommands_atxt)))
			Case of 
				: (ButtonPopupCommands_atxt{LB_Reports}="QRT_@")
				Else 
					EXECUTE FORMULA:C63(ButtonPopupCommands_atxt{LB_Reports})
					
			End case 
		End if 
End case 

//End Object Method: SelectListBox.LB_Reports