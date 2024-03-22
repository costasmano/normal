//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// PRJ_SetEntry
	// User name (OS): cjmiller
	// Date and time: 03/03/06, 10:38:03
	// ----------------------------------------------------
	// Description
	// This method will set background color and entry based upon if record came from
	//tish sql db
	//
	// Parameters
	//$1 boolean true if non eneterable false if enterable
	// ----------------------------------------------------
	Mods_2006_CJMv2
	// Modified by: costasmanousakis-(Designer)-(11/12/08 09:46:45)
	Mods_2008_CM_5404
	//  `use object wildcard names
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
C_BOOLEAN:C305($Enterable_b; $1)
C_LONGINT:C283($Color_l)
$Enterable_b:=$1
If ($Enterable_b)
	$Color_l:=<>PRJ_Color_Editable
Else 
	$Color_l:=<>PRJ_Color_Not_editable
End if 

OBJECT SET ENTERABLE:C238([PRJ_ProjectFile:117]PF_ScheduledAdvertising_d:5; $Enterable_b)
OBJECT SET RGB COLORS:C628([PRJ_ProjectFile:117]PF_ScheduledAdvertising_d:5; Col_paletteToRGB(Abs:C99($Color_l)%256); Col_paletteToRGB(Abs:C99($Color_l)\256))  // **Replaced o OBJECT SET COLOR([PRJ_ProjectFile]PF_ScheduledAdvertising_d; $Color_l)

OBJECT SET ENTERABLE:C238([PRJ_ProjectFile:117]PF_CostAd_r:9; $Enterable_b)
OBJECT SET RGB COLORS:C628([PRJ_ProjectFile:117]PF_CostAd_r:9; Col_paletteToRGB(Abs:C99($Color_l)%256); Col_paletteToRGB(Abs:C99($Color_l)\256))  // **Replaced o OBJECT SET COLOR([PRJ_ProjectFile]PF_CostAd_r; $Color_l)

OBJECT SET ENTERABLE:C238([PRJ_ProjectFile:117]PF_EstTotalCost_r:10; $Enterable_b)
OBJECT SET RGB COLORS:C628([PRJ_ProjectFile:117]PF_EstTotalCost_r:10; Col_paletteToRGB(Abs:C99($Color_l)%256); Col_paletteToRGB(Abs:C99($Color_l)\256))  // **Replaced o OBJECT SET COLOR([PRJ_ProjectFile]PF_EstTotalCost_r; $Color_l)

OBJECT SET ENTERABLE:C238([PRJ_ProjectFile:117]PF_EWO_s:4; $Enterable_b)
OBJECT SET RGB COLORS:C628([PRJ_ProjectFile:117]PF_EWO_s:4; Col_paletteToRGB(Abs:C99($Color_l)%256); Col_paletteToRGB(Abs:C99($Color_l)\256))  // **Replaced o OBJECT SET COLOR([PRJ_ProjectFile]PF_EWO_s; $Color_l)

OBJECT SET ENTERABLE:C238([PRJ_ProjectFile:117]PF_FileID_l:1; $Enterable_b)
OBJECT SET RGB COLORS:C628([PRJ_ProjectFile:117]PF_FileID_l:1; Col_paletteToRGB(Abs:C99($Color_l)%256); Col_paletteToRGB(Abs:C99($Color_l)\256))  // **Replaced o OBJECT SET COLOR([PRJ_ProjectFile]PF_FileID_l; $Color_l)

OBJECT SET ENTERABLE:C238([PRJ_ProjectFile:117]PF_FileNumber_l:3; $Enterable_b)
OBJECT SET RGB COLORS:C628([PRJ_ProjectFile:117]PF_FileNumber_l:3; Col_paletteToRGB(Abs:C99($Color_l)%256); Col_paletteToRGB(Abs:C99($Color_l)\256))  // **Replaced o OBJECT SET COLOR([PRJ_ProjectFile]PF_FileNumber_l; $Color_l)

OBJECT SET ENTERABLE:C238([PRJ_ProjectFile:117]PF_InitialBidEstimate_r:8; $Enterable_b)
OBJECT SET RGB COLORS:C628([PRJ_ProjectFile:117]PF_InitialBidEstimate_r:8; Col_paletteToRGB(Abs:C99($Color_l)%256); Col_paletteToRGB(Abs:C99($Color_l)\256))  // **Replaced o OBJECT SET COLOR([PRJ_ProjectFile]PF_InitialBidEstimate_r; $Color_l)

OBJECT SET ENTERABLE:C238([PRJ_ProjectFile:117]PF_ProjectExpediter_s:6; $Enterable_b)
OBJECT SET RGB COLORS:C628([PRJ_ProjectFile:117]PF_ProjectExpediter_s:6; Col_paletteToRGB(Abs:C99($Color_l)%256); Col_paletteToRGB(Abs:C99($Color_l)\256))  // **Replaced o OBJECT SET COLOR([PRJ_ProjectFile]PF_ProjectExpediter_s; $Color_l)

OBJECT SET ENTERABLE:C238([PRJ_ProjectFile:117]PF_TIP_s:7; $Enterable_b)
OBJECT SET RGB COLORS:C628([PRJ_ProjectFile:117]PF_TIP_s:7; Col_paletteToRGB(Abs:C99($Color_l)%256); Col_paletteToRGB(Abs:C99($Color_l)\256))  // **Replaced o OBJECT SET COLOR([PRJ_ProjectFile]PF_TIP_s; $Color_l)

OBJECT SET ENTERABLE:C238([PRJ_ProjectFile:117]PF_OfficeEstimate_r:13; $Enterable_b)
OBJECT SET RGB COLORS:C628([PRJ_ProjectFile:117]PF_OfficeEstimate_r:13; Col_paletteToRGB(Abs:C99($Color_l)%256); Col_paletteToRGB(Abs:C99($Color_l)\256))  // **Replaced o OBJECT SET COLOR([PRJ_ProjectFile]PF_OfficeEstimate_r; $Color_l)
OBJECT SET ENTERABLE:C238([PRJ_ProjectFile:117]PF_Advertised_d:14; $Enterable_b)
OBJECT SET RGB COLORS:C628([PRJ_ProjectFile:117]PF_Advertised_d:14; Col_paletteToRGB(Abs:C99($Color_l)%256); Col_paletteToRGB(Abs:C99($Color_l)\256))  // **Replaced o OBJECT SET COLOR([PRJ_ProjectFile]PF_Advertised_d; $Color_l)
OBJECT SET ENTERABLE:C238([PRJ_ProjectFile:117]PF_BidOpened_d:12; $Enterable_b)
OBJECT SET RGB COLORS:C628([PRJ_ProjectFile:117]PF_BidOpened_d:12; Col_paletteToRGB(Abs:C99($Color_l)%256); Col_paletteToRGB(Abs:C99($Color_l)\256))  // **Replaced o OBJECT SET COLOR([PRJ_ProjectFile]PF_BidOpened_d; $Color_l)

OBJECT SET ENTERABLE:C238(*; "PF_@"; $Enterable_b)
OBJECT SET RGB COLORS:C628(*; "PF_@"; Col_paletteToRGB(Abs:C99($Color_l)%256); Col_paletteToRGB(Abs:C99($Color_l)\256))  // **Replaced o OBJECT SET COLOR(*; "PF_@"; $Color_l)

//End PRJ_SetEntry