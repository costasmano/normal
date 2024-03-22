//%attributes = {"invisible":true}
//Method: INSP_Item44Desc
//Description
// Define the description and size of Item 44 for Inspection reports
// Copied from INSP_Item43Desc
//
// Parameters
// $1 : $Task (txt) ("Description" | "Resize")
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/08/13, 16:06:27
	// ----------------------------------------------------
	//Created : 
	Mods_2013_01
	Mods_2013_01  //r004 ` Changed  from 80 to TEXT as that is what is was set for in compiler directives
	//Modified by: Charles Miller (1/24/13 16:11:35)
	// Modified by: Costas Manousakis-(Designer)-(2022-10-31 17:58:24)
	Mods_2022_10_bug
	//  `use field [Bridge MHD NBIS]Item44 instead of [Inspections]Item 43
End if 
//

C_TEXT:C284($1; $Task_txt)
If (Count parameters:C259>0)
	$Task_txt:=$1
Else 
	$Task_txt:="DESCRIPTION"
End if 

Case of 
	: ($Task_txt="DESCRI@")
		C_TEXT:C284($Item43a)  // Command Replaced was o_ C _STRING length was 1
		C_TEXT:C284($Item43b)  // Command Replaced was o_ C _STRING length was 2
		C_TEXT:C284(vItem44)
		
		$Item43a:=Substring:C12([Bridge MHD NBIS:1]Item44:76; 1; 1)
		$Item43b:=Substring:C12([Bridge MHD NBIS:1]Item44:76; 2; 2)
		vItem44:=Get_Description(-><>aMaterial; -><>aMatCode; ->$Item43a)+" "+Get_Description(-><>aDesign; -><>aDesignCod; ->$Item43b)
		If (f_Insp_Revision5([Inspections:27]Insp Date:78))
			vItem44:=[Bridge MHD NBIS:1]Item44:76+" : "+vItem44
		Else 
		End if 
		
	: ($Task_txt="RESIZE@")
		
		If (f_Insp_Revision5([Inspections:27]Insp Date:78))
			G_FitPrintObject(->vItem44; 11; 7; 6)
		Else 
			Case of 
				: (Length:C16(vItem44)>38)
					OBJECT SET FONT SIZE:C165(vItem44; 8)
					OBJECT MOVE:C664(vItem44; 0; -6; 0; 10)
				: (Length:C16(vItem44)>33)
					OBJECT SET FONT SIZE:C165(vItem44; 8)
				: (Length:C16(vItem44)>30)
					OBJECT SET FONT SIZE:C165(vItem44; 9)
			End case 
		End if 
End case 
//End INSP_Item44Desc