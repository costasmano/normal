//Method: Form Method: PrintTINInspRpt
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/06/16, 16:25:20
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
End if 
//

Case of 
	: (Form event code:C388=On Load:K2:1)
		C_LONGINT:C283(vlPrintInspRptDlgWID)
		vlPrintInspRptDlgWID:=Frontmost window:C447
		C_BOOLEAN:C305(bSpecMemPgsFlag; bCmtsFlag; bPhotoFlag; bSketchFlag; bChartFlag; bPontisFlag)
		C_LONGINT:C283(viNumPg1s)
		OBJECT SET ENABLED:C1123(vPrintPage1; True:C214)
		OBJECT SET ENABLED:C1123(vPrintCmts; bCmtsFlag)
		OBJECT SET ENABLED:C1123(vPrintSketches; bSketchFlag)
		OBJECT SET ENABLED:C1123(vPrintCharts; bChartFlag)
		OBJECT SET ENABLED:C1123(vPrintPhotos; bPhotoFlag)
		OBJECT SET ENABLED:C1123(vPrintPreview; True:C214)
		vPrintPage1:=0
		vPrintCmts:=0
		vPrintSketches:=0
		vPrintCharts:=0
		vPrintPhotos:=0
		vPrintPreview:=1
		Case of 
			: (InspectionPreviewToCheck_txt="Comments")
				If (bCmtsFlag)
					vPrintCmts:=1
				Else 
					vPrintCmts:=0
				End if 
				
			: (InspectionPreviewToCheck_txt="NTE")
				vPrintPage1:=1
				
			: (InspectionPreviewToCheck_txt="Images")
				If (bPhotoFlag)
					vPrintPhotos:=1
				Else 
					vPrintPhotos:=0
				End if 
				If (bSketchFlag)
					vPrintSketches:=1
				Else 
					vPrintSketches:=0
				End if 
				If (bChartFlag)
					vPrintCharts:=1
				Else 
					vPrintCharts:=0
				End if 
				
			Else 
				
				vPrintPreview:=0
				vPrintPage1:=1
				If (bCmtsFlag)
					vPrintCmts:=1
				Else 
					vPrintCmts:=0
				End if 
				
				If (bPhotoFlag)
					vPrintPhotos:=1
				Else 
					vPrintPhotos:=0
				End if 
				If (bSketchFlag)
					vPrintSketches:=1
				Else 
					vPrintSketches:=0
					
				End if 
				If (bChartFlag)
					vPrintCharts:=1
				Else 
					vPrintCharts:=0
				End if 
				
				
		End case 
	: (Form event code:C388=On Deactivate:K2:10)
		BRING TO FRONT:C326(Current process:C322)
		SHOW WINDOW:C435(vlPrintInspRptDlgWID)
End case 
//End Form Method: PrintTINInspRpt