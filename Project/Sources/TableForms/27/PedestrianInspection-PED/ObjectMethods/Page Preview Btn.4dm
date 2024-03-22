If (False:C215)
	// ----------------------------------------------------
	// Object Method: vbPGPreview
	// User name (OS): cjmiller
	// Date and time: 03/29/05, 15:57:39
	// ----------------------------------------------------
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	
	//[Inspections]Routine Combined Form.vbPGPreview
	//Preview pages depending on which form page is current.
	Mods_2005_CM06
	Mods_2005_CJM02  //03/29/05, 15:57:34
	// Modified by: costasmanousakis-(Designer)-(2/21/2006 10:29:51)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(1/23/2007 16:08:22)
	Mods_2007_CM05a
	// Modified by: costasmanousakis-(Designer)-(4/17/2007 09:22:22)
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(9/12/2007 10:30:18)
	Mods_2007_CM12_5301
	Mods_2009_03  //CJM 2004 upgrade   `03/27/09, 14:00:59
	// Modified by: Costas Manousakis-(Designer)-(4/16/21 17:00:03)
	Mods_2021_WP
	//  `
	// Modified by: Costas Manousakis-(Designer)-(2021-12-01 18:17:59)
	Mods_2021_11_bug
	//  `include page 2 when printing from input pages 1,2,3 (general, 58-61, elements)
	// Modified by: Costas Manousakis-(Designer)-(2021-12-23T00:00:00 13:44:34)
	Mods_2021_12_bug
	//  `call INSP_SaveInspCommts
End if 
INSP_SaveInspCommts

//2004-06-04 ASL
If (vblnCombinedInspection=True:C214)
	If (Not:C34(Is record loaded:C669([BMS Inspections:44])))
		If ([Combined Inspections:90]BMSInspID:3>0)
			USE NAMED SELECTION:C332("curCombinedInspection")
			//RELATE ONE([Combined Inspections]NBISInspID)
			RELATE ONE:C42([Combined Inspections:90]BMSInspID:3)
		End if 
	End if 
End if 

SET PRINT PREVIEW:C364(True:C214)
C_BOOLEAN:C305(PrintFlag)
C_LONGINT:C283(vPageNo; vPrintPhotos; vPrintSketches; vPrintCharts)  //Command Replaced was o_C_INTEGER

COPY NAMED SELECTION:C331([ElementsSafety:29]; "TempElmtsPreview")
COPY NAMED SELECTION:C331([Standard Photos:36]; "TempImagesPreview")
//count pages
G_CountRTNInspPgs

sInspDATE:=Uppercase:C13(String:C10([Inspections:27]Insp Date:78; Internal date abbreviated:K1:6))
ON ERR CALL:C155("G_PrintError")
C_LONGINT:C283(viInspPreviewErr)  //Command Replaced was o_C_INTEGER//Initialize our Print Error var
viInspPreviewErr:=0  //initialize Error
G_PrintOptions
//PAGE SETUP([Inspections];"Routine Pr Pg 1")
C_LONGINT:C283($viCurPg)  //Command Replaced was o_C_INTEGER
$viCurPg:=FORM Get current page:C276
Case of 
	: (($viCurPg=1) | ($viCurPg=2) | ($viCurPg=3))
		Print form:C5([Inspections:27]; "PedBridge_p1")
		PAGE BREAK:C6(>)
		Print form:C5([Inspections:27]; "PedBridge_p2")
		
		
		If (viInspPreviewErr=0)
			vPageNo:=2
			If (G_Insp_CountSpMs>0)
				PAGE BREAK:C6(>)
				Print_SpecMem_pg3
			End if 
			PAGE BREAK:C6
			
		End if 
	: ($viCurPg=4)
		vPageNo:=viCmtsPgStart-1
		PrintFlag:=True:C214
		C_LONGINT:C283($vlNumCmtPgs)
		$vlNumCmtPgs:=Print_RTN_Cmts_WP
		If ($vlNumCmtPgs=0)
			ALERT:C41("There are no Comments for this Inspection")
		Else 
			PAGE BREAK:C6
		End if 
	: ($viCurPg=5)
		Print form:C5([Inspections:27]; "PedBridge_p2")
		
		PAGE BREAK:C6
		
		//2005-01-31 ASL Changed to page 8 because of Pontis
	: ($viCurPg=6)
		G_PreviewInspImage
		
		
End case 

SET PRINT PREVIEW:C364(False:C215)
ON ERR CALL:C155("")
USE NAMED SELECTION:C332("TempElmtsPreview")
USE NAMED SELECTION:C332("TempImagesPreview")
CLEAR NAMED SELECTION:C333("TempElmtsPreview")
CLEAR NAMED SELECTION:C333("TempImagesPreview")