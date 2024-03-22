//%attributes = {"invisible":true}
//Method: INSP_MoveImages
//Description
// move images up or down in the list
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/26/19, 15:42:17
	// ----------------------------------------------------
	//Created : 
	Mods_2019_04
	
	C_TEXT:C284(INSP_MoveImages; $1)
	
	// Modified by: Costas Manousakis-(Designer)-(4/30/20 17:55:19)
	Mods_2020_04
	//  `added setting of LSS_PhotoUpdateSeq_b for LSS
	// Modified by: Costas Manousakis-(Designer)-(5/4/20 15:13:48)
	Mods_2020_05
	//  `added short message about moving...
End if 
//

C_TEXT:C284($1)

C_TEXT:C284($LB_Name)
$LB_Name:="Photos_LB"

C_POINTER:C301($PicTypeFld_ptr; $ImagesTable_ptr)
$ImagesTable_ptr:=Current form table:C627
Case of 
	: (Table:C252($ImagesTable_ptr)=Table:C252(->[TIN_Inspections:184]))
		$ImagesTable_ptr:=->[TIN_Insp_Images:186]
		$PicTypeFld_ptr:=->[TIN_Insp_Images:186]ImageType:5
		
	: (Table:C252($ImagesTable_ptr)=Table:C252(->[TIN_Insp_Images:186]))
		$PicTypeFld_ptr:=->[TIN_Insp_Images:186]ImageType:5
		
	: (Table:C252($ImagesTable_ptr)=Table:C252(->[Standard Photos:36]))
		$PicTypeFld_ptr:=->[Standard Photos:36]PictType:5
		
	: (Table:C252($ImagesTable_ptr)=Table:C252(->[LSS_Photos:166]))
		$PicTypeFld_ptr:=->[LSS_Photos:166]LSS_PhotoType_s:3
		
End case 

C_BOOLEAN:C305(NTI_ImageSortNeeded_b; LSS_PhotoUpdateSeq_b)

If (Records in set:C195("ImgListBoxSet")>0)
	
	SHORT_MESSAGE("Moving image...")
	//all must be same type
	//check if we have same types selected
	
	ARRAY LONGINT:C221($SelImgIDs_aL; 0)
	ARRAY TEXT:C222($SelimgTypes_atxt; 0)
	C_LONGINT:C283($SelectRow_L; $dropRow_L; $numGrps_L; $lastRow_L; $FirstRowOff_L)
	C_BOOLEAN:C305($FoundGroup_b)
	$SelectRow_L:=0
	FIRST RECORD:C50($ImagesTable_ptr->)
	$numGrps_L:=0
	$FoundGroup_b:=False:C215
	$FirstRowOff_L:=0
	While (Not:C34(End selection:C36($ImagesTable_ptr->)))
		If (Is in set:C273("ImgListBoxSet"))
			//start counting groupings
			If (Not:C34($FoundGroup_b))
				$FoundGroup_b:=True:C214
				$numGrps_L:=$numGrps_L+1
			End if 
			If ($SelectRow_L=0)
				$SelectRow_L:=Selected record number:C246($ImagesTable_ptr->)  //mark the start of selected ones
			End if 
			$lastRow_L:=Selected record number:C246($ImagesTable_ptr->)  //mark the end row of selected ones
			APPEND TO ARRAY:C911($SelImgIDs_aL; Record number:C243($ImagesTable_ptr->))
			APPEND TO ARRAY:C911($SelimgTypes_atxt; $PicTypeFld_ptr->)
		Else 
			If ($FoundGroup_b & ($FirstRowOff_L=0))
				$FirstRowOff_L:=Selected record number:C246($ImagesTable_ptr->)  //mark the first unselected row after or within the selected ones
			End if 
			$FoundGroup_b:=False:C215
		End if 
		NEXT RECORD:C51($ImagesTable_ptr->)
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
		SELECTION TO ARRAY:C260($ImagesTable_ptr->; $ImgIDs_aL; $PicTypeFld_ptr->; $imgTypes_atxt)
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
			CREATE SELECTION FROM ARRAY:C640($ImagesTable_ptr->; $newIds_aL)
			FIRST RECORD:C50($ImagesTable_ptr->)
			While (Not:C34(End selection:C36($ImagesTable_ptr->)))
				If (Find in array:C230($SelImgIDs_aL; Record number:C243($ImagesTable_ptr->))>0)
					ADD TO SET:C119($ImagesTable_ptr->; "ImgListBoxSet")
				End if 
				NEXT RECORD:C51($ImagesTable_ptr->)
			End while 
			
			//check to make sure the line we moved to is visible on the listbox
			//Calculate number of lines visible
			C_LONGINT:C283($LB_L; $Lb_T; $LB_R; $LB_B; $LB_H; $LB_HeaderHt; $LB_RowHt; $LB_NumRows; $LB_firstRow)
			OBJECT GET COORDINATES:C663(*; $LB_Name; $LB_L; $Lb_T; $LB_R; $LB_B)
			$LB_H:=$LB_B-$Lb_T
			$LB_HeaderHt:=LISTBOX Get headers height:C1144(*; $LB_Name; lk pixels:K53:22)
			$LB_RowHt:=LISTBOX Get rows height:C836(*; $LB_Name; lk pixels:K53:22)
			$LB_NumRows:=($LB_H-$LB_HeaderHt)/$LB_RowHt  //number of visible rows
			
			OBJECT GET SCROLL POSITION:C1114(*; $LB_Name; $LB_firstRow)
			
			Case of 
				: ($dropRow_L<$LB_firstRow)
					//We moved beyond top of LB
					OBJECT SET SCROLL POSITION:C906(*; $LB_Name; $dropRow_L)
					
				: ($dropRow_L>($LB_firstRow+$LB_NumRows-1))
					//Moved beyond bottom of lb
					OBJECT SET SCROLL POSITION:C906(*; $LB_Name; $dropRow_L+1)  //allows for one extra line
					
			End case 
			
			ARRAY LONGINT:C221($newIds_aL; 0)
			C_POINTER:C301($LB_ptr)
			$LB_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; $LB_Name)
			REDRAW:C174($LB_ptr->)
			//REDRAW WINDOW
			OBJECT SET VISIBLE:C603(*; "ImageSortWarning"; True:C214)
			NTI_ImageSortNeeded_b:=True:C214
			LSS_PhotoUpdateSeq_b:=True:C214
		End if 
		CLOSE WINDOW:C154
	Else 
		CLOSE WINDOW:C154
		ALERT:C41("Multiple Image types selected to be moved! Can only work with one type at a time (Sketch, or Chart, or Photo)")
	End if 
	
Else 
	ALERT:C41("No Image records selected!")
	
End if 
//End INSP_MoveImages