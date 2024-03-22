//%attributes = {"invisible":true}
// Method: INSP_PRINTPontis
// Description
// 
// 
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/10/09, 08:24:14
	// ----------------------------------------------------
	// Parameters
	// ----------------------------------------------------
	
	Mods_2009_12
	// Modified by: costasmanousakis-(Designer)-(12/12/09 18:01:50)
	Mods_2010_02
	//Added check to run only if there are cond units
	// Modified by: costasmanousakis-(Designer)-(2/8/10 16:50:10)
	Mods_2010_02
	//  `Store and then re-set the current printer at the end of printing
	// Modified by: Costas Manousakis-(Designer)-(6/25/12 13:11:18)
	Mods_2012_06
	//  `added call to G_PrintOptions before each print selection
	// Modified by: Costas Manousakis-(Designer)-(4/1/15 16:22:36)
	Mods_2015_04
	//  `added check for NBE printing
	// Modified by: Costas Manousakis-(Designer)-(7/8/16 01:09:53)
	Mods_2016_08
	//  `use NTI_PrintNTEList 
	// Modified by: Costas Manousakis-(Designer)-(8/29/16 10:44:32)
	Mods_2016_08
	//  `use NTI_PrintNTEList for [Cond Units] also
End if 

C_LONGINT:C283(vPrintPontis; vPrintPontisField; vPageNo)
C_TEXT:C284($CurrPrinter_txt)
//$CurrPrinter_txt:=Get current printer

If (PON_NBEDateOn_b([Inspections:27]Insp Date:78))
	If (Records in selection:C76([PON_ELEM_INSP:179])>0)
		//ORDER BY FORMULA([PON_ELEM_INSP];PON_ElemSort )
		If (vPrintPontis=1)
			vPageNo:=vPageNo+1
			
			If (False:C215)
				FORM SET OUTPUT:C54([PON_ELEM_INSP:179]; "Print")
				PRINT SELECTION:C60([PON_ELEM_INSP:179]; >)
				FORM SET OUTPUT:C54([PON_ELEM_INSP:179]; "Output")
				
			Else 
				NTI_PrintNTEList(->[PON_ELEM_INSP:179])
			End if 
			
		End if 
		If (vPrintPontisField=1)
			If (False:C215)
				FORM SET OUTPUT:C54([PON_ELEM_INSP:179]; "PrintField")
				PRINT SELECTION:C60([PON_ELEM_INSP:179]; >)
				FORM SET OUTPUT:C54([PON_ELEM_INSP:179]; "Output")
			Else 
				NTI_PrintNTEList(->[PON_ELEM_INSP:179]; "PrintField")
			End if 
		End if 
		
	End if 
	
Else 
	If (Records in selection:C76([Cond Units:45])>0)
		
		If (vPrintPontis=1)
			//2005-02-09 ASL
			//Increment the page number count
			vPageNo:=vPageNo+1
			//SET PRINT OPTION(Spooler document name option ;"Pontis Insp-"+[Bridge MHD NBIS]BI  `N+"-"+String([Inspections]Insp Date))  `MODS_XXXX_CM
			ORDER BY:C49([Cond Units:45]; [BMS Elements:47]Element No:2; [Cond Units:45]Environment:4)
			If (False:C215)
				FORM SET OUTPUT:C54([Cond Units:45]; "Cond Units Prt 2")
				SET CURRENT PRINTER:C787($CurrPrinter_txt)
				G_PrintOptions
				PRINT SELECTION:C60([Cond Units:45]; *)
				FORM SET OUTPUT:C54([Cond Units:45]; "Cond Units Out")
			Else 
				NTI_PrintNTEList(->[Cond Units:45]; "Cond Units Prt 2")
			End if 
		End if 
		If (vPrintPontisField=1)
			//SET PRINT OPTION(Spooler document name option ;"Field Pontis Insp-"+[Bridge MHD N  `BIS]BIN+"-"+String([Inspections]Insp Date))  `MODS_XXXX_CM
			ORDER BY:C49([Cond Units:45]; [BMS Elements:47]Element No:2; [Cond Units:45]Environment:4)
			If (False:C215)
				FORM SET OUTPUT:C54([Cond Units:45]; "Cond Units Prt")
				SET CURRENT PRINTER:C787($CurrPrinter_txt)
				G_PrintOptions
				PRINT SELECTION:C60([Cond Units:45]; *)
				FORM SET OUTPUT:C54([Cond Units:45]; "Cond Units Out")
			Else 
				NTI_PrintNTEList(->[Cond Units:45]; "Cond Units Prt")
			End if 
		End if 
		
	End if 
End if 
//SET CURRENT PRINTER($CurrPrinter_txt)