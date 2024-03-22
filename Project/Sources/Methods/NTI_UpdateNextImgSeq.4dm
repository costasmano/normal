//%attributes = {"invisible":true}
//Method: NTI_UpdateNextImgSeq
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/16/16, 12:02:09
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
End if 
//
C_LONGINT:C283(vNextPhotoSeq; vNextSketchSeq; vNextChartSeq)  //Command Replaced was o_C_INTEGER
SET QUERY DESTINATION:C396(Into variable:K19:4; vNextPhotoSeq)
QUERY SELECTION:C341([TIN_Insp_Images:186]; [TIN_Insp_Images:186]ImageType:5=BMS Photo)
SET QUERY DESTINATION:C396(Into current selection:K19:1)
SET QUERY DESTINATION:C396(Into variable:K19:4; vNextSketchSeq)
QUERY SELECTION:C341([TIN_Insp_Images:186]; [TIN_Insp_Images:186]ImageType:5=BMS Sketch)
SET QUERY DESTINATION:C396(Into current selection:K19:1)
SET QUERY DESTINATION:C396(Into variable:K19:4; vNextChartSeq)
QUERY SELECTION:C341([TIN_Insp_Images:186]; [TIN_Insp_Images:186]ImageType:5=BMS Chart)
SET QUERY DESTINATION:C396(Into current selection:K19:1)
vNextPhotoSeq:=vNextPhotoSeq+1
vNextSketchSeq:=vNextSketchSeq+1
vNextChartSeq:=vNextChartSeq+1

//End NTI_UpdateNextImgSeq