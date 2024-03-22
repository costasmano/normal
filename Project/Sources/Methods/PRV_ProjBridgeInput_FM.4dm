//%attributes = {"invisible":true}
// Method: PRV_ProjBridgeInput_FM
// Description
// 
// 
// Parameters
// $1 : $FormEvent_L
// ----------------------------------------------------
If (False:C215)
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 06/07/12, 17:31:10
	// ----------------------------------------------------
	// First Release
	Mods_2012_06
	// Modified by: Costas Manousakis-(Designer)-(9/25/13 15:02:54)
	Mods_2013_09
	//  `Copied to DEV
End if 
C_LONGINT:C283($FormEvent_L)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
Else 
	$FormEvent_L:=Form event code:C388
End if 
C_LONGINT:C283(PRV_GETBRIDGEBININFO_L)
PRV_GETBRIDGEBININFO_L:=15002
Case of 
	: ($FormEvent_L=On Close Detail:K2:24)
		
	: ($FormEvent_L=On Load:K2:1)
		If (Is new record:C668([Contract_Project_Maintenance:100]))
			If ([Contract_Assignment_Maintenance:101]AssignID:3=0)
				CANCEL:C270
			Else 
				Inc_Sequence("ProjMaint"; ->[Contract_Project_Maintenance:100]ProjectID:1)
				
				//initialize all variables
				[Contract_Project_Maintenance:100]ContractNo:2:=[Contract_Assignment_Maintenance:101]ContractNo:1
				[Contract_Project_Maintenance:100]AssignNo:9:=[Contract_Assignment_Maintenance:101]AssignNo:2
				[Contract_Project_Maintenance:100]AssignID:13:=[Contract_Assignment_Maintenance:101]AssignID:3
				[Contract_Project_Maintenance:100]Project Type:3:=""
				[Contract_Project_Maintenance:100]BIN:5:=""
				vBridgeNo:=""
				vDistrict:=""
				vTown:=""
				vLocation:=""
			End if 
		Else 
			vBridgeNo:=[Contract_Project_Maintenance:100]BridgeNo:4
			vDistrict:=[Contract_Project_Maintenance:100]District:8
			vTown:=[Contract_Project_Maintenance:100]Town:7
			vLocation:=[Contract_Project_Maintenance:100]Location:6
			
			If ([Contract_Project_Maintenance:100]BridgeNo:4="Various")
				OBJECT SET ENTERABLE:C238([Contract_Project_Maintenance:100]BIN:5; False:C215)
				OBJECT SET RGB COLORS:C628([Contract_Project_Maintenance:100]BIN:5; Col_paletteToRGB(Abs:C99(<>color_not_editable)%256); Col_paletteToRGB(Abs:C99(<>color_not_editable)\256))  // **Replaced o OBJECT SET COLOR([Contract_Project_Maintenance]BIN; <>color_not_editable)
				OBJECT SET ENTERABLE:C238([Contract_Project_Maintenance:100]Town:7; True:C214)
				OBJECT SET ENTERABLE:C238([Contract_Project_Maintenance:100]District:8; True:C214)
				OBJECT SET ENTERABLE:C238([Contract_Project_Maintenance:100]Location:6; True:C214)
				OBJECT SET RGB COLORS:C628([Contract_Project_Maintenance:100]Town:7; Col_paletteToRGB(Abs:C99(<>color_editable)%256); Col_paletteToRGB(Abs:C99(<>color_editable)\256))  // **Replaced o OBJECT SET COLOR([Contract_Project_Maintenance]Town; <>color_editable)
				OBJECT SET RGB COLORS:C628([Contract_Project_Maintenance:100]District:8; Col_paletteToRGB(Abs:C99(<>color_editable)%256); Col_paletteToRGB(Abs:C99(<>color_editable)\256))  // **Replaced o OBJECT SET COLOR([Contract_Project_Maintenance]District; <>color_editable)
				OBJECT SET RGB COLORS:C628([Contract_Project_Maintenance:100]Location:6; Col_paletteToRGB(Abs:C99(<>color_editable)%256); Col_paletteToRGB(Abs:C99(<>color_editable)\256))  // **Replaced o OBJECT SET COLOR([Contract_Project_Maintenance]Location; <>color_editable)
			End if 
			
		End if 
		
		If (PRV_LockedAssignment_b)
			OBJECT SET ENTERABLE:C238(*; "@"; False:C215)
			OBJECT SET RGB COLORS:C628(*; "@"; Col_paletteToRGB(Abs:C99(<>color_not_editable)%256); Col_paletteToRGB(Abs:C99(<>color_not_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "@"; <>color_not_editable)
			OBJECT SET VISIBLE:C603(*; "DE@btn"; False:C215)
		End if 
		PRV_CTRLListBoxes("INSPECT")
		
	: ($FormEvent_L=On Validate:K2:3)
		
	: ($FormEvent_L=On Unload:K2:2)
		
	: ($FormEvent_L=PRV_GETBRIDGEBININFO_L)
		vBridgeNo:=[Bridge MHD NBIS:1]BDEPT:1
		[Contract_Project_Maintenance:100]Location:6:=[Bridge MHD NBIS:1]Item7:65+" / "+[Bridge MHD NBIS:1]Item6A:63
		[Contract_Project_Maintenance:100]Location:6:=Replace string:C233([Contract_Project_Maintenance:100]Location:6; "OTHER"; "")
		[Contract_Project_Maintenance:100]Location:6:=Replace string:C233([Contract_Project_Maintenance:100]Location:6; "WATER"; "")
		[Contract_Project_Maintenance:100]Location:6:=Replace string:C233([Contract_Project_Maintenance:100]Location:6; "HWY  "; "")
		[Contract_Project_Maintenance:100]Location:6:=Replace string:C233([Contract_Project_Maintenance:100]Location:6; "RR   "; "")
		[Contract_Project_Maintenance:100]Location:6:=Replace string:C233([Contract_Project_Maintenance:100]Location:6; "TR   "; "")
		[Contract_Project_Maintenance:100]Location:6:=Replace string:C233([Contract_Project_Maintenance:100]Location:6; "COMB "; "")
		C_LONGINT:C283($DblSpacePos_L)
		$DblSpacePos_L:=Position:C15("  "; [Contract_Project_Maintenance:100]Location:6)
		While ($DblSpacePos_L>0)
			[Contract_Project_Maintenance:100]Location:6:=Replace string:C233([Contract_Project_Maintenance:100]Location:6; "  "; " ")
			$DblSpacePos_L:=Position:C15("  "; [Contract_Project_Maintenance:100]Location:6)
		End while 
		[Contract_Project_Maintenance:100]Location:6:=f_TrimStr([Contract_Project_Maintenance:100]Location:6; True:C214; True:C214)
		[Contract_Project_Maintenance:100]Location:6:=f_CapitalizeTxt([Contract_Project_Maintenance:100]Location:6)
		
		[Contract_Project_Maintenance:100]District:8:=[Bridge MHD NBIS:1]Item2:60
		[Contract_Project_Maintenance:100]Town:7:=[Bridge MHD NBIS:1]Town Name:175
		
End case 