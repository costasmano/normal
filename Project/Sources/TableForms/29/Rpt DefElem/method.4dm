If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(7/8/08 18:20:22)
	Mods_2008_CM_5404  //("DEFELMTEXPORT")  `Copied to Server on : 08/06/08, 08:38:23
	//  `use method INSP_ElmtSfty_ItemNo and GetElmtNumber
	//  `Modified Form to add the element comments as a text variable,
	//  `added a new header section.
	//  `Modified / added form method to handle the printing of the element comments and
	//  `reduce page usage by printing more than one bridge per page.
	//
	// Modified by: costasmanousakis-(Designer)-(8/7/08 09:40:21)
	Mods_2008_CM_5404
	//  `Modified form to use a rectangle to surround the comments instead of a border around the text block.
	//  `Added code to adjust the size of the new rectangle
	//  `Added code to split the comments text at a word boundary.
	Mods_2011_06  // CJ Miller`06/20/11, 11:07:55      ` Type all local variables for v11
	// Modified by: Costas Manousakis-(Designer)-(4/9/19 12:56:48)
	Mods_2019_04
	//  `fixed height of text objects.
End if 
C_BOOLEAN:C305(DEFELMTPRINT_Test_B; DEFELMTPRINT_GetHT_B; DEFELMTPRINT_BrgHdr_b)
C_LONGINT:C283(prtHt_HDR0_L; prtHt_HDR1_L; prtHt_HDR2_L; prtHt_Det_L; prtHt_Footer_L; DEFELMTPRINT_MarkerHt_L; DEFELMTPRINT_LastChar_L; $I)
C_TEXT:C284(DEFELMTPRINT_Area_txt)
DEFELMTPRINT_LastChar_L:=0

If (DEFELMTPRINT_Test_B)
	prtHt_HDR0_L:=Get print marker:C708(Form header:K43:3)
	prtHt_Det_L:=Get print marker:C708(Form detail:K43:1)
	prtHt_Footer_L:=Get print marker:C708(Form footer:K43:2)
	prtHt_HDR1_L:=Get print marker:C708(Form header1:K43:4)
	prtHt_HDR2_L:=Get print marker:C708(Form header2:K43:5)
	prtHt_HDR1_L:=97  //these two must be defined since for some reason the get print marker returns 0
	prtHt_HDR2_L:=170
	prtHt_Footer_L:=prtHt_Footer_L-prtHt_Det_L
	prtHt_Det_L:=prtHt_Det_L-prtHt_HDR2_L
	prtHt_HDR2_L:=prtHt_HDR2_L-prtHt_HDR1_L
	prtHt_HDR1_L:=prtHt_HDR1_L-prtHt_HDR0_L
	CANCEL:C270
	
