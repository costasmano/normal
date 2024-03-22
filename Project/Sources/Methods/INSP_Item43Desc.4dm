//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/22/07, 15:28:40
	// ----------------------------------------------------
	// Method: INSP_Item43Desc
	// Description
	// Define the description and size of Item 43 for Inspection reports
	// 
	// Parameters
	// $1 : $Task (txt) ("Description" | "Resize")
	// ----------------------------------------------------
	
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(11/30/07 09:33:38)
	Mods_2007_CM_5401
End if 
C_TEXT:C284($1; $Task_txt)
If (Count parameters:C259>0)
	$Task_txt:=$1
Else 
	$Task_txt:="DESCRIPTION"
End if 

Case of 
	: ($Task_txt="DESCRI@")
		C_TEXT:C284(item43a)  // Command Replaced was o_C_STRING length was 1//This must not be a local variable!
		C_TEXT:C284(item43b)  // Command Replaced was o_C_STRING length was 2//This must not be a local variable!
		C_TEXT:C284(vItem43)  // Command Replaced was o_C_STRING length was 80
		
		item43a:=Substring:C12([Inspections:27]Item 43:140; 1; 1)
		item43b:=Substring:C12([Inspections:27]Item 43:140; 2; 2)
		vItem43:=Get_Description(-><>aMaterial; -><>aMatCode; ->item43a)+" "+Get_Description(-><>aDesign; -><>aDesignCod; ->item43b)
		If (f_Insp_Revision5([Inspections:27]Insp Date:78))
			vItem43:=[Inspections:27]Item 43:140+" : "+vItem43
		Else 
		End if 
		
	: ($Task_txt="RESIZE@")
		
		If (f_Insp_Revision5([Inspections:27]Insp Date:78))
			G_FitPrintObject(->vItem43; 11; 7; 6)
		Else 
			Case of 
				: (Length:C16(vItem43)>38)
					OBJECT SET FONT SIZE:C165(vItem43; 8)
					OBJECT MOVE:C664(vItem43; 0; -6; 0; 10)
				: (Length:C16(vItem43)>33)
					OBJECT SET FONT SIZE:C165(vItem43; 8)
				: (Length:C16(vItem43)>30)
					OBJECT SET FONT SIZE:C165(vItem43; 9)
			End case 
		End if 
End case 