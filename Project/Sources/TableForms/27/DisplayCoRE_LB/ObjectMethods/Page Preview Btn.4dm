If (False:C215)
	//[Inspections]Pontis Form.vbPGPreview
	//Preview print
	// ----------------------------------------------------
	// Object Method: vbPGPreview
	// User name (OS): cjmiller
	// Date and time: 03/29/05, 15:58:11
	// ----------------------------------------------------
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CJM02  //03/29/05, 15:58:27 
	// Modified by: costasmanousakis-(Designer)-(9/12/2007 10:32:57)
	Mods_2007_CM12_5301
End if 

//2005-02-03 ASL
If (vblnCombinedInspection=True:C214)
	USE NAMED SELECTION:C332("curCombinedInspection")
	RELATE ONE:C42([Combined Inspections:90]NBISInspID:2)
	RELATE ONE:C42([Combined Inspections:90]BMSInspID:3)
End if 

SET PRINT PREVIEW:C364(True:C214)
ON ERR CALL:C155("G_PrintError")
C_LONGINT:C283(viInspPreviewErr)  //Command Replaced was o_C_INTEGER//Initialize our Print Error var
viInspPreviewErr:=0  //initialize Error
G_PrintOptions
//PAGE SETUP([Inspections];"Routine Pr Pg 1")
//Print Pontis  
ORDER BY:C49([Cond Units:45]; [BMS Elements:47]Element No:2; [Cond Units:45]Environment:4)
FORM SET OUTPUT:C54([Cond Units:45]; "Cond Units Prt 2")
PRINT SELECTION:C60([Cond Units:45])
FORM SET OUTPUT:C54([Cond Units:45]; "Cond Units Out")
PAGE BREAK:C6
SET PRINT PREVIEW:C364(False:C215)
ON ERR CALL:C155("")
