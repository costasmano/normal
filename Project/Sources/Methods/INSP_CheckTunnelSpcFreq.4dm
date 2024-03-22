//%attributes = {"invisible":true}
//Method: INSP_CheckTunnelSpcFreq
//Description
//  `Check for any changes needed in the special member frequencies for Tunnel Inspections
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/26/13, 16:11:29
	// ----------------------------------------------------
	//Created : 
	Mods_2013_09
End if 
//
C_LONGINT:C283($Numeq4_L; $numLT4_L; $NumOtherEQ4_L; $NumOtherLT4_L)
GET AUTOMATIC RELATIONS:C899($one_b; $many_b)
SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
ARRAY TEXT:C222($cat_atxt; 0)
ARRAY LONGINT:C221($countsEq4_aL; 0)
ARRAY LONGINT:C221($countsLT4_aL; 0)
C_BOOLEAN:C305($Freq_3_b; $Freq_6_b; $Freq_12_b)
$Freq_3_b:=False:C215
$Freq_6_b:=False:C215
$Freq_12_b:=False:C215
C_TEXT:C284($Freq_3_txt; $Freq_6_txt; $Freq_12_txt)
C_BOOLEAN:C305($elmsftyRO_b)
$elmsftyRO_b:=Read only state:C362([ElementsSafety:29])
READ ONLY:C145([ElementsSafety:29])
SET QUERY DESTINATION:C396(Into set:K19:2; "$AllInspElmts")
QUERY:C277([ElementsSafety:29]; [ElementsSafety:29]InspID:4=[Inspections:27]InspID:2)
SET QUERY DESTINATION:C396(Into current selection:K19:1)

INSP_LoadElmLabelsforReport([Inspections:27]Insp Type:6)

APPEND TO ARRAY:C911($cat_atxt; "STR")
APPEND TO ARRAY:C911($cat_atxt; "ROA")
APPEND TO ARRAY:C911($cat_atxt; "CEI")
APPEND TO ARRAY:C911($cat_atxt; "SUP")
APPEND TO ARRAY:C911($cat_atxt; "CRO")
APPEND TO ARRAY:C911($cat_atxt; "EGR")
APPEND TO ARRAY:C911($cat_atxt; "UTI")
ARRAY LONGINT:C221($countsEq4_aL; Size of array:C274($cat_atxt))
ARRAY LONGINT:C221($countsLT4_aL; Size of array:C274($cat_atxt))

