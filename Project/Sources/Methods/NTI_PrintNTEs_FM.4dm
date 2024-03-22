//%attributes = {"invisible":true}
//Method: NTI_PrintNTEs_FM
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/25/16, 15:10:25
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	C_LONGINT:C283(NTI_PrintNTEs_FM; $1)
	
End if 
//
C_LONGINT:C283($FormEvent_L)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
Else 
	$FormEvent_L:=Form event code:C388
End if 

Case of 
	: ($FormEvent_L=On Load:K2:1)
		
		C_TEXT:C284(vBIE)  // old C_STRING length 44
		C_LONGINT:C283($k)  // **Replaced C_LONGINT()//Command Replaced was o_C_INTEGER
		
		$k:=Find in array:C230(aPeople_ID; [Inspections:27]DBrInspEngr:3)
		If ($k>0)
			vBIE:=aPeople{$k}
		Else 
			vBIE:=""
		End if 
	: ($FormEvent_L=On Header:K2:17)
		C_TEXT:C284(v_151_033_txt; v_151_001_txt)
		v_151_001_txt:=[Bridge MHD NBIS:1]BIN:3
		Begin SQL
			select [TunnelInfo].[NTI_i1_s]
			from [TunnelInfo]
			where
			[TunnelInfo].[BIN] = :v_151_001_txt
			into :v_151_033_txt
		End SQL
		//SC vDist on layout [Cond Units];"Cond Units Prt".
		//Copyright © 1997, Thomas D. Nee, All Rights Reserved.
		
		C_TEXT:C284(vDist)  // old C_STRING length 1
		
		vDist:=String:C10(Num:C11([Bridge MHD NBIS:1]Item2:60))
		
		C_TEXT:C284(vBIE)  // old C_STRING length 44
		C_LONGINT:C283($k)  // **Replaced C_LONGINT()//Command Replaced was o_C_INTEGER
		
		$k:=Find in array:C230(aPeople_ID; [Inspections:27]DBrInspEngr:3)
		If ($k>0)
			vBIE:=aPeople{$k}
		Else 
			vBIE:=""
		End if 
		C_TEXT:C284(vTmLeader)  // old C_STRING length 44
		C_LONGINT:C283($k)  // **Replaced C_LONGINT()//Command Replaced was o_C_INTEGER
		
		$k:=Find in array:C230(aPeople_ID; [Inspections:27]TeamLeader:4)
		If ($k>0)
			vTmLeader:=aPeople{$k}
		Else 
			vTmLeader:=""
		End if 
		C_TEXT:C284(vTmMembers)  // old C_STRING length 80
		C_LONGINT:C283($i; $j; $k)  // **Replaced C_LONGINT()//Command Replaced was o_C_INTEGER
		
		ARRAY INTEGER:C220(aInspTeamID; 0)
		//RELATE MANY([BMS Inspections])
		SELECTION TO ARRAY:C260([Field Trip:43]Person ID:2; aInspTeamID)
		$j:=Size of array:C274(aInspTeamID)
		$i:=1
		vTmMembers:=""
		While ($i<=$j) & (Length:C16(vTmMembers)<50)
			If ($i>1)
				vTmMembers:=vTmMembers+", "
			End if 
			$k:=Find in array:C230(aPeople_ID; aInspTeamID{$i})
			If ($k>0)
				vTmMembers:=vTmMembers+aPeople{$k}
			Else 
				vTmMembers:=vTmMembers+"Invalid Person ID"
			End if 
			$i:=$i+1
		End while 
		
		If ($i<=$j)
			vTmMembers:=vTmMembers+", et al."
		End if 
		
	: ($FormEvent_L=On Printing Detail:K2:18)
		C_LONGINT:C283($formFooter_L; $printed_L; $totalHt; $totalW; $formBreak_L; $FormDetail_L; $break_footer_L; $FormHeader_L)
		$FormHeader_L:=Get print marker:C708(Form header:K43:3)
		$FormDetail_L:=Get print marker:C708(Form detail:K43:1)
		$formBreak_L:=Get print marker:C708(Form break0:K43:14)
		$formFooter_L:=Get print marker:C708(Form footer:K43:2)
		$break_footer_L:=$formFooter_L-$FormDetail_L
		$printed_L:=Get printed height:C702
		GET PRINTABLE AREA:C703($totalHt; $totalW)
		Case of 
			: (NTI_PrintSection_txt="Detail")
				NTI_LoadLB_elemInfo(->PON_NBE_LB_ELEMDESC_TXT; ->PON_NBE_LB_ELEMU_TXT; ->PON_NBE_LB_QP_TXT; ->[NTI_ELEM_BIN_INSP:183])
				C_TEXT:C284($QFormat_txt)
				If (PON_NBE_LB_ELEMU_TXT="each")
					$QFormat_txt:="###,###,###,###,##0;;"
					OBJECT SET FORMAT:C236(vTotQ; $QFormat_txt)
				Else 
					$QFormat_txt:="###,###,###,###,##0.000;;"
					OBJECT SET FORMAT:C236(vTotQ; "###,###,###,###,##0.000;;")
				End if 
				
				If ([NTI_ELEM_BIN_INSP:183]ELEM_QorP:16)
					PON_NBE_LB_CS1_r:=[NTI_ELEM_BIN_INSP:183]ELEM_QTYSTATE1:17
					PON_NBE_LB_CS2_r:=[NTI_ELEM_BIN_INSP:183]ELEM_QTYSTATE2:18
					PON_NBE_LB_CS3_r:=[NTI_ELEM_BIN_INSP:183]ELEM_QTYSTATE3:19
					PON_NBE_LB_CS4_r:=[NTI_ELEM_BIN_INSP:183]ELEM_QTYSTATE4:20
					
					OBJECT SET FORMAT:C236(PON_NBE_LB_CS1_r; $QFormat_txt)
					OBJECT SET FORMAT:C236(PON_NBE_LB_CS2_r; $QFormat_txt)
					OBJECT SET FORMAT:C236(PON_NBE_LB_CS3_r; $QFormat_txt)
					OBJECT SET FORMAT:C236(PON_NBE_LB_CS4_r; $QFormat_txt)
					
				Else 
					PON_NBE_LB_CS1_r:=Round:C94([NTI_ELEM_BIN_INSP:183]ELEM_PCTSTATE1:12; 2)
					PON_NBE_LB_CS2_r:=Round:C94([NTI_ELEM_BIN_INSP:183]ELEM_PCTSTATE2:13; 2)
					PON_NBE_LB_CS3_r:=Round:C94([NTI_ELEM_BIN_INSP:183]ELEM_PCTSTATE3:14; 2)
					PON_NBE_LB_CS4_r:=Round:C94([NTI_ELEM_BIN_INSP:183]ELEM_PCTSTATE4:15; 2)
					OBJECT SET FORMAT:C236(PON_NBE_LB_CS1_r; "###,###,###,###,##0.00;;")
					OBJECT SET FORMAT:C236(PON_NBE_LB_CS2_r; "###,###,###,###,##0.00;;")
					OBJECT SET FORMAT:C236(PON_NBE_LB_CS3_r; "###,###,###,###,##0.00;;")
					OBJECT SET FORMAT:C236(PON_NBE_LB_CS4_r; "###,###,###,###,##0.00;;")
				End if 
				Pon_ElemKey_txt:=NTI_ElemKeyTxt
				QUERY:C277([NTI_ELEM_DEFS:182]; [NTI_ELEM_DEFS:182]ELEM_KEY:4=[NTI_ELEM_BIN_INSP:183]ELEM_KEY:3)
				C_LONGINT:C283($style_L; $background_L)
				Case of 
					: ([NTI_ELEM_DEFS:182]DEFECTFLAG:10="Y")
						$style_L:=Italic:K14:3
						$background_L:=-(Black:K11:16+(256*White:K11:1))
					Else 
						$style_L:=Bold:K14:2
						$background_L:=-(Black:K11:16+(256*(15*16+1)))  //light grey - 2nd block on the last row of the 4D color 'chart'
				End case 
				OBJECT SET FONT STYLE:C166(Pon_ElemKey_txt; $style_L)
				OBJECT SET FONT STYLE:C166(PON_NBE_LB_ELEMDESC_TXT; $style_L)
				OBJECT SET RGB COLORS:C628(*; "PON_BackgroundLine"; Col_paletteToRGB(Abs:C99($background_L)%256); Col_paletteToRGB(Abs:C99($background_L)\256))  // **Replaced o OBJECT SET COLOR(*; "PON_BackgroundLine"; $background_L)
				
				vTotQ:=[NTI_ELEM_BIN_INSP:183]ELEM_QUANTITY:21
				
				OBJECT SET VISIBLE:C603(*; "CHKLINE@"; Not:C34([NTI_ELEM_BIN_INSP:183]ELEM_QorP:16))
				$printed_L:=Get printed height:C702
				//check space left
				//space needed = formFooter-FormHeader
				If (($printed_L+($formFooter_L-$FormHeader_L))>$totalHt)
					CANCEL:C270
				End if 
			: (NTI_PrintSection_txt="Header")
				NTI_PrintNTEs_FM(On Load:K2:1)
				NTI_PrintNTEs_FM(On Header:K2:17)
				$printed_L:=Get printed height:C702
				
			: (NTI_PrintSection_txt="Break0")
				SET PRINT MARKER:C709(Form break0:K43:14; $formBreak_L+($totalHt-($printed_L+$break_footer_L)); *)
				
			: (NTI_PrintSection_txt="Footer")
				NTI_PrintNTEs_FM(On Printing Footer:K2:20)
		End case 
		
	: ($FormEvent_L=On Printing Footer:K2:20)
		vPageNo:=vPageNo+1
		vPage:="Page "+String:C10(vPageNo)
		
End case 


//End NTI_PrintNBEs_FM