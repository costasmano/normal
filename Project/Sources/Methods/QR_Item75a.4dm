//%attributes = {"shared":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/22/11, 18:00:41
	// ----------------------------------------------------
	// Method: QR_Item75a
	// Description
	//  ` Provide translation for Item 75A
	// 
	// Parameters
	// $0 : $Item75aTran_txt
	// $1 : $Item75aCode_txt (Optional)
	// ----------------------------------------------------
	
	Mods_2011_03
End if 
C_TEXT:C284($0; $Item75aTran_txt)
C_TEXT:C284($Item75aCode_txt)
If (Count parameters:C259>0)
	C_TEXT:C284($1)
	$Item75aCode_txt:=$1
Else 
	$Item75aCode_txt:=[Bridge MHD NBIS:1]Item75A:152
End if 
$0:=Get_Description(-><>aTypeofWork; -><>aTypeofWCod; ->$Item75aCode_txt)
If ($0="")
	$0:="Unknown"
End if 

