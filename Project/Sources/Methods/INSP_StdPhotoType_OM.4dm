//%attributes = {"invisible":true}
// Method: INSP_StdPhotoType_OM
// Description
// Handle the Picture Type dropdown in the
// [Standard Photos];"Standard Photos" form and form method
// Parameters
// $1 : $FormEvent (Optional)
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/10/07, 11:10:04
	// ----------------------------------------------------
	C_LONGINT:C283(INSP_StdPhotoType_OM; $1)
	
	Mods_2007_CM_5401
	// Modified by: Costas Manousakis-(Designer)-(9/20/21 17:48:48)
	Mods_2021_09
	//  `Added optional parameter formevent
	
	
End if 

C_LONGINT:C283($formEvent)

If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$formEvent:=$1
Else 
	$formEvent:=Form event code:C388
End if 

POPUPMENUC(->aPictType; ->aPictCode; ->[Standard Photos:36]PictType:5; $formEvent)
If ([Standard Photos:36]PictType:5=BMS Photo)
	OBJECT SET FORMAT:C236(*; "DE Portrait"; "2/Page;1/Page")
Else 
	OBJECT SET FORMAT:C236(*; "DE Portrait"; "Portrait;Landscape")
End if 

If ($formEvent=On Clicked:K2:4)
	PushChange(2; ->[Standard Photos:36]PictType:5)
	
	If (Is new record:C668([Standard Photos:36]))
		Case of 
			: ([Standard Photos:36]PictType:5=BMS Photo)
				[Standard Photos:36]SeqNum:6:=vNextPhotoSeq
			: ([Standard Photos:36]PictType:5=BMS Sketch)
				[Standard Photos:36]SeqNum:6:=vNextSketchSeq
			: ([Standard Photos:36]PictType:5=BMS Chart)
				[Standard Photos:36]SeqNum:6:=vNextChartSeq
				
		End case 
		PushChange(2; ->[Standard Photos:36]SeqNum:6)
	End if 
End if 