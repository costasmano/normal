If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(12/5/2005 10:37:27)
	Mods_2005_CM19
	Mods_2011_06  // CJ Miller`06/20/11, 11:40:48      ` Type all local variables for v11
End if 

Case of 
	: (Form event code:C388=On Printing Detail:K2:18)
		C_TEXT:C284(vPrintArea_S)  // Command Replaced was o_C_STRING length was 8
		If ([Work_Estimate:103]AddendumNo:29=0)
			OBJECT SET VISIBLE:C603(*; "Addend@"; False:C215)
		Else 
			OBJECT SET VISIBLE:C603(*; "Addend@"; True:C214)
		End if 
		
		If (vPrintArea_S="Detail")
			C_LONGINT:C283($l; $t; $r; $b; $FixW; $FixH; $wdth; $hght; $movement; $markerPos; $CurHt; $detail_pos; $header_pos; $hght_to_print; $hght_remaining)
			OBJECT GET COORDINATES:C663(ItemCmmts_Txt; $l; $t; $r; $b)
			$FixW:=$r-$l  //Calculation of the text field size
			$FixH:=$b-$t
			OBJECT GET BEST SIZE:C717(ItemCmmts_Txt; $wdth; $hght; $FixW)
			$CurHt:=Get printed height:C702
			If ($hght>$FixH)
				$movement:=$hght-$FixH
				$markerPos:=Get print marker:C708(Form detail:K43:1)
				SET PRINT MARKER:C709(Form detail:K43:1; ($markerPos+$movement); *)
				//Now Change size
				OBJECT MOVE:C664(ItemCmmts_Txt; 0; 0; 0; $movement)
			End if 
			C_LONGINT:C283($detailPos_L; $HeaderPos_L; $htToPrint_L; $HtRemaining_L; $PrintableHt_L; $PrintableW_L; $PrintedHt_L)
			$detail_pos:=Get print marker:C708(Form detail:K43:1)
			$header_pos:=Get print marker:C708(Form header:K43:3)
			$hght_to_print:=$detail_pos-$header_pos
			GET PRINTABLE AREA:C703($PrintableHt_L; $PrintableW_L)
			$PrintedHt_L:=Get printed height:C702
			$hght_remaining:=$PrintableHt_L-$PrintedHt_L
			If (($hght_remaining<$hght_to_print) & ($PrintedHt_L>$header_pos))  //if not enought and not the first item on page.
				CANCEL:C270  //Move form to the next page
			End if 
		End if 
End case 