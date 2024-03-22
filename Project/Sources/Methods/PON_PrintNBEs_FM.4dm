//%attributes = {"invisible":true}
// Method: PON_PrintNBEs_FM
// Description
// form method to print NBEs
// 
// Parameters
// $1 : $FormEvent_L
// ----------------------------------------------------
If (False:C215)
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 04/01/15, 17:16:04
	// ----------------------------------------------------
	// First Release
	Mods_2015_04
	// Modified by: Costas Manousakis-(Designer)-(8/5/16)
	Mods_2016_08
	//  `new way of printing by using print form instead of print selection.
	// Modified by: Costas Manousakis-(Designer)-(12/16/16 11:51:33)
	Mods_2016_12
	//  `added printing of element notes
	// Modified by: Costas Manousakis-(Designer)-(12/19/16 11:51:33)
	Mods_2016_12
	//  `use Print_TrimText
	// Modified by: Costas Manousakis-(Designer)-(8/29/17 12:50:03)
	Mods_2017_08_bug
	//  `fix problem with element comments not printing correctly when spaning pages
End if 
C_LONGINT:C283($FormEvent_L)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
Else 
	$FormEvent_L:=Form event code:C388
End if 

Case of 
	: ($FormEvent_L=On Load:K2:1)
		
		C_TEXT:C284(vBIE)  // Command Replaced was o_C_STRING length was 44
		C_LONGINT:C283($k)  //Command Replaced was o_C_INTEGER
		
		$k:=Find in array:C230(aPeople_ID; [BMS Inspections:44]DBrInspEngr:5)
		If ($k>0)
			vBIE:=aPeople{$k}
		Else 
			vBIE:=""
		End if 
		
	: ($FormEvent_L=On Header:K2:17)
		
		C_TEXT:C284(vBIE)  // Command Replaced was o_C_STRING length was 44
		C_LONGINT:C283($i; $j; $k)
		
		$k:=Find in array:C230(aPeople_ID; [BMS Inspections:44]DBrInspEngr:5)
		If ($k>0)
			vBIE:=aPeople{$k}
		Else 
			vBIE:=""
		End if 
		
		C_TEXT:C284(vTmLeader)  // Command Replaced was o_C_STRING length was 44
		
		$k:=Find in array:C230(aPeople_ID; [BMS Inspections:44]TeamLeader:6)
		If ($k>0)
			vTmLeader:=aPeople{$k}
		Else 
			vTmLeader:=""
		End if 
		
		C_TEXT:C284(vTmMembers)  // Command Replaced was o_C_STRING length was 80
		
		ARRAY INTEGER:C220(aInspTeamID; 0)
		//RELATE MANY([BMS Inspections])
		SELECTION TO ARRAY:C260([BMS Field Trip:56]Person ID:2; aInspTeamID)
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
		
		C_TEXT:C284(vDist)  // Command Replaced was o_C_STRING length was 1
		
		vDist:=String:C10(Num:C11([Bridge MHD NBIS:1]Item2:60))
		
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
				
				PON_LoadLB_elemInfo(->PON_NBE_LB_ELEMDESC_TXT; ->PON_NBE_LB_ELEMU_TXT; ->PON_NBE_LB_QP_TXT)
				C_TEXT:C284($QFormat_txt)
				If (PON_NBE_LB_ELEMU_TXT="each")
					$QFormat_txt:="###,###,###,###,##0;;"
					OBJECT SET FORMAT:C236(vTotQ; $QFormat_txt)
				Else 
					$QFormat_txt:="###,###,###,###,##0.000;;"
					OBJECT SET FORMAT:C236(vTotQ; "###,###,###,###,##0.000;;")
				End if 
				
				If ([PON_ELEM_INSP:179]ELEM_QorP:29)
					PON_NBE_LB_CS1_r:=[PON_ELEM_INSP:179]ELEM_QTYSTATE1:13
					PON_NBE_LB_CS2_r:=[PON_ELEM_INSP:179]ELEM_QTYSTATE2:14
					PON_NBE_LB_CS3_r:=[PON_ELEM_INSP:179]ELEM_QTYSTATE3:15
					PON_NBE_LB_CS4_r:=[PON_ELEM_INSP:179]ELEM_QTYSTATE4:16
					
					OBJECT SET FORMAT:C236(PON_NBE_LB_CS1_r; $QFormat_txt)
					OBJECT SET FORMAT:C236(PON_NBE_LB_CS2_r; $QFormat_txt)
					OBJECT SET FORMAT:C236(PON_NBE_LB_CS3_r; $QFormat_txt)
					OBJECT SET FORMAT:C236(PON_NBE_LB_CS4_r; $QFormat_txt)
					
				Else 
					PON_NBE_LB_CS1_r:=Round:C94([PON_ELEM_INSP:179]ELEM_PCTSTATE1:9; 2)
					PON_NBE_LB_CS2_r:=Round:C94([PON_ELEM_INSP:179]ELEM_PCTSTATE2:10; 2)
					PON_NBE_LB_CS3_r:=Round:C94([PON_ELEM_INSP:179]ELEM_PCTSTATE3:11; 2)
					PON_NBE_LB_CS4_r:=Round:C94([PON_ELEM_INSP:179]ELEM_PCTSTATE4:12; 2)
					OBJECT SET FORMAT:C236(PON_NBE_LB_CS1_r; "###,###,###,###,##0.00;;")
					OBJECT SET FORMAT:C236(PON_NBE_LB_CS2_r; "###,###,###,###,##0.00;;")
					OBJECT SET FORMAT:C236(PON_NBE_LB_CS3_r; "###,###,###,###,##0.00;;")
					OBJECT SET FORMAT:C236(PON_NBE_LB_CS4_r; "###,###,###,###,##0.00;;")
				End if 
				Pon_ElemKey_txt:=PON_ElemKeytxt
				QUERY:C277([PON_ELEM_DEFS:178]; [PON_ELEM_DEFS:178]ELEM_KEY:1=[PON_ELEM_INSP:179]ELEM_KEY:3)
				C_LONGINT:C283($style_L; $background_L)
				Case of 
					: ([PON_ELEM_DEFS:178]ELEM_SMART_FLAG:4="Y")
						$style_L:=Italic:K14:3
						$background_L:=-(Black:K11:16+(256*White:K11:1))
					: ([PON_ELEM_DEFS:178]ELEM_PROTECT_SYS:3="Y")
						$style_L:=Plain:K14:1
						$background_L:=-(Black:K11:16+(256*White:K11:1))
					Else 
						$style_L:=Bold:K14:2
						$background_L:=-(Black:K11:16+(256*(15*16+1)))  //light grey - 2nd block on the last row of the 4D color 'chart'
				End case 
				OBJECT SET FONT STYLE:C166(Pon_ElemKey_txt; $style_L)
				OBJECT SET FONT STYLE:C166(PON_NBE_LB_ELEMDESC_TXT; $style_L)
				OBJECT SET RGB COLORS:C628(*; "PON_BackgroundLine"; Col_paletteToRGB(Abs:C99($background_L)%256); Col_paletteToRGB(Abs:C99($background_L)\256))  // **Replaced o OBJECT SET COLOR(*; "PON_BackgroundLine"; $background_L)
				
				vTotQ:=[PON_ELEM_INSP:179]ELEM_QUANTITY:7
				
				OBJECT SET VISIBLE:C603(*; "CHKLINE@"; Not:C34([PON_ELEM_INSP:179]ELEM_QorP:29))
				
				ARRAY TEXT:C222($currformObj_atxt; 0)
				ARRAY POINTER:C280($currformVars_aptr; 0)
				FORM GET OBJECTS:C898($currformObj_atxt; $currformVars_aptr)
				If (Find in array:C230($currformVars_aptr; (->v_179_020_txt))>0)
					C_LONGINT:C283($wdth1; $hght1; $fixed_wdth1; $exact_hght1; $L1; $T1; $R1; $B1; $movement1; $position; $final_pos; $available_L; $needed_L)
					//working with form that has the element notes
					C_TEXT:C284(v_179_020_txt; $noteheader_txt)  //ELEM_NOTES
					v_179_020_txt:=""
					
					OBJECT GET COORDINATES:C663(*; "v_179_020_txt"; $L1; $T1; $R1; $B1)
					$noteheader_txt:=""
					C_LONGINT:C283($moveUp_L)
					If (v_179_006_L>0)
						//start notes from the middle - note overflow to another page
						v_179_020_txt:=Substring:C12([PON_ELEM_INSP:179]ELEM_NOTES:20; v_179_006_L)
						v_179_020_txt:=f_TrimStr(v_179_020_txt; True:C214; True:C214)
						$noteheader_txt:="Element "+String:C10([PON_ELEM_INSP:179]ELEM_KEY:3)+", "+PON_NBE_LB_ELEMDESC_TXT+", Environment "+String:C10([PON_ELEM_INSP:179]ENVKEY:5)+" (Notes contd.)"+<>sCR
						v_179_020_txt:=$noteheader_txt+v_179_020_txt
						OBJECT SET VISIBLE:C603(*; "Variable@"; False:C215)
						OBJECT SET VISIBLE:C603(*; "Line@"; False:C215)
						OBJECT SET VISIBLE:C603(*; "Line1"; True:C214)
						OBJECT SET VISIBLE:C603(*; "Field@"; False:C215)
						OBJECT SET VISIBLE:C603(*; "Rectangle1"; False:C215)  //Q or % checkbox 
						OBJECT SET VISIBLE:C603(*; "Text21"; False:C215)  //Q or % text 
						OBJECT SET VISIBLE:C603(*; "PON_BackgroundLine@"; False:C215)
						$moveUp_L:=-27
						OBJECT MOVE:C664(*; "v_179_020_txt"; 0; $moveUp_L)
						OBJECT MOVE:C664(*; "Notes@"; 0; $moveUp_L)
						
					Else 
						$moveUp_L:=0
						v_179_020_txt:=[PON_ELEM_INSP:179]ELEM_NOTES:20
						v_179_020_txt:=f_TrimStr(v_179_020_txt; True:C214; True:C214)
					End if 
					
					OBJECT GET COORDINATES:C663(*; "v_179_020_txt"; $L1; $T1; $R1; $B1)
					$fixed_wdth1:=$r1-$l1  //Calculation of the Summary text field size
					$exact_hght1:=$b1-$t1
					OBJECT GET BEST SIZE:C717(*; "v_179_020_txt"; $wdth1; $hght1; $fixed_wdth1)
					$movement1:=$hght1-$exact_hght1
					If ($movement1>0)
						$available_L:=$totalHt-$printed_L-($formFooter_L-$FormDetail_L)  //space available for the text current record
						$available_L:=$available_L-($T1-$FormHeader_L)  //space available for the text object
						
						C_LONGINT:C283($newTrim_L)
						$newTrim_L:=Print_TrimText(->v_179_020_txt; $available_L)  //trim the text
						
						Case of 
							: ($newTrim_L=0)
								v_179_006_L:=0
							: (v_179_006_L>0)
								v_179_006_L:=v_179_006_L+$newTrim_L-Length:C16($noteheader_txt)
							Else 
								v_179_006_L:=v_179_006_L+$newTrim_L+1-Length:C16($noteheader_txt)
						End case 
						
						//get new movement - variable may have been updated
						OBJECT GET BEST SIZE:C717(*; "v_179_020_txt"; $wdth1; $hght1; $fixed_wdth1)
						$movement1:=$hght1-$exact_hght1
						
						$movement1:=$movement1+$moveUp_L  //take into account the moving of the notes
						//need to move all markers below the detail marker too. footer and break0 
						//$position:=Get print marker(Form footer)
						//$final_pos:=$position+$movement1
						//SET PRINT MARKER(Form footer;$final_pos;*)
						//$formFooter_L:=Get print marker(Form footer)
						//$position:=Get print marker(Form break0)
						//$final_pos:=$position+$movement1
						//SET PRINT MARKER(Form break0;$final_pos;*)
						//$position:=Get print marker(Form detail)
						$final_pos:=$hght1+$t1+1  //move detail 1 pixel below the new bottom of the text box
						//moving the detail marker moves all others below it
						SET PRINT MARKER:C709(Form detail:K43:1; $final_pos; *)
						OBJECT MOVE:C664(*; "v_179_020_txt"; $l1; $t1; $r1; $hght1+$t1; *)
						OBJECT GET COORDINATES:C663(*; "Rectangle6"; $l; $t; $r; $b)
						OBJECT MOVE:C664(*; "Rectangle6"; $l; $t; $r; $b+$movement1; *)
						
					End if 
					
				End if 
				
				//$printed_L:=Get printed height
				//check space left
				//space needed = formFooter-FormHeader
				$formFooter_L:=Get print marker:C708(Form footer:K43:2)  // footer maybe moved
				
				If (($printed_L+($formFooter_L-$FormHeader_L))>$totalHt)
					CANCEL:C270
				End if 
				
			: (NTI_PrintSection_txt="Header")
				PON_PrintNBEs_FM(On Load:K2:1)
				PON_PrintNBEs_FM(On Header:K2:17)
				$printed_L:=Get printed height:C702
				
			: (NTI_PrintSection_txt="Break0")
				SET PRINT MARKER:C709(Form break0:K43:14; $formBreak_L+($totalHt-($printed_L+$break_footer_L)); *)
				
			: (NTI_PrintSection_txt="Footer")
				PON_PrintNBEs_FM(On Printing Footer:K2:20)
		End case 
		
	: ($FormEvent_L=On Printing Footer:K2:20)
		vPage:="Page "+String:C10(Printing page:C275)
		
End case 