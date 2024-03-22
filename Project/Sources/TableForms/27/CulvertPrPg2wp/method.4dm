If (False:C215)
	// `Form Method: [Inspections];"CulvertPrPg2wp"
	
	// Modified by: Costas Manousakis-(Designer)-(4/16/21 15:12:25)
	Mods_2021_WP
	//  `
	// Modified by: Costas Manousakis (9/16/22)
	Mods_2022_09_bug
	//change line ht to 99% for MacOS
End if 
Case of 
		
	: (Form event code:C388=On Header:K2:17)
		
	: (Form event code:C388=On Printing Detail:K2:18)
		FORM_FixHairLine
		vPageNo:=vPageNo+1  //need to calculate this even though it is not used.
		C_OBJECT:C1216(INSP_Comments_WP)
		C_POINTER:C301($area_)
		$area_:=OBJECT Get pointer:C1124(Object named:K67:5; "WParea")
		//WP GET ATTRIBUTES($area_->;wk height;$ht;wk width;$w;wk layout unit;$unit;wk margin;$mar;wk margin bottom;$marb;wk margin left;$marl;\
			wk margin right;$marr;wk margin top;$mart)
		$area_->:=INSP_Comments_WP
		C_TEXT:C284($ht; $w; $unit; $mar; $marb; $marl; $marr; $mart)
		WP GET ATTRIBUTES:C1345($area_->; wk height:K81:46; $ht; wk width:K81:45; $w; wk layout unit:K81:78; $unit; wk margin:K81:10; $mar; wk margin bottom:K81:14; $marb; wk margin left:K81:11; $marl; \
			wk margin right:K81:12; $marr; wk margin top:K81:13; $mart)
		
		If (Is macOS:C1572)
			WP SET ATTRIBUTES:C1342($area_->; wk line height:K81:51; "99%")
		End if 
		
End case 
