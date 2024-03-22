//%attributes = {"invisible":true}
//Method: NTI_ImageType_OM
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/03/16, 12:27:12
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
End if 
//
POPUPMENUC(->aPictType; ->aPictCode; ->[TIN_Insp_Images:186]ImageType:5)
If ([TIN_Insp_Images:186]ImageType:5=BMS Photo)
	OBJECT SET FORMAT:C236(*; "DE Portrait"; "2/Page;1/Page")
Else 
	OBJECT SET FORMAT:C236(*; "DE Portrait"; "Portrait;Landscape")
End if 

If (Form event code:C388=On Clicked:K2:4)
	
	If (Is new record:C668([TIN_Insp_Images:186]))
		Case of 
			: ([TIN_Insp_Images:186]ImageType:5=BMS Photo)
				[TIN_Insp_Images:186]SequenceNum:6:=vNextPhotoSeq
			: ([TIN_Insp_Images:186]ImageType:5=BMS Sketch)
				[TIN_Insp_Images:186]SequenceNum:6:=vNextSketchSeq
			: ([TIN_Insp_Images:186]ImageType:5=BMS Chart)
				[TIN_Insp_Images:186]SequenceNum:6:=vNextChartSeq
				
		End case 
	End if 
End if 
//End NTI_ImageType_OM