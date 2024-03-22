//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/01/09, 16:38:49
	// ----------------------------------------------------
	// Method: Method: SCPOA_CopyScourNotes
	// Description
	// 
	// 
	// Parameters
	// $0 : $ScourHist_txt
	// $1 : $Batch_mode_b (Optional) Default = false
	// ----------------------------------------------------
	
	Mods_2009_06
	Mods_2009_06  //r002 `06/12/09, 15:56:17   `Merge in changes made by Costas
End if 
C_TEXT:C284($0; $ScourHist_txt)
$ScourHist_txt:=""

C_BOOLEAN:C305($Batch_mode_b)
$Batch_mode_b:=False:C215
If (Count parameters:C259>0)
	C_BOOLEAN:C305($1)
	$Batch_mode_b:=$1
End if 

C_BOOLEAN:C305($OneRel_b; $ManyRel_b; $InvRO_b; $invPhoRO_b)
GET AUTOMATIC RELATIONS:C899($OneRel_b; $ManyRel_b)
SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
$InvRO_b:=Read only state:C362([Inspections:27])
$invPhoRO_b:=Read only state:C362([ElementsSafety:29])
READ ONLY:C145([Inspections:27])
READ ONLY:C145([ElementsSafety:29])
READ ONLY:C145([Inspection Type:31])

QUERY:C277([Inspections:27]; [Inspections:27]BIN:1=[ScourPOA:132]BIN:2)
ARRAY LONGINT:C221($InspIDs_aL; Records in selection:C76([Inspections:27]))
SELECTION TO ARRAY:C260([Inspections:27]InspID:2; $InspIDs_aL)
QUERY WITH ARRAY:C644([ElementsSafety:29]InspID:4; $InspIDs_aL)
QUERY SELECTION:C341([ElementsSafety:29]; [ElementDict:30]Description:2="@scour@")
ARRAY LONGINT:C221($InspIDs_aL; 0)
C_LONGINT:C283($numElems_L)
$numElems_L:=Records in selection:C76([ElementsSafety:29])
If ($numElems_L>0)
	ORDER BY:C49([ElementsSafety:29]; [Inspections:27]Insp Date:78; <; [ElementDict:30]Category:3; >)
	ARRAY INTEGER:C220($ElemNos_aL; $numElems_L)
	ARRAY LONGINT:C221($ElemIDs_aL; $numElems_L)
	ARRAY LONGINT:C221($InspIDs_aL; $numElems_L)
	ARRAY DATE:C224($InspDates_ad; $numElems_L)
	ARRAY TEXT:C222($InspType_as; $numElems_L)
	ARRAY LONGINT:C221($NoDuplElemNos_aL; $numElems_L)
	SELECTION TO ARRAY:C260([ElementsSafety:29]ElementNo:1; $ElemNos_aL; [ElementsSafety:29]ElmSafetyID:7; $ElemIDs_aL; [Inspections:27]Insp Date:78; $InspDates_ad; [Inspections:27]Insp Type:6; $InspType_as; [Inspections:27]InspID:2; $InspIDs_aL)
	C_LONGINT:C283($loop_L; $currInspID_L; $ElmIndx_L; $ElmParIndx_L; $currParindx_L; $FoundBefore_L)
	C_TEXT:C284($ElmText_txt; $CurrCatCode_txt; $Comments_txt)
	$currInspID_L:=0
	$CurrCatCode_txt:=""
	$currParindx_L:=0
	For ($loop_L; 1; $numElems_L)
		GOTO SELECTED RECORD:C245([ElementsSafety:29]; $loop_L)
		LOAD RECORD:C52([ElementsSafety:29])
		If (BLOB size:C605([ElementsSafety:29]ElmComments:23)>0)
			$Comments_txt:=Fn_GetTextBlob([ElementsSafety:29]ElmComments:23)
			$Comments_txt:=Replace string:C233($Comments_txt; <>sTab; " ")
			$Comments_txt:=Replace string:C233($Comments_txt; <>sCR; " ")
			
			If (($Comments_txt#"See item@") & ($Comments_txt#"See: item@") & ($Comments_txt#"Refer @"))
				$FoundBefore_L:=Find in array:C230($NoDuplElemNos_aL; $ElemNos_aL{$loop_L})
				If ($FoundBefore_L<=0)
					$NoDuplElemNos_aL{$loop_L}:=$ElemNos_aL{$loop_L}
					$ElmIndx_L:=Find in array:C230(<>ELMTDICT_ELNum_ai; $ElemNos_aL{$loop_L})
					If ($ElmIndx_L>0)
						$ElmText_txt:=""
						QUERY:C277([Element Cat:32]; [Element Cat:32]Code:1=<>ELMTDICT_Cat_as{$ElmIndx_L})
						If (<>ELMTDICT_Cat_as{$ElmIndx_L}#$CurrCatCode_txt)
							$ElmText_txt:=[Element Cat:32]Description:2+" / "
							$CurrCatCode_txt:=<>ELMTDICT_Cat_as{$ElmIndx_L}
						End if 
						
						If (<>ELMTDICT_Parent_ai{$ElmIndx_L}>0)
							If (<>ELMTDICT_Parent_ai{$ElmIndx_L}#$currParindx_L)
								$ElmParIndx_L:=Find in array:C230(<>ELMTDICT_ELNum_ai; <>ELMTDICT_Parent_ai{$ElmIndx_L})
								$ElmText_txt:=$ElmText_txt+<>ELMTDICT_Txt_as{$ElmParIndx_L}+" / "
								$currParindx_L:=<>ELMTDICT_Parent_ai{$ElmIndx_L}
							End if 
							
						End if 
						$ElmText_txt:=$ElmText_txt+<>ELMTDICT_Txt_as{$ElmIndx_L}
						$ElmText_txt:=$ElmText_txt+" : "+$Comments_txt+" ; "
						If ($InspIDs_aL{$loop_L}#$currInspID_L)
							QUERY:C277([Inspection Type:31]; [Inspection Type:31]Code:1=$InspType_as{$loop_L})
							$ScourHist_txt:=$ScourHist_txt+[Inspection Type:31]Description:2+" Insp. "+String:C10($InspDates_ad{$loop_L})+" : "
							$currInspID_L:=$InspIDs_aL{$loop_L}
						End if 
						$ScourHist_txt:=$ScourHist_txt+$ElmText_txt
					Else 
						
					End if 
					
				Else 
					
				End if 
				
			End if 
			
		End if 
		
	End for 
	$ScourHist_txt:=Substring:C12($ScourHist_txt; 1; (Length:C16($ScourHist_txt)-3))
	$ScourHist_txt:=Replace string:C233($ScourHist_txt; <>sTab; " ")
	ARRAY INTEGER:C220($ElemNos_aL; 0)
	ARRAY LONGINT:C221($ElemIDs_aL; 0)
	ARRAY LONGINT:C221($InspIDs_aL; 0)
	ARRAY DATE:C224($InspDates_ad; 0)
	ARRAY TEXT:C222($InspType_as; 0)
	ARRAY LONGINT:C221($NoDuplElemNos_aL; 0)
	
End if 

If (Not:C34($InvRO_b))
	READ WRITE:C146([Inspections:27])
End if 
If (Not:C34($invPhoRO_b))
	READ WRITE:C146([ElementsSafety:29])
End if 
SET AUTOMATIC RELATIONS:C310($OneRel_b; $ManyRel_b)

$0:=$ScourHist_txt