ARRAY INTEGER:C220($elmNo_aL; 0)
ARRAY TEXT:C222($elmRtg_as; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222($elmDesc_atxt; 0)

C_LONGINT:C283($loop_L)
C_LONGINT:C283($loop2_L)
$Freq_3_txt:=""
$Freq_6_txt:=""
$Freq_12_txt:=""
For ($loop_L; 1; Size of array:C274($cat_atxt))
	USE SET:C118("$AllInspElmts")
	SET QUERY DESTINATION:C396(Into set:K19:2; "$ELMEQ4")
	QUERY SELECTION:C341([ElementsSafety:29]; [ElementDict:30]Category:3=$cat_atxt{$loop_L}; *)
	QUERY SELECTION:C341([ElementsSafety:29];  & ; [ElementsSafety:29]Rating:2="4")
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	
	SET QUERY DESTINATION:C396(Into set:K19:2; "$ELMLT4")
	QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Rating:2="0"; *)
	QUERY SELECTION:C341([ElementsSafety:29];  | ; [ElementsSafety:29]Rating:2="1"; *)
	QUERY SELECTION:C341([ElementsSafety:29];  | ; [ElementsSafety:29]Rating:2="2"; *)
	QUERY SELECTION:C341([ElementsSafety:29];  | ; [ElementsSafety:29]Rating:2="3"; *)
	QUERY SELECTION:C341([ElementsSafety:29];  & ; [ElementDict:30]Category:3=$cat_atxt{$loop_L})
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	$numLT4_L:=Records in set:C195("$ELMLT4")
	$Numeq4_L:=Records in set:C195("$ELMEQ4")
	$countsEq4_aL{$loop_L}:=$Numeq4_L
	$countsLT4_aL{$loop_L}:=$numLT4_L
	C_TEXT:C284($catName_txt)
	$catName_txt:=Get_Description(-><>ALLElmtCatDesc_as; -><>ALLElmtCatCode_as; ->$cat_atxt{$loop_L})
	If ($cat_atxt{$loop_L}="CEI")
		//more critical
		If ($numLT4_L>0)
			$Freq_3_txt:=$Freq_3_txt+String:C10($numLT4_L)+" "+$catName_txt+" Items less than 4"+Char:C90(13)
			USE SET:C118("$ELMLT4")
			Insp_SortElmtSfty
			SELECTION TO ARRAY:C260([ElementsSafety:29]ElementNo:1; $elmNo_aL; [ElementsSafety:29]Rating:2; $elmRtg_as; [ElementsSafety:29]Description:22; $elmDesc_atxt)
			For ($loop2_L; 1; Size of array:C274($elmNo_aL))
				$Freq_3_txt:=$Freq_3_txt+"  -  "+Get_Description(->INSP_NewElementLabels_atxt; ->INSP_NewElementNumbers_ai; ->$elmNo_aL{$loop2_L})
				$Freq_3_txt:=$Freq_3_txt+" "+$elmDesc_atxt{$loop2_L}+" : "+$elmRtg_as{$loop2_L}+Char:C90(13)
			End for 
			$Freq_3_b:=True:C214
		End if 
		
		If ($Numeq4_L>0)
			$Freq_6_txt:=$Freq_6_txt+String:C10($Numeq4_L)+" "+$catName_txt+" Items Equal to 4"+Char:C90(13)
			USE SET:C118("$ELMEQ4")
			Insp_SortElmtSfty
			SELECTION TO ARRAY:C260([ElementsSafety:29]ElementNo:1; $elmNo_aL; [ElementsSafety:29]Rating:2; $elmRtg_as; [ElementsSafety:29]Description:22; $elmDesc_atxt)
			For ($loop2_L; 1; Size of array:C274($elmNo_aL))
				$Freq_6_txt:=$Freq_6_txt+"  -  "+Get_Description(->INSP_NewElementLabels_atxt; ->INSP_NewElementNumbers_ai; ->$elmNo_aL{$loop2_L})
				$Freq_6_txt:=$Freq_6_txt+" "+$elmDesc_atxt{$loop2_L}+" : "+$elmRtg_as{$loop2_L}+Char:C90(13)
			End for 
			$Freq_6_b:=True:C214
		End if 
		
	Else 
		If ($numLT4_L>0)
			$Freq_6_txt:=$Freq_6_txt+String:C10($numLT4_L)+" "+$catName_txt+" Items less than 4"+Char:C90(13)
			USE SET:C118("$ELMLT4")
			Insp_SortElmtSfty
			SELECTION TO ARRAY:C260([ElementsSafety:29]ElementNo:1; $elmNo_aL; [ElementsSafety:29]Rating:2; $elmRtg_as; [ElementsSafety:29]Description:22; $elmDesc_atxt)
			For ($loop2_L; 1; Size of array:C274($elmNo_aL))
				$Freq_6_txt:=$Freq_6_txt+"  -  "+Get_Description(->INSP_NewElementLabels_atxt; ->INSP_NewElementNumbers_ai; ->$elmNo_aL{$loop2_L})
				$Freq_6_txt:=$Freq_6_txt+" "+$elmDesc_atxt{$loop2_L}+" : "+$elmRtg_as{$loop2_L}+Char:C90(13)
			End for 
			$Freq_6_b:=True:C214
		End if 
		
		If ($Numeq4_L>0)
			$Freq_12_txt:=$Freq_12_txt+String:C10($Numeq4_L)+" "+$catName_txt+" Items Equal to 4"+Char:C90(13)
			USE SET:C118("$ELMEQ4")
			Insp_SortElmtSfty
			SELECTION TO ARRAY:C260([ElementsSafety:29]ElementNo:1; $elmNo_aL; [ElementsSafety:29]Rating:2; $elmRtg_as; [ElementsSafety:29]Description:22; $elmDesc_atxt)
			For ($loop2_L; 1; Size of array:C274($elmNo_aL))
				$Freq_12_txt:=$Freq_12_txt+"  -  "+Get_Description(->INSP_NewElementLabels_atxt; ->INSP_NewElementNumbers_ai; ->$elmNo_aL{$loop2_L})
				$Freq_12_txt:=$Freq_12_txt+" "+$elmDesc_atxt{$loop2_L}+" : "+$elmRtg_as{$loop2_L}+Char:C90(13)
			End for 
			$Freq_12_b:=True:C214
		End if 
		
	End if 
	
	CLEAR SET:C117("$ELMLT4")
	CLEAR SET:C117("$ELMEQ4")
