//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/19/07, 08:12:06
	// ----------------------------------------------------
	// Method: SIA_GetUWItems
	// Description
	// Retrieve the UW ratings for Item 60,61,62 for display on SI&A forms
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM_5401
End if 
C_TEXT:C284(SIA_UW_60_s; SIA_UW_61_s; SIA_UW_62_s)  // Command Replaced was o_C_STRING length was 1
SIA_UW_60_s:="-"
SIA_UW_61_s:="-"
SIA_UW_62_s:="-"
C_TEXT:C284($Above60_s; $Above61_s; $Above62_s; $UW60_s; $UW61_s; $UW62_s)  // Command Replaced was o_C_STRING length was 1
C_DATE:C307($Above_d; $UW_d)
$Above_d:=!00-00-00!
$UW_D:=!00-00-00!

READ ONLY:C145([Inspections:27])
QUERY:C277([Inspections:27]; [Inspections:27]BIN:1=[Bridge MHD NBIS:1]BIN:3)
QUERY SELECTION:C341([Inspections:27]; [Inspections:27]Insp Type:6="RT@"; *)
QUERY SELECTION:C341([Inspections:27];  | ; [Inspections:27]Insp Type:6="CUL"; *)
QUERY SELECTION:C341([Inspections:27];  | ; [Inspections:27]Insp Type:6="CLO")
QUERY SELECTION:C341([Inspections:27]; [Inspections:27]InspReviewed:12=BMS Approved)
If (Records in selection:C76([Inspections:27])>0)
	ORDER BY:C49([Inspections:27]; [Inspections:27]Insp Date:78; <)
	FIRST RECORD:C50([Inspections:27])
	$Above_d:=[Inspections:27]Insp Date:78
	$Above60_s:=[Inspections:27]Item 60 UW:66
	$Above61_s:=[Inspections:27]Item 61 UW:72
	$Above62_s:=[Inspections:27]Item 62 UW:165
End if 
QUERY:C277([Inspections:27]; [Inspections:27]BIN:1=[Bridge MHD NBIS:1]BIN:3)
QUERY SELECTION:C341([Inspections:27]; [Inspections:27]Insp Type:6="DV@"; *)
QUERY SELECTION:C341([Inspections:27];  & ; [Inspections:27]InspApproved:167=BMS Approved)
If (Records in selection:C76([Inspections:27])>0)
	ORDER BY:C49([Inspections:27]; [Inspections:27]Insp Date:78; <)
	FIRST RECORD:C50([Inspections:27])
	$UW_d:=[Inspections:27]Insp Date:78
	$UW60_s:=[Inspections:27]Item 60 UW:66
	$UW61_s:=[Inspections:27]Item 61 UW:72
	$UW62_s:=[Inspections:27]Item 62 UW:165
End if 

If (($UW_d#!00-00-00!) | ($Above_d#!00-00-00!))
	If ($Above_d>$UW_d)
		SIA_UW_60_s:=$Above60_s
		SIA_UW_61_s:=$Above61_s
		SIA_UW_62_s:=$Above62_s
	Else 
		SIA_UW_60_s:=$UW60_s
		SIA_UW_61_s:=$UW61_s
		SIA_UW_62_s:=$UW62_s
	End if 
	
End if 

READ WRITE:C146([Inspections:27])
If (SIA_UW_60_s+SIA_UW_60_s+SIA_UW_60_s="")
	OBJECT SET VISIBLE:C603(*; "SIA_UW_Label"; False:C215)
Else 
	OBJECT SET VISIBLE:C603(*; "SIA_UW_Label"; True:C214)
End if 