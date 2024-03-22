//%attributes = {"invisible":true}
If (False:C215)
	//PRINT_PONTIS_F_PDF
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
	MODS_2021_01  //Add code that will create PDFs of all [Inspections]InspApproved=2
End if 
C_LONGINT:C283($FormWindow)
C_LONGINT:C283(vPageNo; vTotalPages; vPrintPreview)  //Command Replaced was o_C_INTEGER
//Initialize
vPageNo:=1
vTotalPages:=1

//2005-02-04 ASL
//Guarantee this.

ORDER BY:C49([Cond Units:45]; [BMS Elements:47]Element No:2; [Cond Units:45]Environment:4)
FORM SET OUTPUT:C54([Cond Units:45]; "Cond Units Prt 2")
PRINT SELECTION:C60([Cond Units:45]; *)

