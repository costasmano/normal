If (False:C215)
	// ----------------------------------------------------
	// Object Method: vbPGPreview
	// User name (OS): cjmiller
	// Date and time: 03/29/05, 15:57:59
	// ----------------------------------------------------
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	
	// Modified by: Costas Manousakis-(Designer)-(4/16/21 17:00:03)
	Mods_2021_WP
	//  `
	
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

G_CountCulvInspPgs

sInspDATE:=Uppercase:C13(String:C10([Inspections:27]Insp Date:78; Internal date abbreviated:K1:6))
ON ERR CALL:C155("G_PrintError")
C_LONGINT:C283(viInspPreviewErr)  //Command Replaced was o_C_INTEGER//Initialize our Print Error var
viInspPreviewErr:=0  //initialize Error
G_PrintOptions
//PAGE SETUP([Inspections];"Routine Pr Pg 1")
C_LONGINT:C283($viCurPg)  //Command Replaced was o_C_INTEGER
$viCurPg:=FORM Get current page:C276
Case of 
	: (($viCurPg=1) | ($viCurPg=2) | ($viCurPg=4) | ($viCurPg=3))
		Print form:C5([Inspections:27]; "RailRoutine Culvert")
		If (viInspPreviewErr=0)
			vPageNo:=1
			If (G_Insp_CountSpMs>0)
				PAGE BREAK:C6(>)
				Print_SpecMem_pg3
			End if 
			PAGE BREAK:C6
		End if 
		
	: ($viCurPg=5)
		//Print Pontis  
		ORDER BY:C49([Cond Units:45]; [BMS Elements:47]Element No:2; [Cond Units:45]Environment:4)
		FORM SET OUTPUT:C54([Cond Units:45]; "Cond Units Prt 2")
		PRINT SELECTION:C60([Cond Units:45])
		FORM SET OUTPUT:C54([Cond Units:45]; "Cond Units Out")
		PAGE BREAK:C6
		
	: ($viCurPg=6)
		vPageNo:=viCmtsPgStart-1
		C_LONGINT:C283($vlNumCmtPgs)
		$vlNumCmtPgs:=Print_CUL_Cmts_WP(New object:C1471("printFlag"; True:C214))
		If ($vlNumCmtPgs=0)
			ALERT:C41("There are no Comments for this Inspection")
		Else 
			PAGE BREAK:C6
		End if 
		
	: (FORM Get current page:C276=7)
		G_PreviewInspImage
		
End case 

SET PRINT PREVIEW:C364(False:C215)
ON ERR CALL:C155("")
USE NAMED SELECTION:C332("TempElmtsPreview")
USE NAMED SELECTION:C332("TempImagesPreview")
CLEAR NAMED SELECTION:C333("TempElmtsPreview")
CLEAR NAMED SELECTION:C333("TempImagesPreview")