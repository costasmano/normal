//%attributes = {"invisible":true}
//G_CountInspImagePgs
//Count pages of Inspection Images.
//Also build arrays with page numbers for each Image.
If (False:C215)
	//Sep-2003 : Created
	// Modified by: Costas Manousakis-(Designer)-(4/20/21 16:15:12)
	Mods_2021_WP
	//  `added a query for InspID in preparation for having more than sketch,chart, photo image types
End if 

C_LONGINT:C283(viNumCmtsPgs; viCmtsPgStart; viSkPgStart; viChPgStart; viPhPgStart)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(viNumSkPgs; viNumChPgs; viNumPhPgs)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($i; $viNumPhotos)  //Command Replaced was o_C_INTEGER
ARRAY INTEGER:C220($aiSeqNos; 0)
ARRAY BOOLEAN:C223($abPhotoperPage; 0)

COPY NAMED SELECTION:C331([Standard Photos:36]; "InspectImagesCount")

viSkPgStart:=viCmtsPgStart+viNumCmtsPgs

//SET QUERY DESTINATION(Into variable ;viNumSkPgs)

QUERY:C277([Standard Photos:36]; [Standard Photos:36]InspID:1=[Inspections:27]InspID:2)
QUERY SELECTION:C341([Standard Photos:36]; [Standard Photos:36]PictType:5=BMS Sketch)
viNumSkPgs:=Records in selection:C76([Standard Photos:36])
ARRAY INTEGER:C220(aiSketchPage; viNumSkPgs)
ARRAY INTEGER:C220(aiSketchSeqNo; viNumSkPgs)
viChPgStart:=viSkPgStart+viNumSkPgs
If (viNumSkPgs>0)
	SELECTION TO ARRAY:C260([Standard Photos:36]SeqNum:6; aiSketchSeqNo)
	SORT ARRAY:C229(aiSketchSeqNo)
	For ($i; 1; viNumSkPgs)
		aiSketchPage{$i}:=viSkPgStart+($i-1)
	End for 
End if 

USE NAMED SELECTION:C332("InspectImagesCount")
//SET QUERY DESTINATION(Into variable ;viNumChPgs)
QUERY SELECTION:C341([Standard Photos:36]; [Standard Photos:36]PictType:5=BMS Chart)
viNumChPgs:=Records in selection:C76([Standard Photos:36])
ARRAY INTEGER:C220(aiChartPage; viNumChPgs)
ARRAY INTEGER:C220(aiChartSeqNo; viNumChPgs)
viPhPgStart:=viChPgStart+viNumChPgs
If (viNumChPgs>0)
	SELECTION TO ARRAY:C260([Standard Photos:36]SeqNum:6; aiChartSeqNo)
	SORT ARRAY:C229(aiChartSeqNo)
	For ($i; 1; viNumChPgs)
		aiChartPage{$i}:=viChPgStart+($i-1)
	End for 
End if 

USE NAMED SELECTION:C332("InspectImagesCount")
//SET QUERY DESTINATION(Into current selection )
QUERY SELECTION:C341([Standard Photos:36]; [Standard Photos:36]PictType:5=BMS Photo)
$viNumPhotos:=Records in selection:C76([Standard Photos:36])
ARRAY INTEGER:C220(aiPhotoPage; $viNumPhotos)
ARRAY INTEGER:C220(aiPhotoSeqNo; $viNumPhotos)
If ($viNumPhotos>0)
	SELECTION TO ARRAY:C260([Standard Photos:36]SeqNum:6; aiPhotoSeqNo; [Standard Photos:36]Portrait:4; $abPhotoPerPage)
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