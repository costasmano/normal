//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/10/06, 15:58:51
	// ----------------------------------------------------
	// Method: SC_YearAdd_60
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM03
End if 
C_LONGINT:C283($0; $YearsAdded)
Case of 
	: (Position:C15([Bridge MHD NBIS:1]Item60:132; "0123456789")<=0)
		$YearsAdded:=0
	: (Num:C11([Bridge MHD NBIS:1]Item60:132)<5)
		$YearsAdded:=0
	: (Num:C11([Bridge MHD NBIS:1]Item60:132)=5)
		$YearsAdded:=3
	: (Num:C11([Bridge MHD NBIS:1]Item60:132)=6)
		$YearsAdded:=5
	: (Num:C11([Bridge MHD NBIS:1]Item60:132)=7)
		$YearsAdded:=8
	: (Num:C11([Bridge MHD NBIS:1]Item60:132)>7)
		$YearsAdded:=10
		
End case 
$0:=$YearsAdded
