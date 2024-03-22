//%attributes = {"invisible":true}
//Method: NTI_CheckDependencies
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 05/02/18, 12:10:48
	// ----------------------------------------------------
	//Created : 
	Mods_2018_05
End if 

READ ONLY:C145([NTI_TunnelRatings:189])
QUERY:C277([NTI_TunnelRatings:189]; [NTI_TunnelRatings:189]NTI_i1_s:2=[NTI_TunnelInfo:181]NTI_i1_s:6)
If (Records in selection:C76([NTI_TunnelRatings:189])>0)
	ORDER BY:C49([NTI_TunnelRatings:189]; [NTI_TunnelRatings:189]RatingReport_d:3; <)
	Case of 
		: ([TIN_Inspections:184]RatingReport_d:31#!00-00-00!)
		: ([TIN_Inspections:184]RatingReportDateofInsp_d:32#!00-00-00!)
		: ([TIN_Inspections:184]RatingReportInvertGirder_s:35#"")
		: ([TIN_Inspections:184]RatingReportInvertSlab_s:34#"")
		: ([TIN_Inspections:184]RatingReportRoofGirder_s:33#"")
		Else 
			C_LONGINT:C283($Width_l; $Height_L; $Pages_L; $Win_l)
			C_TEXT:C284($Title_txt)
			C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
			
			FORM GET PROPERTIES:C674([NTI_TunnelRatings:189]; "TunnelRating_LB"; $Width_l; $Height_L)
			$Title_txt:="Select Rating report for Inspection"
			$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain no zoom box window:K34:1; $Title_txt; "ut_CloseCancel")
			//$FormWindow:=Open form window([Dialogs];"DependencyCheck";(Plain no zoom box window ))
			DIALOG:C40([NTI_TunnelRatings:189]; "TunnelRating_LB")
			CLOSE WINDOW:C154
			If (OK=1)
				
				[TIN_Inspections:184]RatingReport_d:31:=[NTI_TunnelRatings:189]RatingReport_d:3
				[TIN_Inspections:184]RatingReportDateofInsp_d:32:=[NTI_TunnelRatings:189]Inspection_d:12
				[TIN_Inspections:184]RatingReportInvertGirder_s:35:=[NTI_TunnelRatings:189]RatingReportInvertGirder_s:6
				[TIN_Inspections:184]RatingReportInvertSlab_s:34:=[NTI_TunnelRatings:189]RatingReportInvertSlab_s:5
				[TIN_Inspections:184]RatingReportRoofGirder_s:33:=[NTI_TunnelRatings:189]RatingReportRoofGirder_s:4
				[TIN_Inspections:184]RatingReportYN_B:30:=True:C214
			End if 
			
	End case 
End if 
//End NTI_CheckDependencies