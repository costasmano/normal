If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/04/06, 11:56:27
	// ----------------------------------------------------
	// Method: Form Method: DuplicateInsp
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM01
	Mods_2018_03  // Update code to use new commands
	//Modified by: Chuck Miller (3/29/18 15:08:10)
	
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		OBJECT SET VISIBLE:C603(*; "CopySpMemOnly@"; DupInsp_CopySpecMem_B)
		DupInsp_CopySketches_L:=0
		DupInsp_CopyPhotos_L:=0
		DupInsp_CopyCharts_L:=0
		DupInsp_CopyAsIS_L:=0
		OBJECT SET ENABLED:C1123(*; "CopySketches@"; DupInsp_CopySketches_B)
		
		If (DupInsp_CopySketches_B)
			DupInsp_CopySketches_L:=1
		End if 
		OBJECT SET ENABLED:C1123(*; "CopyPhotos@"; DupInsp_CopyPhotos_B)
		
		If (DupInsp_CopyPhotos_B)
			DupInsp_CopyPhotos_L:=1
		End if 
		OBJECT SET ENABLED:C1123(*; "CopyCharts@"; DupInsp_CopyCharts_B)
		
		If (DupInsp_CopyCharts_B)
			DupInsp_CopyCharts_L:=1
		End if 
		
		OBJECT SET VISIBLE:C603(*; "CopyAsIS"; (User in group:C338(Current user:C182; "Design Access Group")))
		
	: (Form event code:C388=On Validate:K2:3)
		
End case 
