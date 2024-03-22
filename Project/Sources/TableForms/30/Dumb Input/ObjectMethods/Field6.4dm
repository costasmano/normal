If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(12/29/10 13:26:14)
	Mods_2010_12
	//Admin Fix - check that parent number is not the same and not greater than the element number
End if 
C_LONGINT:C283($ParentExists_L)
SET QUERY DESTINATION:C396(Into variable:K19:4; $ParentExists_L)
QUERY:C277([ElementDict:30]; [ElementDict:30]ElementNo:1=[ElementDict:30]Parent:4)
SET QUERY DESTINATION:C396(Into current selection:K19:1)
Case of 
	: ([ElementDict:30]Parent:4>[ElementDict:30]ElementNo:1)
		ALERT:C41("Parent Element number cannot be greater than the Element Number!")
		[ElementDict:30]Parent:4:=Old:C35([ElementDict:30]Parent:4)
		REJECT:C38([ElementDict:30]Parent:4)
		GOTO OBJECT:C206([ElementDict:30]Parent:4)
	: ([ElementDict:30]Parent:4>[ElementDict:30]ElementNo:1)
		ALERT:C41("Parent Element number cannot be the same with the Element Number!")
		[ElementDict:30]Parent:4:=Old:C35([ElementDict:30]Parent:4)
		REJECT:C38([ElementDict:30]Parent:4)
		GOTO OBJECT:C206([ElementDict:30]Parent:4)
	: ($ParentExists_L=0)
		ALERT:C41("Parent Element number does not exist!!!!")
		[ElementDict:30]Parent:4:=Old:C35([ElementDict:30]Parent:4)
		REJECT:C38([ElementDict:30]Parent:4)
		GOTO OBJECT:C206([ElementDict:30]Parent:4)
	Else 
		PushChange(1; Self:C308)
End case 