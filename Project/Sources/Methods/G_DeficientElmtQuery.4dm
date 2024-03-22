//%attributes = {"invisible":true}
If (False:C215)
	//G_DeficientElmtQuery 
	//
	Mods_2004_CM12
	Mods_2005_CM16
	// Modified by: costasmanousakis-(Designer)-(9/18/09 09:57:22)
	Mods_2009_09
	//  `Additions to include search for word or phrase in Element comments
	// Modified by: costasmanousakis-(Designer)-(11/24/10 14:01:47)
	Mods_2010_11
	//  `Mods for search by element description
	Mods_2011_06  // CJ Miller`06/14/11, 10:43:28      ` Type all local variables for v11
	// Modified by: Costas Manousakis-(Designer)-(4/5/19 17:27:21)
	Mods_2019_04
	//  `fix logic for deficiency comparisons (C-H is higher/worse then C-S)
	//  `when comparing <= or >= in cond ratings bracket the search by 0 or 9 limits
	// Modified by: Costas Manousakis-(Designer)-(6/23/21 12:20:55)
	Mods_2021_WP
	//  `
End if 
C_LONGINT:C283($iCount)
C_LONGINT:C283($Progressbar_L)
$Progressbar_L:=Progress New
Progress SET TITLE($Progressbar_L; "Applying Element Criteria")
//1) `Categories of Deficiencies
If (vDef#"")
	//QUERY SELECTION([Bridge MHD NBIS];[Bridge MHD NBIS]BDEPT=$s)
	Progress SET MESSAGE($Progressbar_L; "Deficiency...")
	Case of 
		: (vDefOp="=")
			QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Deficiency:3=vDef)
			
		: (vDefOp="#")
			QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Deficiency:3#vDef)
			
		: (vDefOp="<")
			Case of 
				: (vDef="M")
					QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Deficiency:3#"M"; *)
					QUERY SELECTION:C341([ElementsSafety:29];  & ; [ElementsSafety:29]Deficiency:3#"S"; *)
					QUERY SELECTION:C341([ElementsSafety:29];  & ; [ElementsSafety:29]Deficiency:3#"C-S")
					QUERY SELECTION:C341([ElementsSafety:29];  & ; [ElementsSafety:29]Deficiency:3#"C-H")
				: (vDef="S")
					QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Deficiency:3="M")
				: (vDef="C-S")
					QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Deficiency:3="M"; *)
					QUERY SELECTION:C341([ElementsSafety:29];  | ; [ElementsSafety:29]Deficiency:3="S"; *)
					
				: (vDef="C-H")
					QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Deficiency:3="M"; *)
					QUERY SELECTION:C341([ElementsSafety:29];  | ; [ElementsSafety:29]Deficiency:3="S"; *)
					QUERY SELECTION:C341([ElementsSafety:29];  | ; [ElementsSafety:29]Deficiency:3="C-S")
			End case 
			
		: (vDefOp="<=")
			Case of 
				: (vDef="M")
					QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Deficiency:3="M")
				: (vDef="S")
					QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Deficiency:3="M"; *)
					QUERY SELECTION:C341([ElementsSafety:29];  | ; [ElementsSafety:29]Deficiency:3="S")
				: (vDef="C-S")
					QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Deficiency:3="M"; *)
					QUERY SELECTION:C341([ElementsSafety:29];  | ; [ElementsSafety:29]Deficiency:3="S"; *)
					QUERY SELECTION:C341([ElementsSafety:29];  | ; [ElementsSafety:29]Deficiency:3="C-S")
				: (vDef="C-H")
					QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Deficiency:3="M"; *)
					QUERY SELECTION:C341([ElementsSafety:29];  | ; [ElementsSafety:29]Deficiency:3="S"; *)
					QUERY SELECTION:C341([ElementsSafety:29];  | ; [ElementsSafety:29]Deficiency:3="C-S"; *)
					QUERY SELECTION:C341([ElementsSafety:29];  | ; [ElementsSafety:29]Deficiency:3="C-H")
			End case 
			
		: (vDefOp=">")
			Case of 
				: (vDef="M")
					QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Deficiency:3="S"; *)
					QUERY SELECTION:C341([ElementsSafety:29];  | ; [ElementsSafety:29]Deficiency:3="C-H"; *)
					QUERY SELECTION:C341([ElementsSafety:29];  | ; [ElementsSafety:29]Deficiency:3="C-S")
				: (vDef="S")
					QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Deficiency:3="C-H"; *)
					QUERY SELECTION:C341([ElementsSafety:29];  | ; [ElementsSafety:29]Deficiency:3="C-S")
				: (vDef="C-S")
					QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Deficiency:3="C-H")
				: (vDef="C-H")
					//QUERY SELECTION([ElementsSafety];[ElementsSafety]Deficiency="C-S")
			End case 
			
		: (vDefOp=">=")
			Case of 
				: (vDef="M")
					QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Deficiency:3="M"; *)
					QUERY SELECTION:C341([ElementsSafety:29];  | ; [ElementsSafety:29]Deficiency:3="S"; *)
					QUERY SELECTION:C341([ElementsSafety:29];  | ; [ElementsSafety:29]Deficiency:3="C-H"; *)
					QUERY SELECTION:C341([ElementsSafety:29];  | ; [ElementsSafety:29]Deficiency:3="C-S")
				: (vDef="S")
					QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Deficiency:3="S"; *)
					QUERY SELECTION:C341([ElementsSafety:29];  | ; [ElementsSafety:29]Deficiency:3="C-H"; *)
					QUERY SELECTION:C341([ElementsSafety:29];  | ; [ElementsSafety:29]Deficiency:3="C-S")
				: (vDef="C-S")
					QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Deficiency:3="C-S"; *)
					QUERY SELECTION:C341([ElementsSafety:29];  | ; [ElementsSafety:29]Deficiency:3="C-H")
				: (vDef="C-H")
					QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Deficiency:3="C-H")
			End case 
			
		Else 
			QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Deficiency:3=vDef)
	End case 
	$iCount:=Records in selection:C76([ElementsSafety:29])
