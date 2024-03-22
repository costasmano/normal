//%attributes = {"invisible":true}
//Method: FM_NTITunnelInput
//Description
//
// Parameters
// $1 : $FormEvent_L (optional)
// ----------------------------------------------------
If (False:C215)
	
	//----------------------------------------------------
	//User name (OS): administrator
	//Date and time: 10/29/15, 16:31:12
	//----------------------------------------------------
	Mods_2015_10  // 
	//Modified by: administrator (10/29/15 16:31:13)
	// Modified by: Costas Manousakis-(Designer)-(1/30/17 12:52:18)
	Mods_2017_01
	//  `fixed wrong parameter passed to LSS_SetPrevNextButtons
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/21/17 15:07:37)
	// Modified by: Costas Manousakis-(Designer)-(10/5/17 14:29:14)
	Mods_2017_10
	//  `added coding for InspResp field
End if 
C_LONGINT:C283($FormEvent_L)

If (Count parameters:C259=1)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
End if 
Case of 
	: (Form event code:C388=On Load:K2:1) | ($FormEvent_L=On Load:K2:1)
		
		
		OBJECT SET VISIBLE:C603(*; "NTI_TownName_atxt"; False:C215)
		
		InitChangeStack(1)  //[NTI_TunnelInfo]
		InitChangeStack(2)  //[TunnelInfo]
		InitChangeStack(3)  //[NTI_TunnelRatings]
		C_LONGINT:C283($l; $t; $r; $b; $Width_L; $Height_L)
		FORM GET PROPERTIES:C674([NTI_TunnelInfo:181]; "Input"; $Width_L; $Height_L)
		GET WINDOW RECT:C443($l; $t; $r; $b)
		SET WINDOW RECT:C444($l; $t; $l+$Width_L+5; $t+$Height_L+5)
		If (Read only state:C362([NTI_TunnelInfo:181]))
			OBJECT SET VISIBLE:C603(*; "bDelete"; False:C215)
			OBJECT SET VISIBLE:C603(*; "bValidate"; False:C215)
			OBJECT SET ENABLED:C1123(NTI_i8_s_atxt; False:C215)
			OBJECT SET ENABLED:C1123(NTI_i9_L_atxt; False:C215)
			OBJECT SET ENABLED:C1123(NTI_A8_L_atxt; False:C215)
			OBJECT SET ENABLED:C1123(NTI_C1_s_atxt; False:C215)
			OBJECT SET ENABLED:C1123(NTI_C2_s_atxt; False:C215)
			OBJECT SET ENABLED:C1123(NTI_C3_s_atxt; False:C215)
			OBJECT SET ENABLED:C1123(NTI_C4_s_atxt; False:C215)
			OBJECT SET ENABLED:C1123(NTI_C7_L_atxt; False:C215)
			OBJECT SET ENABLED:C1123(NTI_C8_s_atxt; False:C215)
			OBJECT SET ENABLED:C1123(NTI_L1_s_atxt; False:C215)
			OBJECT SET ENABLED:C1123(NTI_L4_s_atxt; False:C215)
			OBJECT SET ENABLED:C1123(NTI_N3_s_atxt; False:C215)
			OBJECT SET ENABLED:C1123(NTI_S2_L_atxt; False:C215)
			OBJECT SET ENABLED:C1123(NTI_S3_L_atxt; False:C215)
			OBJECT SET ENABLED:C1123(NTI_S4_L_atxt; False:C215)
			OBJECT SET ENABLED:C1123(NTI_TownName_atxt; False:C215)
			OBJECT SET ENABLED:C1123(Button3; False:C215)
			OBJECT SET ENABLED:C1123(Button5; False:C215)
			OBJECT SET ENABLED:C1123(aInspRdes_; False:C215)
			
			
		Else 
			OBJECT SET VISIBLE:C603(*; "bDelete"; NTI_CanDelete_B)
			OBJECT SET VISIBLE:C603(*; "bValidate"; NTI_Modify_B)
			OBJECT SET ENABLED:C1123(NTI_i8_s_atxt; True:C214)
			OBJECT SET ENABLED:C1123(NTI_i9_L_atxt; True:C214)
			OBJECT SET ENABLED:C1123(aInspRdes_; True:C214)
			OBJECT SET ENABLED:C1123(NTI_A8_L_atxt; True:C214)
			OBJECT SET ENABLED:C1123(NTI_C1_s_atxt; True:C214)
			OBJECT SET ENABLED:C1123(NTI_C2_s_atxt; True:C214)
			OBJECT SET ENABLED:C1123(NTI_C3_s_atxt; True:C214)
			OBJECT SET ENABLED:C1123(NTI_C4_s_atxt; True:C214)
			OBJECT SET ENABLED:C1123(NTI_C7_L_atxt; True:C214)
			OBJECT SET ENABLED:C1123(NTI_C8_s_atxt; True:C214)
			OBJECT SET ENABLED:C1123(NTI_L1_s_atxt; True:C214)
			OBJECT SET ENABLED:C1123(NTI_L4_s_atxt; True:C214)
			OBJECT SET ENABLED:C1123(NTI_N3_s_atxt; True:C214)
			OBJECT SET ENABLED:C1123(NTI_S2_L_atxt; True:C214)
			OBJECT SET ENABLED:C1123(NTI_S3_L_atxt; True:C214)
			OBJECT SET ENABLED:C1123(NTI_S4_L_atxt; True:C214)
			OBJECT SET ENABLED:C1123(NTI_TownName_atxt; True:C214)
			OBJECT SET ENABLED:C1123(Button3; True:C214)
			OBJECT SET ENABLED:C1123(Button5; True:C214)
			
		End if 
		
		NTI_MovingRecords_B:=False:C215
		OBJECT SET RGB COLORS:C628(*; "NonEntry"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "NonEntry"; <>Color_Not_Editable)
		
		OBJECT SET RGB COLORS:C628(*; "NTI_@"; Col_paletteToRGB(Abs:C99(<>Color_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "NTI_@"; <>Color_editable)
		//set up page 1 drop downs
		
		//Page 1
		NTI_i8_s_atxt:=0
		If ([NTI_TunnelInfo:181]NTI_i8_s:13#"")
			NTI_i8_s_atxt:=Find in array:C230(NTI_i8_s_atxt; [NTI_TunnelInfo:181]NTI_i8_s:13+"@")
		End if 
		If (NTI_i8_s_atxt<1)
			NTI_i8_s_atxt:=0
			NTI_i8_s_atxt{0}:="Select Route Direction"
		End if 
		
		NTI_i9_L_atxt:=0
		NTI_i9_L_atxt:=Find in array:C230(NTI_i9_L_atxt; String:C10([NTI_TunnelInfo:181]NTI_i9_L:14)+"@")
		
		If (NTI_i9_L_atxt<1)
			NTI_i9_L_atxt:=0
			NTI_i9_L_atxt{0}:="Select Route Type"
		End if 
		
		//Page 2
		NTI_A8_L_atxt:=Find in array:C230(NTI_A8_L_atxt; String:C10([NTI_TunnelInfo:181]NTI_A8_L:31)+"@")
		If (NTI_A8_L_atxt<1)
			NTI_A8_L_atxt{0}:="Select Service in Tunnel"
			NTI_A8_L_atxt:=0
		End if 
		
		//page 3
		NTI_C1_s_atxt:=0
		If ([NTI_TunnelInfo:181]NTI_C1_s:32="")
		Else 
			NTI_C1_s_atxt:=Find in array:C230(NTI_C1_s_atxt; [NTI_TunnelInfo:181]NTI_C1_s:32+"@")
		End if 
		If (NTI_C1_s_atxt<1)
			NTI_C1_s_atxt:=0
			NTI_C1_s_atxt{0}:="Select an Owner"
		End if 
		
		NTI_C2_s_atxt:=0
		If ([NTI_TunnelInfo:181]NTI_C2_s:33="")
		Else 
			NTI_C2_s_atxt:=Find in array:C230(NTI_C2_s_atxt; [NTI_TunnelInfo:181]NTI_C2_s:33+"@")
		End if 
		If (NTI_C2_s_atxt<1)
			NTI_C2_s_atxt:=0
			NTI_C2_s_atxt{0}:="Select an Operator"
		End if 
		
		NTI_C3_s_atxt:=0
		If ([NTI_TunnelInfo:181]NTI_C3_s:34="")
		Else 
			NTI_C3_s_atxt:=Find in array:C230(NTI_C3_s_atxt; [NTI_TunnelInfo:181]NTI_C3_s:34+"@")
		End if 
		If (NTI_C3_s_atxt<1)
			NTI_C3_s_atxt:=0
			NTI_C3_s_atxt{0}:="Select Direction of Traffic"
		End if 
		
		NTI_C4_s_atxt:=0
		If ([NTI_TunnelInfo:181]NTI_C4_s:35="")
		Else 
			NTI_C4_s_atxt:=Find in array:C230(NTI_C4_s_atxt; [NTI_TunnelInfo:181]NTI_C4_s:35+"@")
		End if 
		If (NTI_C4_s_atxt<1)
			NTI_C4_s_atxt:=0
			NTI_C4_s_atxt{0}:="Select Toll"
		End if 
		
		NTI_C7_L_atxt:=0
		NTI_C7_L_atxt:=Find in array:C230(NTI_C7_L_atxt; String:C10([NTI_TunnelInfo:181]NTI_C7_L:38)+"@")
		If (NTI_C7_L_atxt<1)
			NTI_C7_L_atxt:=0
			NTI_C7_L_atxt{0}:="Select Functional Classification"
		End if 
		
		NTI_C8_s_atxt:=0
		If ([NTI_TunnelInfo:181]NTI_C8_s:39="")
		Else 
			NTI_C8_s_atxt:=Find in array:C230(NTI_C8_s_atxt; [NTI_TunnelInfo:181]NTI_C8_s:39+"@")
		End if 
		If (NTI_C8_s_atxt<1)
			NTI_C8_s_atxt:=0
			NTI_C8_s_atxt{0}:="Select Urban Code"
		End if 
		
		//Page 6
		
		NTI_L1_s_atxt:=0
		If ([NTI_TunnelInfo:181]NTI_L1_s:59="")
		Else 
			NTI_L1_s_atxt:=Find in array:C230(NTI_L1_s_atxt; [NTI_TunnelInfo:181]NTI_L1_s:59+"@")
		End if 
		If (NTI_L1_s_atxt<1)
			NTI_L1_s_atxt:=0
			NTI_L1_s_atxt{0}:="Select Load Rating Method"
		End if 
		
		NTI_L4_s_atxt:=0
		If ([NTI_TunnelInfo:181]NTI_L4_s:62="")
		Else 
			NTI_L4_s_atxt:=Find in array:C230(NTI_L4_s_atxt; [NTI_TunnelInfo:181]NTI_L4_s:62+"@")
		End if 
		If (NTI_L4_s_atxt<1)
			NTI_L4_s_atxt:=0
			NTI_L4_s_atxt{0}:="Select Tunnel Posting Status"
		End if 
		
		
		//Page 7
		
		NTI_S2_L_atxt:=0
		NTI_S2_L_atxt:=Find in array:C230(NTI_S2_L_atxt; String:C10([NTI_TunnelInfo:181]NTI_S2_L:49)+"@")
		If (NTI_S2_L_atxt<1)
			NTI_S2_L_atxt:=0
			NTI_S2_L_atxt{0}:="Select Tunnel Shape"
		End if 
		
		NTI_S3_L_atxt:=0
		NTI_S3_L_atxt:=Find in array:C230(NTI_S3_L_atxt; String:C10([NTI_TunnelInfo:181]NTI_S3_L:50)+"@")
		If (NTI_S3_L_atxt<1)
			NTI_S3_L_atxt:=0
			NTI_S3_L_atxt{0}:="Select Portal Shape"
		End if 
		
		NTI_S4_L_atxt:=0
		NTI_S4_L_atxt:=Find in array:C230(NTI_S4_L_atxt; String:C10([NTI_TunnelInfo:181]NTI_S4_L:51)+"@")
		If (NTI_S4_L_atxt<1)
			NTI_S4_L_atxt:=0
			NTI_S4_L_atxt{0}:="Select Ground Condition"
		End if 
		
		
		//Page 8
		NTI_N3_s_atxt:=0
		If ([NTI_TunnelInfo:181]NTI_N3_s:47="")
		Else 
			NTI_N3_s_atxt:=Find in array:C230(NTI_N3_s_atxt; [NTI_TunnelInfo:181]NTI_N3_s:47+"@")
		End if 
		If (NTI_N3_s_atxt<1)
			NTI_N3_s_atxt:=0
			NTI_N3_s_atxt{0}:="Select Under Navigable Waterway"
		End if 
		
		LSS_SetPrevNextButtons(NTI_TunnelRow_L; Records in selection:C76([NTI_TunnelInfo:181]))
		If (NTI_CurrentPage_L>0)
			If (NTI_CurrentPage_L=9)
				NTI_SetUpAssignBINs("")
			End if 
			FORM GOTO PAGE:C247(NTI_CurrentPage_L)
			NTI_Tabs:=NTI_CurrentPage_L
			
		Else 
			NTI_CurrentPage_L:=1
			FORM GOTO PAGE:C247(NTI_CurrentPage_L)
			NTI_Tabs:=NTI_CurrentPage_L
		End if 
		C_LONGINT:C283($Loc_L)
		Repeat 
			$Loc_L:=Find in array:C230(AvailableBins_LB; True:C214)
			If ($Loc_L>0)
				AvailableBins_LB{$Loc_L}:=False:C215
			End if 
		Until ($Loc_L<1)
		Repeat 
			$Loc_L:=Find in array:C230(SelectedBins_LB; True:C214)
			If ($Loc_L>0)
				SelectedBins_LB{$Loc_L}:=False:C215
			End if 
		Until ($Loc_L<1)
		OBJECT SET RGB COLORS:C628(*; "AssignedColor"; 16716302; 0)
		InDoubleClick_B:=False:C215
End case 
//End FM_NTITunnelInput