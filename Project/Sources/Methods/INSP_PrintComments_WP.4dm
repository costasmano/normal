//%attributes = {"invisible":true}
//Method: INSP_PrintComments_WP
//Description
// Print inspection report comments using Write Pro
// Similar to Print_Dive_Cmt_a_new
// Parameters
// $0 : $numPages
// $1 : $params_o .printFlag (boolean)  .viewComments (boolean)
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/20/21, 15:59:11
	// ----------------------------------------------------
	//Created : 
	Mods_2021_WP
	
	C_LONGINT:C283(INSP_PrintComments_WP; $0)
	C_OBJECT:C1216(INSP_PrintComments_WP; $1)
	
	// Modified by: Costas Manousakis-(Designer)-(2022-04-22 14:34:05)
	Mods_2022_04_bug
	//  `Added missing statements at the end to clear element descr and restore element selection
	// Modified by: Costas Manousakis-(Designer)-(2022-04-22 15:40:35)
	Mods_2022_04
	//  `use method INSP_CountInspImages  
End if 
//

C_BLOB:C604($CmtsField; $WPArea_x)
C_OBJECT:C1216($WPArea_; $Range)
C_TEXT:C284($DataTag)
C_LONGINT:C283($offset; $compressed)

C_BOOLEAN:C305($bViewAllCmtsFlag; $bOrientation; $bGeneral)
$0:=0  //initialize to zero
$bViewAllCmtsFlag:=False:C215
If (Count parameters:C259>0)
	C_OBJECT:C1216($1)
	
	Case of 
		: ($1.printFlag=Null:C1517)
		: (Value type:C1509($1.printFlag)#Is boolean:K8:9)
		Else 
			PrintFlag:=$1.printFlag
	End case 
	Case of 
		: ($1.viewComments=Null:C1517)
		: (Value type:C1509($1.viewComments)#Is boolean:K8:9)
		Else 
			$bViewAllCmtsFlag:=$1.viewComments
	End case 
	
End if 

COPY NAMED SELECTION:C331([ElementsSafety:29]; "ElmtsInUse")

G_Insp_RelateInsp(->[ElementsSafety:29]InspID:4)
INSP_ElmtDescUtil("LOAD")

// select only safety elements that have non-blank comments.
QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Comment Flag:6=True:C214)
Insp_SortElmtSfty

C_LONGINT:C283($vAllElmts)
$vAllElmts:=Records in selection:C76([ElementsSafety:29])

C_LONGINT:C283($numphotos)
C_OBJECT:C1216($imagecounts_o)
$imagecounts_o:=INSP_CountInspImages
$numphotos:=$imagecounts_o.total

C_BOOLEAN:C305($bOrientation)
$bOrientation:=((BLOB size:C605([Inspections:27]OrientationText:204)>0) & (f_Insp_Revision1([Inspections:27]Insp Date:78)))

$bGeneral:=(BLOB size:C605([Inspections:27]InspComments:171)>0)
If (($bGeneral) & ([Inspections:27]Insp Type:6="DAM"))
	If (Not:C34(f_Insp_Revision1([Inspections:27]Insp Date:78)))  //only check this for inspections before DATE_1
		C_OBJECT:C1216($wpdocProp_o)
		$wpdocProp_o:=wrp_GetTextProperties([Inspections:27]InspComments:171)
		$bGeneral:=($wpdocProp_o.count>=350)
		
	End if 
End if 

If (($bOrientation) | ($bGeneral) | ($vAllElmts>0) | ($numphotos>0))
	
	$WPArea_:=INSP_InitializeWPArea
	
	If ($bOrientation)
		G_Insp_AddOrientation_WP($WPArea_)
	End if 
	
	If ($bGeneral)
		G_Insp_AddGenCmts_WP($WPArea_)
	End if 
	
	C_LONGINT:C283($ReturnLengthLimit_L)
	$ReturnLengthLimit_L:=INSP_ReturnCMLength
	
	//       if element comments
	If ($vAllelmts>0)
		C_TEXT:C284($vsElmtCatPrev; $vElmTitle)  // **Replaced old C_STRING length 3
		FIRST RECORD:C50([ElementsSafety:29])
		$vsElmtCatPrev:=""
		C_LONGINT:C283($ElmIndx_L; $i; $count)
		For ($i; 1; $vAllelmts)
			$ElmIndx_L:=Find in array:C230(<>ELMTDICT_ELNum_ai; [ElementsSafety:29]ElementNo:1)
			//RELATE ONE([ElementsSafety]ElementNo)
			C_OBJECT:C1216($textProps)
			$textProps:=wrp_GetTextProperties([ElementsSafety:29]ElmComments:23)
			$count:=$textProps.count
			
			//If the letter count is less than XX then it was
			//printed on the 1st page
			If (($count>=$ReturnLengthLimit_L) | (([Inspections:27]Insp Type:6#"TOV") & ([Inspections:27]Insp Type:6#"DVS") & ([Inspections:27]Insp Type:6#"DAM") & ([Inspections:27]Insp Type:6#"FCR") & ([Inspections:27]Insp Type:6#"CMI") & ([Inspections:27]Insp Type:6#"RRS") & ([Inspections:27]Insp Type:6#"TSP") & ([Inspections:27]Insp Type:6#"TOT") & ([Inspections:27]Insp Type:6#"TDA") & ([Inspections:27]Insp Type:6#"OTH") & ([Inspections:27]Insp Type:6#"RRO")))
				If (<>ELMTDICT_Cat_as{$ElmIndx_L}#$vsElmtCatPrev)  //Add a header when we change element categories
					G_AddHeader(<>ELMTDICT_Cat_as{$ElmIndx_L})
					$vsElmtCatPrev:=<>ELMTDICT_Cat_as{$ElmIndx_L}
				End if 
				$vElmTitle:=G_GetElmtLabel(True:C214)
				G_AddElmtTxt2Area_WP($WPArea_; $vElmTitle; [ElementsSafety:29]ElmComments:23)
			End if 
			NEXT RECORD:C51([ElementsSafety:29])
		End for 
		
	End if 
	
	If ($numphotos>0)
		// get photo log into the Write pro object
		G_CreateImageLog_WP($WPArea_)
	End if 
	
	C_LONGINT:C283($numpages)
	$numpages:=WP Get page count:C1412($WPArea_)
	
	If ((PrintFlag) & ($bViewAllCmtsFlag=False:C215))
		Insp_PrintRemarks_WP($WPArea_)
	End if 
	
	If ($bViewAllCmtsFlag)
		INSP_ViewAllComments_WP($WPArea_)
	End if 
	
	$0:=$numpages
	
End if 

INSP_ElmtDescUtil("CLEAR")

USE NAMED SELECTION:C332("ElmtsInUse")
CLEAR NAMED SELECTION:C333("ElmtsInUse")
//End INSP_PrintComments_WP