If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/22/09, 08:18:03
	// ----------------------------------------------------
	// Method: Form Method: [ScourPOA];"Output"
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2009_05
	// Modified by: costasmanousakis-(Designer)-(5/19/11 17:23:21)
	Mods_2011_05
	//New Ver of  POA
	// Modified by: Costas Manousakis-(Designer)-(5/22/15 11:27:23)
	Mods_2015_05
	//  `Allow access to Quick report button to Designers and  personnel group SCPOA_ProjManager
	//  `Added menu ScourPOAMenu to the form
	// Modified by: Costas Manousakis-(Designer)-(5/27/15 14:39:44)
	Mods_2015_05
	//  `added Item 113 from POA and ITem 113 from BIN; Call SCPOA_Variables ("LOADFROMBLOB") in OnDisplayDetail event
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		SCPOA_Variables("INIT")
		If (User in group:C338(Current user:C182; "Design Access Group") | (GRP_UserInGroup("SCPOA_ProjManager")=1))
			OBJECT SET VISIBLE:C603(*; "bReport"; True:C214)
		End if 
	: (Form event code:C388=On Display Detail:K2:22)
		RELATE ONE:C42([ScourPOA:132]BIN:2)
		
		C_TEXT:C284(SCPOA_Out_Complete_txt; SCPOA_Out_PMReview_txt; SCPOA_Out_Apporove_txt)
		SCPOA_Out_Complete_txt:=""
		SCPOA_Out_PMReview_txt:=""
		SCPOA_Out_Apporove_txt:=""
		If ([ScourPOA:132]Completed:21)
			If ([ScourPOA:132]DateCompleted:8#!00-00-00!)
				SCPOA_Out_Complete_txt:=String:C10([ScourPOA:132]DateCompleted:8)
			Else 
				SCPOA_Out_Complete_txt:="Y"
			End if 
		End if 
		If ([ScourPOA:132]PMReviewed:29>0)
			If ([ScourPOA:132]PMReviewDate:28#!00-00-00!)
				SCPOA_Out_PMReview_txt:=String:C10([ScourPOA:132]PMReviewDate:28)
			Else 
				SCPOA_Out_PMReview_txt:="Y"
			End if 
		End if 
		If ([ScourPOA:132]Approved:23>0)
			If ([ScourPOA:132]DateApproved:5#!00-00-00!)
				SCPOA_Out_Apporove_txt:=String:C10([ScourPOA:132]DateApproved:5)
			Else 
				SCPOA_Out_Apporove_txt:="Y"
			End if 
		End if 
		SCPOA_Variables("LOADFROMBLOB")
		
	: (Form event code:C388=On Outside Call:K2:11)
		If (<>fQuit)
			CANCEL:C270
		End if 
	: (Form event code:C388=On Open Detail:K2:23)
		C_LONGINT:C283(SCPOA_out_scr_w; SCPOA_out_scr_h)
		C_LONGINT:C283($l; $t; $r; $b)
		GET WINDOW RECT:C443($l; $t; $r; $b)
		SCPOA_out_scr_w:=($r-$l)
		SCPOA_out_scr_h:=$b-$t
	: (Form event code:C388=On Close Detail:K2:24)
		C_LONGINT:C283($l; $t; $r; $b; $newW; $Newh)
		GET WINDOW RECT:C443($l; $t; $r; $b)
		$newW:=$r-$l
		$Newh:=$b-$t
		If ($newW<SCPOA_out_scr_w)
			SET WINDOW RECT:C444($l; $t; ($r+SCPOA_out_scr_w-$newW); $b)
		Else 
			SCPOA_out_scr_w:=$newW
		End if 
		
	: (Form event code:C388=On Activate:K2:9)
		UpdatFilesPalet
	: (Form event code:C388=On Deactivate:K2:10)
		UpdatFilesPalet
		
End case 