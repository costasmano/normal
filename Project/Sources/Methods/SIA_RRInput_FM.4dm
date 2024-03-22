//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/18/11, 10:44:01
	// ----------------------------------------------------
	// Method: SIA_RRInput_FM
	// Description
	//  ` method for the Rail SIA input form
	// 
	// Parameters
	// $1 : $FormEvent_L
	// ----------------------------------------------------
	
	Mods_2011_01
	// Modified by: costasmanousakis-(Designer)-(8/30/11 08:34:52)
	Mods_2011_08
	//  `Call SIA_RRVariableUtil ("LOAD") on the o load event to properly initialize checkboxes
	// Modified by: Costas Manousakis-(Designer)-(5/21/13 08:03:38)
	Mods_2013_05
	//  `Added display or not of load ratings depending on the bridge type
End if 
C_LONGINT:C283($FormEvent_L)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
Else 
	$FormEvent_L:=Form event code:C388
End if 

Case of 
	: ($FormEvent_L=On Close Detail:K2:24)
		
	: ($FormEvent_L=On Load:K2:1)
		If (Is new record:C668([RAILBridgeInfo:37]))
			[RAILBridgeInfo:37]BIN:1:=[Bridge MHD NBIS:1]BIN:3
		End if 
		If (Read only state:C362([RAILBridgeInfo:37]))
			OBJECT SET ENTERABLE:C238(*; "DE @"; False:C215)
			OBJECT SET ENABLED:C1123(*; "DE @"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET RGB COLORS:C628(*; "DE @"; Col_paletteToRGB(Abs:C99(<>Color_not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE @"; <>Color_not_Editable)
		Else 
			If ([RAILBridgeInfo:37]LineName:6="")
				If ([Bridge MHD NBIS:1]RRBranch:210#"")
					[RAILBridgeInfo:37]LineName:6:=[Bridge MHD NBIS:1]RRBranch:210
					PushChange(2; ->[RAILBridgeInfo:37]LineName:6)
				End if 
			End if 
			
			If ([RAILBridgeInfo:37]MilePt:2=0)
				If ([Bridge MHD NBIS:1]Item11:67>0)
					[RAILBridgeInfo:37]MilePt:2:=Round:C94(0.621371192*[Bridge MHD NBIS:1]Item11:67; 4)
					PushChange(2; ->[RAILBridgeInfo:37]MilePt:2)
				End if 
			End if 
			
		End if 
		ARRAY TEXT:C222(SIA_RRITem54A_atxt; 0)
		ARRAY TEXT:C222(SIA_RRITem55A_atxt; 0)
		APPEND TO ARRAY:C911(SIA_RRITem54A_atxt; "Highway")
		APPEND TO ARRAY:C911(SIA_RRITem54A_atxt; "Rail Road")
		APPEND TO ARRAY:C911(SIA_RRITem54A_atxt; "Neither")
		COPY ARRAY:C226(SIA_RRITem54A_atxt; SIA_RRITem55A_atxt)
		
		//override the forwarding to districts - especially in case of MHD BMS External server
		If (<>Version="5.9.0@")
			C_TEXT:C284(vsForward)  // Command Replaced was o_C_STRING length was 80
			vsForward:=<>Forward
		End if 
		
		SIA_RRVariableUtil("LOAD")
		
		C_TEXT:C284($RecordType_txt)
		$RecordType_txt:=mbta_ReturnBridgeType
		OBJECT SET VISIBLE:C603(*; "@CommutRtg_@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "@TransitRtg_@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "@HWYRtg_@"; False:C215)
		Case of 
			: ($RecordType_txt="Transit@")
				OBJECT SET VISIBLE:C603(*; "@TransitRtg_@"; True:C214)
				
			: ($RecordType_txt="Commuter@")
				OBJECT SET VISIBLE:C603(*; "@CommutRtg_@"; True:C214)
				
			: ($RecordType_txt="Highway@")
				OBJECT SET VISIBLE:C603(*; "@HWYRtg_@"; True:C214)
				
			Else 
				
		End case 
		
	: ($FormEvent_L=On Validate:K2:3)
		
	: ($FormEvent_L=On Unload:K2:2)
		
End case 