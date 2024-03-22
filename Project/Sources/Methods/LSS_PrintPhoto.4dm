//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 12/16/14, 11:42:03
//----------------------------------------------------
//Method: LSS_PrintPhoto
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (12/16/14 11:42:05)
	
End if 

C_BOOLEAN:C305($1; $ByPassSettings_b; $HaveMorePages_B)


If (Count parameters:C259=1)
	$ByPassSettings_b:=$1
Else 
	$ByPassSettings_b:=False:C215
End if 

C_LONGINT:C283($RecordCount_L; $Loop_L; $i; $Ht)
C_PICTURE:C286(vPicture1; vPicture2)
C_TEXT:C284(vTitle1; vTitle2)
C_TEXT:C284(vPhotoNum1; vPhotoNum2)  // Command Replaced was o_C_STRING length was 255
C_PICTURE:C286($MyEmptyPicture)
C_BOOLEAN:C305($bPortrait)
C_LONGINT:C283(viInspPreviewErr; vPageNo; vTotalPages)  //Command Replaced was o_C_INTEGER//Initialize our Print Error var and others
viInspPreviewErr:=0  //initialize Error
C_TEXT:C284(sBDEPT; sBDEPT_P; sTOWN; sInspDATE; INSP_Item8_s)  // Command Replaced was o_C_STRING length was 80

If (Not:C34($ByPassSettings_b))
	
	G_PrintOptions
	
	If (<>ShowPrint)
		PRINT SETTINGS:C106
	End if 
	
End if 
If ((OK=1) | ($ByPassSettings_b))
	ON ERR CALL:C155("G_PrintError")  //Set error handler for quiting from Preview
	
	C_LONGINT:C283($PhotoCount_L; $ChartCount_L; $SketchCount_L)
	$PhotoCount_L:=Records in set:C195("LSS_InspectionPhotoSet")
	$ChartCount_L:=Records in set:C195("LSS_ChartSet")
	$SketchCount_L:=Records in set:C195("LSS_SketchSet")
	$HaveMorePages_B:=($PhotoCount_L>0) | ($ChartCount_L>0)
	
	USE SET:C118("LSS_SketchSet")
	ORDER BY:C49([LSS_Photos:166]; [LSS_Photos:166]LSS_PhotoSequence_L:6; >)
	//$RecordCount_L:=Records in selection([LSS_Photos])
	For ($Loop_L; 1; $SketchCount_L)
		If (viInspPreviewErr=0)
			GOTO SELECTED RECORD:C245([LSS_Photos:166]; $Loop_L)
			vPicture1:=$MyEmptyPicture*0
			BLOB TO PICTURE:C682([LSS_Photos:166]LSS_Photo_blb:5; vPicture1)
			vPage2Title:="SKETCHES"
			vTitle1:=[LSS_Photos:166]LSS_Photo_txt:4
			vPhotoNum1:="Sketch "+String:C10([LSS_Photos:166]LSS_PhotoSequence_L:6)+" : "
			$Ht:=Print form:C5([LSS_Inspection:164]; "LSS_SketchPrint")
			If ($HaveMorePages_B)
				PAGE BREAK:C6(>)
			Else 
				If ($Loop_L>$SketchCount_L)
					PAGE BREAK:C6
				Else 
					PAGE BREAK:C6(>)
				End if 
			End if 
		Else 
			$Loop_L:=$SketchCount_L+1  //exit loop
		End if 
		
	End for 
	
	USE SET:C118("LSS_ChartSet")
	ORDER BY:C49([LSS_Photos:166]; [LSS_Photos:166]LSS_PhotoSequence_L:6; >)
	//$RecordCount_L:=Records in selection([LSS_Photos])
	$HaveMorePages_B:=($PhotoCount_L>0)
	For ($Loop_L; 1; $ChartCount_L)
		If (viInspPreviewErr=0)
			GOTO SELECTED RECORD:C245([LSS_Photos:166]; $Loop_L)
			vPicture1:=$MyEmptyPicture*0
			BLOB TO PICTURE:C682([LSS_Photos:166]LSS_Photo_blb:5; vPicture1)
			vTitle1:=[LSS_Photos:166]LSS_Photo_txt:4
			vPage2Title:="CHARTS"
			vPhotoNum1:="Chart "+String:C10([LSS_Photos:166]LSS_PhotoSequence_L:6)+" : "
			$Ht:=Print form:C5([LSS_Inspection:164]; "LSS_SketchPrint")
			If ($HaveMorePages_B)
				PAGE BREAK:C6(>)
			Else 
				If ($Loop_L>$ChartCount_L)
					PAGE BREAK:C6
				Else 
					PAGE BREAK:C6(>)
				End if 
			End if 
		Else 
			$Loop_L:=$ChartCount_L+1  //exit loop
		End if 
		
	End for 
	
	USE SET:C118("LSS_InspectionPhotoSet")
	
	ORDER BY:C49([LSS_Photos:166]; [LSS_Photos:166]LSS_PhotoSequence_L:6; >)
	
	//$RecordCount_L:=Records in selection([LSS_Photos])
	
	For ($Loop_L; 1; $PhotoCount_L)
		If (viInspPreviewErr=0)
			GOTO SELECTED RECORD:C245([LSS_Photos:166]; $Loop_L)
			
			vPhotoNum2:=""
			vTitle2:=""
			vPhotoNum2:=""
			vPicture2:=$MyEmptyPicture*0
			vPicture1:=$MyEmptyPicture*0
			BLOB TO PICTURE:C682([LSS_Photos:166]LSS_Photo_blb:5; vPicture1)
			vTitle1:=[LSS_Photos:166]LSS_Photo_txt:4
			vPhotoNum1:="PHOTO "+String:C10([LSS_Photos:166]LSS_PhotoSequence_L:6)+" : "
			If ($Loop_L<$PhotoCount_L)
				GOTO SELECTED RECORD:C245([LSS_Photos:166]; $Loop_L+1)
				BLOB TO PICTURE:C682([LSS_Photos:166]LSS_Photo_blb:5; vPicture2)
				vTitle2:=[LSS_Photos:166]LSS_Photo_txt:4
				vPhotoNum2:="PHOTO "+String:C10([LSS_Photos:166]LSS_PhotoSequence_L:6)+" : "
				$Loop_L:=$Loop_L+1
			End if 
			
			$Ht:=Print form:C5([LSS_Inspection:164]; "LSS_PhotoPrint")
			
			If ($Loop_L>=$PhotoCount_L)
				PAGE BREAK:C6
			Else 
				PAGE BREAK:C6(>)
			End if 
		Else 
			$Loop_L:=$PhotoCount_L+1  //exit loop
		End if 
		
	End for 
	
	
End if 
ON ERR CALL:C155("")  //reset the error handler
//Blank the picture variables  
vPicture2:=$MyEmptyPicture*0
vPicture1:=$MyEmptyPicture*0
vTitle1:=""
vTitle2:=""
//End LSS_PrintPhoto

