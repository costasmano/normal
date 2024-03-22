//form method [Inspections];"NTECmtsPrintWP"
If (False:C215)
	//copied from [Inspections];"NTECmtsPrint"
	// Modified by: Costas Manousakis (9/16/22)
	Mods_2022_09_bug
	//change line ht to 99% for MacOS
End if 
Case of 
		
	: (Form event code:C388=On Header:K2:17)
		vPageNo:=vPageNo+1
		
	: (Form event code:C388=On Printing Detail:K2:18)
		vPageNo:=vPageNo+1
		C_OBJECT:C1216(INSP_Comments_WP)
		C_POINTER:C301($area_)
		$area_:=OBJECT Get pointer:C1124(Object named:K67:5; "WParea")
		$area_->:=INSP_Comments_WP
		
		If (Is macOS:C1572)
			WP SET ATTRIBUTES:C1342($area_->; wk line height:K81:51; "99%")
		End if 
		
End case 