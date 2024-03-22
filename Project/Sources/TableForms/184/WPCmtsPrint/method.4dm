// Method: [TIN_Inspections];"WPCmtsPrint"
// Description
// Form to print 
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 02/25/21, 17:33:07
	// ----------------------------------------------------
	// First Release
	Mods_2021_WP
	// Modified by: Costas Manousakis (8/15/22)
	Mods_2022_09_bug
	//change line ht to 99% for MacOS
End if 

//
Case of 
	: (Form event code:C388=On Header:K2:17)
		vPageNo:=vPageNo+1
		
	: (Form event code:C388=On Printing Detail:K2:18)
		vPageNo:=vPageNo+1
		C_OBJECT:C1216(INSP_Comments_WP)
		C_POINTER:C301($area_)
		$area_:=OBJECT Get pointer:C1124(Object named:K67:5; "WParea")
		//WP GET ATTRIBUTES($area_->;wk height;$ht;wk width;$w;wk layout unit;$unit;wk margin;$mar;wk margin bottom;$marb;wk margin left;$marl;\
			wk margin right;$marr;wk margin top;$mart)
		$area_->:=INSP_Comments_WP
		
		If (Is macOS:C1572)
			WP SET ATTRIBUTES:C1342($area_->; wk line height:K81:51; "99%")
		End if 
		
End case 
//End Form Method: [TIN_Inspections];"WPCmtsPrint"