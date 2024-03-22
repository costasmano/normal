//%attributes = {"invisible":true}
//Method: LSS_MoveImageRows
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 01/23/20, 12:37:42
	// ----------------------------------------------------
	//Created : 
	Mods_2020_01_bug
	//Modfied way lss pictures are resequenced to follow model on tin images 
	//Modified by: CJ (1/23/20 16:35:21
	
End if 
//
C_TEXT:C284($1)

C_BOOLEAN:C305(NTI_ImageSortNeeded_b)

If (Records in set:C195("ImgListBoxSet")>0)
	//all must be same type
	//check if we have same types selected
	ARRAY LONGINT:C221($SelImgIDs_aL; 0)
	ARRAY TEXT:C222($SelimgTypes_atxt; 0)
	C_LONGINT:C283($SelectRow_L; $dropRow_L; $numGrps_L; $lastRow_L; $FirstRowOff_L)
	C_BOOLEAN:C305($FoundGroup_b)
	$SelectRow_L:=0
	FIRST RECORD:C50([LSS_Photos:166])
	$numGrps_L:=0
	$FoundGroup_b:=False:C215
	$FirstRowOff_L:=0
	While (Not:C34(End selection:C36([LSS_Photos:166])))
		If (Is in set:C273("ImgListBoxSet"))
			//start counting groupings
			If (Not:C34($FoundGroup_b))
				$FoundGroup_b:=True:C214
				$numGrps_L:=$numGrps_L+1
			End if 
			If ($SelectRow_L=0)
				$SelectRow_L:=Selected record number:C246([LSS_Photos:166])  //mark the start of selected ones
			End if 
			$lastRow_L:=Selected record number:C246([LSS_Photos:166])  //mark the end row of selected ones
			APPEND TO ARRAY:C911($SelImgIDs_aL; Record number:C243([LSS_Photos:166]))
			APPEND TO ARRAY:C911($SelimgTypes_atxt; [LSS_Photos:166]LSS_PhotoType_s:3)
		Else 
			If ($FoundGroup_b & ($FirstRowOff_L=0))
				$FirstRowOff_L:=Selected record number:C246([LSS_Photos:166])  //mark the first unselected row after or within the selected ones
			End if 
			$FoundGroup_b:=False:C215
		End if 
		NEXT RECORD:C51([LSS_Photos:166])
	End while 
	C_BOOLEAN:C305($SameTypes_b)
	$SameTypes_b:=True:C214
	C_LONGINT:C283($loop_L)
	For ($loop_L; 2; Size of array:C274($SelimgTypes_atxt))
		If ($SelimgTypes_atxt{$loop_L}#$SelimgTypes_atxt{$loop_L-1})
			$SameTypes_b:=False:C215
		End if 
	End for 
	
	If ($SameTypes_b)
		
		ARRAY LONGINT:C221($ImgIDs_aL; 0)
		ARRAY TEXT:C222($imgTypes_atxt; 0)
		SELECTION TO ARRAY:C260([LSS_Photos:166]; $ImgIDs_aL; [LSS_Photos:166]LSS_PhotoType_s:3; $imgTypes_atxt)
		C_BOOLEAN:C305($Move_b)
		$Move_b:=False:C215
		Case of 
			: ($1="UP")
				//find the first of our type
				For ($loop_L; Size of array:C274($imgTypes_atxt); 1; -1)
					If ($SelimgTypes_atxt{1}=$imgTypes_atxt{$loop_L})
						$dropRow_L:=$loop_L
					End if 
					
				End for 
				If ($dropRow_L=$SelectRow_L)
					//already at top - no move!
					ALERT:C41("Cannot Move Selected Rows further up!")
				Else 
					$dropRow_L:=$SelectRow_L-2
					$Move_b:=True:C214
				End if 
				
				
			: ($1="DOWN")
				//find last row of type
				For ($loop_L; 1; Size of array:C274($imgTypes_atxt))
					If ($SelimgTypes_atxt{1}=$imgTypes_atxt{$loop_L})
						$dropRow_L:=$loop_L
					End if 
				End for 
				//if the last selected row is the last row & only one group in selection - cannot move!
				
				If (($dropRow_L=$lastRow_L) & ($numGrps_L=1))
					ALERT:C41("Cannot Move Selected Rows further down!")
				Else 
					$dropRow_L:=$FirstRowOff_L
					$Move_b:=True:C214
				End if 
				
		End case 
		If ($Move_b)
			ARRAY LONGINT:C221($newIds_aL; 0)
			
			For ($loop_L; 1; $dropRow_L)
				If (Find in array:C230($SelImgIDs_aL; $ImgIDs_aL{$loop_L})<=0)
					APPEND TO ARRAY:C911($newIds_aL; $ImgIDs_aL{$loop_L})
				End if 
			End for 
			For ($loop_L; 1; Size of array:C274($SelImgIDs_aL))
				APPEND TO ARRAY:C911($newIds_aL; $SelImgIDs_aL{$loop_L})
			End for 
			For ($loop_L; ($dropRow_L+1); Size of array:C274($ImgIDs_aL))
				If (Find in array:C230($SelImgIDs_aL; $ImgIDs_aL{$loop_L})<=0)
					APPEND TO ARRAY:C911($newIds_aL; $ImgIDs_aL{$loop_L})
				End if 
			End for 
			CREATE SELECTION FROM ARRAY:C640([LSS_Photos:166]; $newIds_aL)
			FIRST RECORD:C50([LSS_Photos:166])
			While (Not:C34(End selection:C36([LSS_Photos:166])))
				If (Find in array:C230($SelImgIDs_aL; Record number:C243([LSS_Photos:166]))>0)
					ADD TO SET:C119([LSS_Photos:166]; "ImgListBoxSet")
				End if 
				NEXT RECORD:C51([LSS_Photos:166])
			End while 
			
			ARRAY LONGINT:C221($newIds_aL; 0)
			REDRAW:C174(PHotos_LB)
			REDRAW WINDOW:C456
			OBJECT SET VISIBLE:C603(*; "SequenceNumberUpdate"; True:C214)
			LSS_PhotoUpdateSeq_b:=True:C214
		End if 
		
		
		OBJECT SET ENABLED:C1123(*; "SequenceNumberUpdate_1"; True:C214)
	Else 
		ALERT:C41("Multiple Image types selected to be moved! Can only work with one type at a time (Sketch, or Chart, or Photo)")
	End if 
	
Else 
	ALERT:C41("No Image records selected!")
End if 
//End LSS_MoveImageRows