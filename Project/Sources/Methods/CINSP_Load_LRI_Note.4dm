//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/10/07, 21:06:25
	// ----------------------------------------------------
	// Method: CINSP_Load_LRI_Note
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CM07
End if 
READ ONLY:C145([Parameters:107])
QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="CSLTINSP_LRINote")
If (Records in selection:C76([Parameters:107])=1)
	vLoadRtgInfoNote_txt:=[Parameters:107]Description:2
Else 
	vLoadRtgInfoNote_txt:="* The note in here is missing!"
End if 