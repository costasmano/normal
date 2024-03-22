//%attributes = {"invisible":true}
//Method: INSP_ViewApprvedInspection
//Description
//Add new Buttons to select and view approved inspection PDFs that are on the share
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 03/11/21, 13:22:02
	// ----------------------------------------------------
	//Created : 
	Mods_2021_03
End if 
//
If (Num:C11(v_1_230_atxt)#0)
	C_TEXT:C284($SelectedDocument_txt)
	If (Test path name:C476(v_1_230_atxt{Num:C11(v_1_230_atxt)})=Is a document:K24:1)
		$SelectedDocument_txt:=Convert path system to POSIX:C1106(v_1_230_atxt{Num:C11(v_1_230_atxt)})
		OPEN URL:C673("file:////"+$SelectedDocument_txt)
	Else 
		CONFIRM:C162("MA DOT shared volume not mounted"; "Try to mount"; "Skip")
		
		If (OK=1)
			INSP_LoadForApprInspections
			If (Test path name:C476(v_1_230_atxt{Num:C11(v_1_230_atxt)})=Is a document:K24:1)
				$SelectedDocument_txt:=Convert path system to POSIX:C1106(v_1_230_atxt{Num:C11(v_1_230_atxt)})
				OPEN URL:C673("file:////"+$SelectedDocument_txt)
			Else 
				ALERT:C41("Could not mount MA DOT share")
				ARRAY TEXT:C222(v_1_230_atxt; 0)
				OBJECT SET VISIBLE:C603(*; "ViewApprovedInspectionButton"; False:C215)
				OBJECT SET VISIBLE:C603(*; "ApprovedInspectionButton"; False:C215)
				
			End if 
		Else 
			ARRAY TEXT:C222(v_1_230_atxt; 0)
			OBJECT SET VISIBLE:C603(*; "ViewApprovedInspectionButton"; False:C215)
			OBJECT SET VISIBLE:C603(*; "ApprovedInspectionButton"; False:C215)
			
		End if 
	End if 
End if 
//End INSP_ViewApprvedInspection