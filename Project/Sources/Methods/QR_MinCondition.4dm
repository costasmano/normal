//%attributes = {"shared":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/16/06, 14:09:23
	// ----------------------------------------------------
	// Method: QR_MinCondition
	// Description
	// Return the minimum condition rating of Items 58,59,60,62
	// 
	// Parameters
	// $0 : $MinRtg (longint)
	// ----------------------------------------------------
	Mods_2006_CM03
End if 
C_LONGINT:C283($0; $MinRtg)
$MinRtg:=9
If (bIsNumeric([Bridge MHD NBIS:1]Item58:130))
	If (Num:C11([Bridge MHD NBIS:1]Item58:130)<$MinRtg)
		$MinRtg:=Num:C11([Bridge MHD NBIS:1]Item58:130)
	End if 
End if 
If (bIsNumeric([Bridge MHD NBIS:1]Item59:131))
	If (Num:C11([Bridge MHD NBIS:1]Item59:131)<$MinRtg)
		$MinRtg:=Num:C11([Bridge MHD NBIS:1]Item59:131)
	End if 
End if 
If (bIsNumeric([Bridge MHD NBIS:1]Item60:132))
	If (Num:C11([Bridge MHD NBIS:1]Item60:132)<$MinRtg)
		$MinRtg:=Num:C11([Bridge MHD NBIS:1]Item60:132)
	End if 
End if 
If (bIsNumeric([Bridge MHD NBIS:1]Item62:134))
	If (Num:C11([Bridge MHD NBIS:1]Item62:134)<$MinRtg)
		$MinRtg:=Num:C11([Bridge MHD NBIS:1]Item62:134)
	End if 
End if 
$0:=$MinRtg