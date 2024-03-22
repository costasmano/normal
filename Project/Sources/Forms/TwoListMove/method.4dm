If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/20/07, 12:31:08
	// ----------------------------------------------------
	// Method: Form Method: TwoListMove
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM_5401
	// Modified by: costasmanousakis-(Designer)-(2/13/08 14:11:35)
	Mods_2008_CM_5402
	// `Make Cancel button invisible, if the label is passed as "INVISIBLE"
	// Modified by: Costas Manousakis-(Designer)-(9/1/15 09:55:43)
	Mods_2015_09
	//  `Re-applied stylesheets to objects. 
	
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		C_TEXT:C284(vCancelBtntxt; vOKBtnTxt; vUseListLbl_txt; vOmitLbl_txt)
		OBJECT SET VISIBLE:C603(bCancel; True:C214)
		
		Case of 
			: (vCancelBtntxt="")
				OBJECT SET TITLE:C194(bCancel; "Cancel")
			: (vCancelBtntxt="INVISIBLE")
				OBJECT SET VISIBLE:C603(bCancel; False:C215)
			Else 
				OBJECT SET TITLE:C194(bCancel; vCancelBtntxt)
		End case 
		
		If (vOKBtnTxt="")
			OBJECT SET TITLE:C194(bOK; "OK")
		Else 
			OBJECT SET TITLE:C194(bOK; vOKBtnTxt)
		End if 
		
	: (Form event code:C388=On Resize:K2:27)
		C_LONGINT:C283($UL; $UR; $UW; $OL; $OR; $OW; $NW; $WW; $BW; T; $B; $WL; $WT; $WR; $WB)
		GET WINDOW RECT:C443($WL; $WT; $WR; $WB)
		OBJECT GET COORDINATES:C663(*; "OmitList_HL"; $OL; $T; $OR; $B)
		OBJECT GET COORDINATES:C663(*; "UseList_HL"; $UL; $T; $UR; $B)
		$WW:=$WR-$WL
		$BW:=$OL-$UR
		$NW:=($WW-$BW-40)/2
		OBJECT MOVE:C664(*; "UseList@"; 0; 0; ($NW-($UR-$UL)))
		OBJECT MOVE:C664(*; "Move@"; ($NW-($UR-$UL)); 0)
		OBJECT MOVE:C664(*; "OmitList@"; ($NW-($UR-$UL)); 0; ($NW-($UR-$UL)))
		
End case 