End if 

//2) Urgency of Repair
If (vUrg#"")
	Progress SET MESSAGE($Progressbar_L; "Urgency of Repair...")
	
	Case of 
		: (vUrgOp="=")
			QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Priority:20=vUrg)
			
		: (vUrgOp="#")
			QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Priority:20#vUrg)
			
		: (vUrgOp="<")
			Case of 
				: (vUrg="I")
					QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Priority:20="A"; *)
					QUERY SELECTION:C341([ElementsSafety:29];  | ; [ElementsSafety:29]Priority:20="P")
				: (vUrg="A")
					QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Priority:20="P")
				: (vUrg="P")
			End case 
			
		: (vUrgOp="<=")
			Case of 
				: (vUrg="I")
					QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Priority:20="I"; *)
					QUERY SELECTION:C341([ElementsSafety:29];  | ; [ElementsSafety:29]Priority:20="A"; *)
					QUERY SELECTION:C341([ElementsSafety:29];  | ; [ElementsSafety:29]Priority:20="P")
				: (vUrg="A")
					QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Priority:20="A"; *)
					QUERY SELECTION:C341([ElementsSafety:29];  | ; [ElementsSafety:29]Priority:20="P")
				: (vUrg="P")
					QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Priority:20="P")
			End case 
			
		: (vUrgOp=">")
			Case of 
				: (vUrg="I")
				: (vUrg="A")
					QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Priority:20="I")
				: (vUrg="P")
					QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Priority:20="I"; *)
					QUERY SELECTION:C341([ElementsSafety:29];  | ; [ElementsSafety:29]Priority:20="A")
			End case 
			
		: (vUrgOp=">=")
			Case of 
				: (vUrg="I")
					QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Priority:20="I")
				: (vUrg="A")
					QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Priority:20="I"; *)
					QUERY SELECTION:C341([ElementsSafety:29];  | ; [ElementsSafety:29]Priority:20="A")
				: (vUrg="P")
					QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Priority:20="I"; *)
					QUERY SELECTION:C341([ElementsSafety:29];  | ; [ElementsSafety:29]Priority:20="A"; *)
					QUERY SELECTION:C341([ElementsSafety:29];  | ; [ElementsSafety:29]Priority:20="P")
			End case 
			
		Else 
			QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Priority:20=vUrg)
	End case 
	$iCount:=Records in selection:C76([ElementsSafety:29])
End if 

//3) Element Condition Rating
If (cboElmtCond>0)
	Progress SET MESSAGE($Progressbar_L; "Element Condition Rating...")
	
	Case of 
		: (vElmtCondOp="=")
			QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Rating:2=cboElmtCondCode{cboElmtCond})
			
		: (vElmtCondOp="#")
			QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Rating:2#cboElmtCondCode{cboElmtCond})
			
		: (vElmtCondOp="<")
			QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Rating:2<cboElmtCondCode{cboElmtCond})
			QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Rating:2>="0")
			
		: (vElmtCondOp="<=")
			QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Rating:2<=cboElmtCondCode{cboElmtCond})
			QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Rating:2>="0")
			
		: (vElmtCondOp=">")
			QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Rating:2>cboElmtCondCode{cboElmtCond})
			QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Rating:2<="9")
			
		: (vElmtCondOp=">=")
			QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Rating:2>=cboElmtCondCode{cboElmtCond})
			QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Rating:2<="9")
			
		Else 
			QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Rating:2=cboElmtCondCode{cboElmtCond})
	End case 
	$iCount:=Records in selection:C76([ElementsSafety:29])
	QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Rating:2#"")  //exclude blank values
End if 

