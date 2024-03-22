//%attributes = {"invisible":true}
If (False:C215)
	//PRINT_PONTIS_F
	//Created 2005/02/02
	//Author: Albert Leung
	//Print Pontis  
	// User name (OS): cjmiller
	// Date and time: 03/29/05, 16:15:10
	// ----------------------------------------------------
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	
	Mods_2005_CJM02  //03/29/05, 16:15:21 
	// Modified by: costasmanousakis-(Designer)-(9/12/2007 11:34:34)
	Mods_2007_CM12_5301
	Mods_2009_03  //CJM  r001   `03/06/09, 14:28:58`Upgrade from open form window to open window
	// Modified by: Costas Manousakis-(Designer)-(6/29/21 15:25:24)
	Mods_2021_v17
	//  `modified to work in v17 preview must be set after the print settings
End if 
C_LONGINT:C283($FormWindow)
C_LONGINT:C283(vPageNo; vTotalPages; vPrintPreview)  //Command Replaced was o_C_INTEGER
//Initialize
vPageNo:=1
vTotalPages:=1

//2005-02-04 ASL
//Guarantee this.
SET PRINT PREVIEW:C364(False:C215)

C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
C_TEXT:C284($Title_txt)
FORM GET PROPERTIES:C674([Dialogs:21]; "PrintPontisRpt"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10; $Title_txt; "ut_CloseCancel")
//$FormWindow:=Open form window([Dialogs];"PrintPontisRpt")
DIALOG:C40([Dialogs:21]; "PrintPontisRpt")
CLOSE WINDOW:C154($Win_l)
If (OK=1)
	G_PrintOptions
	//PAGE SETUP([Inspections];"Dive Pr Pg 1")
	If (<>ShowPrint)
		PRINT SETTINGS:C106
	End if 
	If (OK=1)  //user can cancel from the print settings  
		If (vPrintPreview=1)
			SET PRINT PREVIEW:C364(True:C214)
		End if 
		ORDER BY:C49([Cond Units:45]; [BMS Elements:47]Element No:2; [Cond Units:45]Environment:4)
		FORM SET OUTPUT:C54([Cond Units:45]; "Cond Units Prt 2")
		PRINT SELECTION:C60([Cond Units:45]; *)
		FORM SET OUTPUT:C54([Cond Units:45]; "Cond Units Out")
	End if 
	If (vPrintPreview=1)
		SET PRINT PREVIEW:C364(False:C215)
	End if 
End if 