If (False:C215)
	//Object Method: [TIN_Inspections];"Input".vPrintPreview 
	// Modified by: Costas Manousakis-(Designer)-(8/9/16 11:00:42)
	Mods_2016_08_bug
	//  `added check for changes in AreaGeneralRemarks
	// Modified by: Chuck Miller -(Designer)-(1/25/18 15:09:39)
	Mods_2018_01
	//  `
	// Modified by: Costas Manousakis-(Designer)-(4/20/21 16:05:18)
	Mods_2021_WP
	//  `
End if 

SET PRINT PREVIEW:C364(True:C214)
If (Not:C34(Read only state:C362([TIN_Inspections:184])))
	
	NTI_SaveAndUpdateComments_WP(False:C215)
	
End if 
ON ERR CALL:C155("G_PrintError")
C_LONGINT:C283(viInspPreviewErr)  //Command Replaced was o_C_INTEGER//Initialize our Print Error var
viInspPreviewErr:=0  //initialize Error
C_LONGINT:C283(vPageNo; vTotalPages)
If (vTotalPages=0)
	vTotalPages:=999
End if 
C_BOOLEAN:C305(PrintFlag)
PrintFlag:=True:C214

If (True:C214)
	InspectionPreviewToCheck_txt:=""
	Case of 
		: (Tab Control{FORM Get current page:C276}="Comments")
			InspectionPreviewToCheck_txt:="Comments"
		: (Tab Control{FORM Get current page:C276}="NTE")
			InspectionPreviewToCheck_txt:="NTE"
		: (Tab Control{FORM Get current page:C276}="Postings")
			InspectionPreviewToCheck_txt:="NTE"
		: (Tab Control{FORM Get current page:C276}="Images")
			InspectionPreviewToCheck_txt:="Images"
		Else 
			InspectionPreviewToCheck_txt:="Preview Only"
	End case 
	NTI_PrintInspection
Else 
	ON ERR CALL:C155("G_PrintError")
	C_LONGINT:C283(viInspPreviewErr)  //Command Replaced was o_C_INTEGER//Initialize our Print Error var
	viInspPreviewErr:=0  //initialize Error
	C_LONGINT:C283(vPageNo; vTotalPages)
	If (vTotalPages=0)
		vTotalPages:=999
	End if 
	C_BOOLEAN:C305(PrintFlag)
	PrintFlag:=True:C214
	//C_LONGINT($viAreaMod)//Command Replaced was o_C_INTEGER
	//C_TEXT($vsStrValue)// Command Replaced was o_C_STRING length was 2
	//WR GET AREA PROPERTY (AreaGeneralRemarks;wr modified;$viAreaMod;$vsStrValue)
	//If ($viAreaMod=1)
	//INSP_4DWRITE_SaveToFld (AreaGeneralRemarks;->[TIN_Inspections]Comments;1)
	//End if 
	
	Case of 
		: (Tab Control{FORM Get current page:C276}="Comments")
			NTI_Print_CommentsWP_TIN
			
		: (Tab Control{FORM Get current page:C276}="NTE")
			vPrintPontis:=1
			vPrintPontisField:=0
			vPageNo:=0
			
			
			
		: (Tab Control{FORM Get current page:C276}="Images")
			C_TEXT:C284($menuChoises_txt)
			$menuChoises_txt:=" ;All Images;Sketches;Charts;Photos"
			C_LONGINT:C283($Choice_L)
			$Choice_L:=Pop up menu:C542($menuChoises_txt)
			C_LONGINT:C283(vPrintPhotos; vPrintSketches; vPrintCharts)
			vPrintPhotos:=0
			vPrintSketches:=0
			vPrintCharts:=0
			
			Case of 
				: ($Choice_L=2)
					vPrintPhotos:=1
					vPrintSketches:=1
					vPrintCharts:=1
					
				: ($Choice_L=3)
					vPrintSketches:=1
					
				: ($Choice_L=4)
					vPrintCharts:=1
					
				: ($Choice_L=5)
					vPrintPhotos:=1
					
			End case 
			If (NTI_ImageSortNeeded_b)
				CONFIRM:C162("Images have been Re-arranged! Apply the new sequence before printing? If you do not, the arrangement will be lost!"; "Apply new Sequence")
				If (OK=1)
					NTI_ApplyImageSort
				Else 
					OBJECT SET VISIBLE:C603(*; "ImageSortWarning"; False:C215)
					NTI_ImageSortNeeded_b:=False:C215
				End if 
				
			End if 
			NTI_PrintImages
	End case 
	PAGE BREAK:C6
	SET PRINT PREVIEW:C364(False:C215)
	ON ERR CALL:C155("")
End if 