Else 
	Case of 
		: (DEFELMTPRINT_Area_txt="Header")
		: (DEFELMTPRINT_Area_txt="Header1")
		: (DEFELMTPRINT_Area_txt="Header2")
		: (DEFELMTPRINT_Area_txt="Detail")
			vItemNo:=INSP_ElmtSfty_ItemNo([ElementsSafety:29]ElementNo:1)
			//Display description
			vElmDescr:=Replace string:C233(GetElmtNumber; " "; "")+" "+[ElementsSafety:29]Description:22
			If (DEFELMTPRINT_EmtCont_b)
				vElmDescr:=vElmDescr+"  (Comnts Cont'd)"
			End if 
			
		: (DEFELMTPRINT_Area_txt="Footer")
		: (DEFELMTPRINT_Area_txt="Break0")
			C_LONGINT:C283($L1; $T1; $R1; $B1; $wdth1; $hght1; $fixed_wdth1; $exact_hght1; $movement1; $position; $final_pos; $l; $t; $r; $b)
			C_LONGINT:C283($htneeded; $prHt; $htPrinted; $MaxCmtHt)
			If (DEFELMTPRINT_BrgHdr_b)
				$MaxCmtHt:=750-204
			Else 
				$MaxCmtHt:=750-204+53
			End if 
			DEFELMTPRINT_LastChar_L:=0
			OBJECT GET COORDINATES:C663(*; "ElmCmts_txt"; $L1; $T1; $R1; $B1)
			$fixed_wdth1:=$r1-$l1  //Calculation of the Summary text field size
			$exact_hght1:=$b1-$t1
			//Optimal size of the field according to its contents
			OBJECT GET BEST SIZE:C717(*; "ElmCmts_txt"; $wdth1; $hght1; $fixed_wdth1)
			If ($hght1>$MaxCmtHt)
				C_LONGINT:C283($Incr_L; $CurPos_L; $PluMinusSide_L)
				C_TEXT:C284($orig_txt)
				$Incr_L:=Length:C16(ElmCmts_txt)
				$CurPos_L:=Length:C16(ElmCmts_txt)
				$orig_txt:=ElmCmts_txt
				C_BOOLEAN:C305($Done_b)
				$PluMinusSide_L:=0
				Repeat 
					$Incr_L:=$Incr_L/2
					If ($Incr_L=0)
						$Incr_L:=1
					End if 
					If ($hght1>$MaxCmtHt)
						If ($Incr_L>1)
							$CurPos_L:=$CurPos_L-$Incr_L
							$PluMinusSide_L:=1
						Else 
							If ($PluMinusSide_L=-1)
								$Done_b:=True:C214
								$CurPos_L:=$CurPos_L-2
							Else 
								$CurPos_L:=$CurPos_L-$Incr_L
								$PluMinusSide_L:=1
							End if 
						End if 
					Else 
						If ($Incr_L>1)
							$CurPos_L:=$CurPos_L+$Incr_L
							$PluMinusSide_L:=-1
						Else 
							If ($PluMinusSide_L=1)
								$Done_b:=True:C214
							Else 
								$CurPos_L:=$CurPos_L+$Incr_L
								$PluMinusSide_L:=-1
							End if 
							
						End if 
					End if 
					ElmCmts_txt:=Substring:C12($orig_txt; 1; $CurPos_L)
					OBJECT GET BEST SIZE:C717(*; "ElmCmts_txt"; $wdth1; $hght1; $fixed_wdth1)
				Until ($Done_b)
				While (Not:C34(FN_AtWordBoundary(Substring:C12($orig_txt; ($CurPos_L-1); 1); Substring:C12($orig_txt; $CurPos_L; 1); Substring:C12($orig_txt; ($CurPos_L+1); 1))))
					$CurPos_L:=$CurPos_L-1  //move back until we find a word boundary
				End while 
				ElmCmts_txt:=Substring:C12($orig_txt; 1; $CurPos_L)
				OBJECT GET BEST SIZE:C717(*; "ElmCmts_txt"; $wdth1; $hght1; $fixed_wdth1)
				DEFELMTPRINT_LastChar_L:=$CurPos_L
			End if 
			
			$movement1:=$hght1-$exact_hght1
			If ($movement1>0)
				//We move the break marker 
				$position:=Get print marker:C708(Form footer:K43:2)
				$final_pos:=$position+$movement1
				SET PRINT MARKER:C709(Form footer:K43:2; $final_pos; *)
				$position:=Get print marker:C708(Form break0:K43:14)
				$final_pos:=$position+$movement1
				SET PRINT MARKER:C709(Form break0:K43:14; $final_pos; *)
				//Resizing of text areas
				OBJECT MOVE:C664(ElmCmts_txt; $l1; $t1; $r1; $hght1+$t1; *)
				//Resizing of rectangles and vert lines
				OBJECT GET COORDINATES:C663(*; "vBox1"; $l; $t; $r; $b)
				OBJECT MOVE:C664(*; "vBox1"; $l; $t; $r; $b+$movement1; *)
				OBJECT GET COORDINATES:C663(*; "vBox2"; $l; $t; $r; $b)
				OBJECT MOVE:C664(*; "vBox2"; $l; $t; $r; $b+$movement1; *)
				
				For ($i; 1; 7; 1)
					OBJECT GET COORDINATES:C663(*; "VLine"+String:C10($i); $l; $t; $r; $b)
					OBJECT MOVE:C664(*; "VLine"+String:C10($i); $l; $t; $r; $b+$movement1; *)
				End for 
			End if 
			$htneeded:=Get print marker:C708(Form break0:K43:14)-Get print marker:C708(Form detail:K43:1)
			If (DEFELMTPRINT_GetHT_B)
				DEFELMTPRINT_MarkerHt_L:=$htneeded
				CANCEL:C270
			Else 
				GET PRINTABLE AREA:C703($prHt)
				$htPrinted:=Get printed height:C702
			End if 
			
	End case 
End if 