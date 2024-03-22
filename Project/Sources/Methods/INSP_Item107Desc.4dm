//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/22/07, 09:28:22
	// ----------------------------------------------------
	// Method: INSP_Item107Desc
	// Description
	// Define the description and size of Item 107 for Inspection reports
	// 
	// Parameters
	// $1 : $Task (txt) ("Description" | "Resize")
	// ----------------------------------------------------
	
	Mods_2007_CM12_5301
End if 
C_TEXT:C284($1; $Task_txt)
If (Count parameters:C259>0)
	$Task_txt:=$1
Else 
	$Task_txt:="DESCRIPTION"
End if 

Case of 
	: ($Task_txt="DESCRI@")
		C_TEXT:C284(vItem107)  // Command Replaced was o_C_STRING length was 40
		vItem107:=Get_Description(-><>aDeck; -><>aDeckCod; ->[Inspections:27]Item 107:141)
		If (f_Insp_Revision5([Inspections:27]Insp Date:78))
			vItem107:=[Inspections:27]Item 107:141+" : "+vItem107
		Else 
		End if 
		
	: ($Task_txt="RESIZE@")
		
End case 