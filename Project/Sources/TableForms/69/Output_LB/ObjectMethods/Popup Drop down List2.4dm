// ----------------------------------------------------
// Object Method: ReportSelection_atxt
// User name (OS): charlesmiller
// Date and time: 12/17/09, 15:15:38
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2009_12  // r001 CJ Miller`12/17/09, 15:15:40        `Make changes to new status report
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		ARRAY TEXT:C222(ReportSelection_atxt; 0)
		ARRAY TEXT:C222(ReportSelection_atxt; 3)
		ReportSelection_atxt{0}:="Select report"
		ReportSelection_atxt{1}:=""
		ReportSelection_atxt{2}:="Status Report"
		ReportSelection_atxt{3}:="Quarterly Status Report"
		ReportSelection_atxt:=0
		If (User in group:C338(Current user:C182; "Design Access Group"))
			OBJECT SET VISIBLE:C603(ReportSelection_atxt; True:C214)
		End if 
		
		
	: (Form event code:C388=On Clicked:K2:4)
		Case of 
			: (ReportSelection_atxt=2)
				SR_PrintSelection
			: (ReportSelection_atxt=3)
				CREATE SET:C116([Status Report:69]; "StartingSet")
				C_LONGINT:C283($LegacyCount_l; $DOTCount_l; $RecordCount_l)
				$RecordCount_l:=Records in selection:C76([Status Report:69])
				
				SET QUERY DESTINATION:C396(Into variable:K19:4; $LegacyCount_l)
				QUERY SELECTION:C341([Status Report:69]; [Status Report:69]Comments:135="Legacy Owner Report Generated By Server method@")
				SET QUERY DESTINATION:C396(Into variable:K19:4; $DOTCount_l)
				QUERY SELECTION:C341([Status Report:69]; [Status Report:69]Comments:135="Report Generated By Server method@")
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				
				If ($LegacyCount_l+$DOTCount_l<$RecordCount_l)
					
					CONFIRM:C162(String:C10($RecordCount_l-$LegacyCount_l-$DOTCount_l)+" out of "+String:C10(Records in selection:C76([Status Report:69]))+" will not be printed"; "Print"; "Cancel")
					If (OK=1)
						
						QUERY SELECTION:C341([Status Report:69]; [Status Report:69]Comments:135="Legacy Owner Report Generated By Server method@"; *)
						QUERY SELECTION:C341([Status Report:69];  | ; [Status Report:69]Comments:135="Report Generated By Server method@")
						
						SR_ControlQuarterlyPrint("OUT")
					End if 
				Else 
					SR_ControlQuarterlyPrint("OUT")
				End if 
				USE SET:C118("StartingSet")
				CLEAR SET:C117("StartingSet")
		End case 
		ReportSelection_atxt:=0
End case 
//End Object Method: ReportSelection_atxt