End for 

CLEAR SET:C117("$AllInspElmts")

If ($Freq_12_b | $Freq_6_b | $Freq_3_b)
	C_TEXT:C284(INSP_TunnelSp1Desc_s; INSP_TunnelSp2Desc_s; INSP_TunnelSp3Desc_s)  // Command Replaced was o_C_STRING length was 255
	C_TEXT:C284(INSP_SpecMemFreqCheck_txt)
	C_LONGINT:C283(INSP_TunnelSp1Freq_L; INSP_TunnelSp2Freq_L; INSP_TunnelSp3Freq_L; INSP_TunnelSpecMemReq_L)
	INSP_TunnelSp1Desc_s:=[TunnelInfo:151]SpecialInsp1Desc_s:30
	INSP_TunnelSp2Desc_s:=[TunnelInfo:151]SpecialInsp2Desc_s:31
	INSP_TunnelSp3Desc_s:=[TunnelInfo:151]SpecialInsp3Desc_s:32
	INSP_TunnelSp1Freq_L:=[TunnelInfo:151]SpecialInsp1Freq_i:25
	INSP_TunnelSp2Freq_L:=[TunnelInfo:151]SpecialInsp2Freq_i:27
	INSP_TunnelSp3Freq_L:=[TunnelInfo:151]SpecialInsp3Freq_i:29
	INSP_SpecMemFreqCheck_txt:="Special Member Frequency(ies) required : "+Char:C90(13)
	INSP_TunnelSpecMemReq_L:=0  // longint that holds the flags
	
	If ($Freq_3_b)
		INSP_SpecMemFreqCheck_txt:=INSP_SpecMemFreqCheck_txt+"3 Month Frequency :"+Char:C90(13)+$Freq_3_txt+Char:C90(13)
		INSP_TunnelSpecMemReq_L:=INSP_TunnelSpecMemReq_L ?+ 1
	End if 
	
	If ($Freq_6_b)
		INSP_SpecMemFreqCheck_txt:=INSP_SpecMemFreqCheck_txt+"6 Month Frequency :"+Char:C90(13)+$Freq_6_txt+Char:C90(13)
		INSP_TunnelSpecMemReq_L:=INSP_TunnelSpecMemReq_L ?+ 2
	End if 
	If ($Freq_12_b)
		INSP_SpecMemFreqCheck_txt:=INSP_SpecMemFreqCheck_txt+"12 Month Frequency :"+Char:C90(13)+$Freq_12_txt+Char:C90(13)
		INSP_TunnelSpecMemReq_L:=INSP_TunnelSpecMemReq_L ?+ 3
	End if 
	
	INSP_SpecMemFreqCheck_txt:=Substring:C12(INSP_SpecMemFreqCheck_txt; 1; (Length:C16(INSP_SpecMemFreqCheck_txt)-1))  //strip last carr return
	
	C_LONGINT:C283($frmW_L; $frmHt_L)
	FORM GET PROPERTIES:C674([TunnelInfo:151]; "SpecialFreqCheck"; $frmW_L; $frmHt_L)
	NewWindow($frmW_L; $frmHt_L; 0; 0; "Special Member Frequency check"; "INSP_SpMemFreqChk_FM")
	DIALOG:C40([TunnelInfo:151]; "SpecialFreqCheck")
	CLOSE WINDOW:C154
End if 

SET AUTOMATIC RELATIONS:C310($one_b; $many_b)
If (Not:C34($elmsftyRO_b))
	READ WRITE:C146([ElementsSafety:29])
End if 
//End INSP_CheckTunnelSpcFreq