//4) Element Category
If (cbElementCat=1)
	Progress SET MESSAGE($Progressbar_L; "Element Category...")
	
	//only the element category is selected  
	If ((cboInspType#0) & (cboElem=0))
		If (aInspCod_{cboInspType}#"ALL")
			QUERY SELECTION:C341([ElementsSafety:29]; [ElementDict:30]Category:3=aInspCod_{cboInspType})
		End if 
	Else 
		//specific element is selected    
		If (cboElem#0)
			QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]ElementNo:1=aElemNo{cboElem})
		End if 
	End if 
	$iCount:=Records in selection:C76([ElementsSafety:29])
End if 

//5) Text in Element Descr 
If ((cbElemDescTxt=1) & (f_TrimStr(SRC_ELEMDESC_txt; True:C214; True:C214)#""))
	Progress SET MESSAGE($Progressbar_L; "Element Description...")
	
	C_LONGINT:C283($FoundText1_L; $FoundText_L; $expanded_L; $TempWRArea_L)
	C_TEXT:C284(SRC_ELEMDESC_txt; $tempText_txt)
	SRC_ELEMDESC_txt:=f_TrimStr(SRC_ELEMDESC_txt; True:C214; True:C214)
	If (SRC_ELEMDESC_txt#"")
		Case of 
			: (cboDescComparison=3)  //Begins with
				QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Description:22=SRC_ELEMDESC_txt+"@")
			: (cboDescComparison=4)  //Ends with
				QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Description:22="@"+SRC_ELEMDESC_txt)
			: (cboDescComparison=2)  //Equals
				QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Description:22=SRC_ELEMDESC_txt)
			Else 
				//default = Contains
				QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Description:22="@"+SRC_ELEMDESC_txt+"@")
				cboDescComparison:=1  //set it just in case
		End case 
		
	End if 
	
End if 

//6) Text in Element Comments 
If ((cbElementTxt=1) & (f_TrimStr(SRC_ELEMTEXT_txt; True:C214; True:C214)#""))
	Progress SET MESSAGE($Progressbar_L; "Text in Element Comments ...")
	
	C_LONGINT:C283($FoundText1_L; $FoundText_L; $expanded_L; $TempWRArea_L)
	C_TEXT:C284(SRC_ELEMTEXT_txt; $tempText_txt)
	SRC_ELEMTEXT_txt:=f_TrimStr(SRC_ELEMTEXT_txt; True:C214; True:C214)
	C_BOOLEAN:C305($expanded_b)
	//$TempWRArea_L:=WR New offscreen area 
	CREATE EMPTY SET:C140([ElementsSafety:29]; "MATCHTXTELMTS")
	FIRST RECORD:C50([ElementsSafety:29])
	Progress SET PROGRESS($Progressbar_L; 0)
	C_OBJECT:C1216($Wp_o; $Range_o)
	C_BLOB:C604($wpBlob_x)
	C_TEXT:C284($wpText_txt)
	While (Not:C34(End selection:C36([ElementsSafety:29])))
		If (BLOB size:C605([ElementsSafety:29]ElmComments:23)>0)
			
			$wpBlob_x:=INSP_GetWPDocFromBlob([ElementsSafety:29]ElmComments:23)
			If (BLOB size:C605($wpBlob_x)>0)
				$wp_o:=WP New:C1317($wpBlob_x)
				$Range_o:=WP Text range:C1341($Wp_o; wk start text:K81:165; wk end text:K81:164)
				$wpText_txt:=WP Get text:C1575($Range_o; wk expressions as value:K81:255)
				$FoundText_L:=Position:C15(SRC_ELEMTEXT_txt; $wpText_txt)
				If ($FoundText_L>0)
					ADD TO SET:C119([ElementsSafety:29]; "MATCHTXTELMTS")
				End if 
			End if 
			
			//BLOB PROPERTIES([ElementsSafety]ElmComments;$expanded_L)
			//If ($expanded_L>0)
			//EXPAND BLOB([ElementsSafety]ElmComments)
			//End if 
			
			//WR SELECT ($TempWRArea_L;0;0;32000)
			//WR INSERT STYLED TEXT ($TempWRArea_L;[ElementsSafety]ElmComments)
			//$FoundText_L:=WR Find ($TempWRArea_L;SRC_ELEMTEXT_txt;cbWholeWord;0;1)
			//If ($FoundText_L>0)
			//ADD TO SET([ElementsSafety];"MATCHTXTELMTS")
			//End if 
			
		End if 
		
		NEXT RECORD:C51([ElementsSafety:29])
		Progress SET PROGRESS($Progressbar_L; Selected record number:C246([ElementsSafety:29])/Records in selection:C76([ElementsSafety:29]))
	End while 
	
	SET BLOB SIZE:C606($wpBlob_x; 0)
	
	USE SET:C118("MATCHTXTELMTS")
	CLEAR SET:C117("MATCHTXTELMTS")
	$iCount:=Records in selection:C76([ElementsSafety:29])
	//WR DELETE OFFSCREEN AREA ($TempWRArea_L)
End if 

Progress QUIT($Progressbar_L)