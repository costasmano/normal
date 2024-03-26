//%attributes = {"invisible":true}
//GP: PRINT_SIA
//Copyright © 1995-1996,  Albert S. Leung, All Rights Reserved.
// ----------------------------------------------------
If (False:C215)
	// PRINT_SIA
	// User name (OS): cjmiller
	// Date and time: 03/29/05, 16:05:22
	// ----------------------------------------------------
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CJM02  //03/29/05, 16:05:29 
	// Modified by: costasmanousakis-(Designer)-(9/12/2007 11:19:41)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(1/20/11 09:30:28)
	Mods_2011_01
	//` RR
	// Modified by: costasmanousakis-(Designer)-(5/13/11 15:47:44)
	Mods_2011_05
	//  `Made dialog window movable dialog box. (avoid problems in v11)
	// Modified by: Costas Manousakis-(Designer)-(5/20/13 10:39:17)
	Mods_2013_05
	//  `Changed lodic to a case statements - added Tunnel SIA form
	// Modified by: Costas Manousakis-(Designer)-(4/23/14 17:40:24)
	Mods_2014_04
	//  `Removed the querying of Rail info and tunnel info. not necessary since this is called from input form where records are already loaded.
	// Modified by: Costas Manousakis-(Designer)-(10/2/15 16:05:19)
	Mods_2015_10_bug
	//  `use method SIA_PrintForms
	// Modified by: Costas Manousakis-(Designer)-(2024-03-26 14:41:42)
	Mods_2024_03_bug
	//  `added Open/Close printing job and spooler doc name to prevent crash when printing to Adobe PDF
	// with MS print to pdf the save as dialog shows at the Open print job command and user can cancel here
	// other pdf printers show the save as dialog at the Close print job command. 
End if 

C_TEXT:C284($spoolerdocname_txt)
$spoolerdocname_txt:=[Bridge MHD NBIS:1]BDEPT:1+"-"+[Bridge MHD NBIS:1]BIN:3+"-SIA"
G_PrintOptions
SET PRINT OPTION:C733(Spooler document name option:K47:10; $spoolerdocname_txt)

Case of 
	: ([Bridge MHD NBIS:1]Item8 BridgeCat:207="@RO")
		//PAGE SETUP([Bridge MHD NBIS];"SI & A (Normal)")
		If (<>ShowPrint)
			PRINT SETTINGS:C106
		End if 
		If (OK=1)
			OPEN PRINTING JOB:C995  // change Mods_2024_03_bug
			
			If (OK=1)  // change Mods_2024_03_bug
				//READ ONLY([RAILBridgeInfo])
				//QUERY([RAILBridgeInfo];[RAILBridgeInfo]BIN=[Bridge MHD NBIS]BIN)
				Print form:C5([Bridge MHD NBIS:1]; "RailTransitSIA")
				
			End if   // change Mods_2024_03_bug
			CLOSE PRINTING JOB:C996  // change Mods_2024_03_bug
			
		End if 
		
	: ([Bridge MHD NBIS:1]Item8 BridgeCat:207="TNL") | ([Bridge MHD NBIS:1]Item8 BridgeCat:207="BTS")
		
		//PAGE SETUP([Bridge MHD NBIS];"SI & A (Normal)")
		If (<>ShowPrint)
			PRINT SETTINGS:C106
		End if 
		If (OK=1)
			OPEN PRINTING JOB:C995  // change Mods_2024_03_bug
			//READ ONLY([TunnelInfo])
			//QUERY([TunnelInfo];[TunnelInfo]BIN=[Bridge MHD NBIS]BIN)
			If (OK=1)  // change Mods_2024_03_bug
				Print form:C5([Bridge MHD NBIS:1]; "TunnelSIA")
				
			End if 
			CLOSE PRINTING JOB:C996  // change Mods_2024_03_bug
		End if 
		
	Else 
		CENTER_WINDOW(250; 200; Movable dialog box:K34:7)
		DIALOG:C40([Dialogs:21]; "Print SIA")
		CLOSE WINDOW:C154
		
		If (Ok=1)
			//PAGE SETUP([Bridge MHD NBIS];"SI & A (Normal)")
			If (<>ShowPrint)
				PRINT SETTINGS:C106
			End if 
			If (Ok=1)  //Nov-2002 added check to see if canceled from Print Settings
				
				OPEN PRINTING JOB:C995  // change Mods_2024_03_bug
				If (ok=1)  // change Mods_2024_03_bug
					SIA_PrintForms(CBSIANormal; CBSIAInsp; CBSIAMA)
					//end of change Mods_2015_10_bug
					
				End if 
				
				CLOSE PRINTING JOB:C996  // change Mods_2024_03_bug
			End if 
		End if 
End case 

REDRAW WINDOW:C456