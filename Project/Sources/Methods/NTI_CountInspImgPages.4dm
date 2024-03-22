//%attributes = {"invisible":true}
//Method: NTI_CountInspImgPages
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/06/16, 12:49:33
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
End if 
//
C_LONGINT:C283(viNumCmtsPgs; viCmtsPgStart; viSkPgStart; viChPgStart; viPhPgStart)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(viNumSkPgs; viNumChPgs; viNumPhPgs)  //Command Replaced was o_C_INTEGER

C_LONGINT:C283($i; $viNumPhotos)  //Command Replaced was o_C_INTEGER
ARRAY INTEGER:C220($aiSeqNos; 0)
ARRAY BOOLEAN:C223($abPhotoperPage; 0)

COPY NAMED SELECTION:C331([TIN_Insp_Images:186]; "InspectImagesCount")

viSkPgStart:=viCmtsPgStart+viNumCmtsPgs

//SET QUERY DESTINATION(Into variable ;viNumSkPgs)
QUERY SELECTION:C341([TIN_Insp_Images:186]; [TIN_Insp_Images:186]ImageType:5=BMS Sketch)
viNumSkPgs:=Records in selection:C76([TIN_Insp_Images:186])
ARRAY INTEGER:C220(aiSketchPage; viNumSkPgs)
ARRAY INTEGER:C220(aiSketchSeqNo; viNumSkPgs)
viChPgStart:=viSkPgStart+viNumSkPgs
If (viNumSkPgs>0)
	SELECTION TO ARRAY:C260([TIN_Insp_Images:186]SequenceNum:6; aiSketchSeqNo)
	SORT ARRAY:C229(aiSketchSeqNo)
	For ($i; 1; viNumSkPgs)
		aiSketchPage{$i}:=viSkPgStart+($i-1)
	End for 
End if 

USE NAMED SELECTION:C332("InspectImagesCount")
//SET QUERY DESTINATION(Into variable ;viNumChPgs)
QUERY SELECTION:C341([TIN_Insp_Images:186]; [TIN_Insp_Images:186]ImageType:5=BMS Chart)
viNumChPgs:=Records in selection:C76([TIN_Insp_Images:186])
ARRAY INTEGER:C220(aiChartPage; viNumChPgs)
ARRAY INTEGER:C220(aiChartSeqNo; viNumChPgs)
viPhPgStart:=viChPgStart+viNumChPgs
If (viNumChPgs>0)
	SELECTION TO ARRAY:C260([TIN_Insp_Images:186]SequenceNum:6; aiChartSeqNo)
	SORT ARRAY:C229(aiChartSeqNo)
	For ($i; 1; viNumChPgs)
		aiChartPage{$i}:=viChPgStart+($i-1)
	End for 
End if 

USE NAMED SELECTION:C332("InspectImagesCount")
//SET QUERY DESTINATION(Into current selection )
QUERY SELECTION:C341([TIN_Insp_Images:186]; [TIN_Insp_Images:186]ImageType:5=BMS Photo)
$viNumPhotos:=Records in selection:C76([TIN_Insp_Images:186])
ARRAY INTEGER:C220(aiPhotoPage; $viNumPhotos)
ARRAY INTEGER:C220(aiPhotoSeqNo; $viNumPhotos)
If ($viNumPhotos>0)
	SELECTION TO ARRAY:C260([TIN_Insp_Images:186]SequenceNum:6; aiPhotoSeqNo; [TIN_Insp_Images:186]Portrait:7; $abPhotoPerPage)
	SORT ARRAY:C229(aiPhotoSeqNo; $abPhotoPerPage)
	ARRAY INTEGER:C220(aiPhotoPage; $viNumPhotos)
	viNumPhPgs:=0
	For ($i; 1; $viNumPhotos)
		aiPhotoPage{$i}:=viPhPgStart+viNumPhPgs
		viNumPhPgs:=viNumPhPgs+1
		If (($i<$viNumPhotos) & ($abPhotoPerPage{$i}))
			If ($abPhotoPerPage{($i+1)})
				$i:=$i+1
				aiPhotoPage{$i}:=aiPhotoPage{($i-1)}
			End if 
		End if 
	End for 
Else 
	viNumPhPgs:=0
End if 

USE NAMED SELECTION:C332("InspectImagesCount")
CLEAR NAMED SELECTION:C333("InspectImagesCount")
//End NTI_CountInspImgPages