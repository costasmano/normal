If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/09/07, 08:42:17
	// ----------------------------------------------------
	// Method: Form Method: ResetDialog
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM12_5301  //Added
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		//Define these to be used in the object methods - 
		C_POINTER:C301(RSTDLG_Array1_ptr; RSTDLG_Array2_ptr)
		RSTDLG_Array1_ptr:=->aFilesToBeFixed
		RSTDLG_Array2_ptr:=->aFilesToBeSkipped
		RSTDLG_MoveElements_OM("BUTTONS")
		
	: (Form event code:C388=On Validate:K2:3)
	: (Form event code:C388=On Resize:K2:27)
		C_LONGINT:C283($WL; $WT; $WR; $WB; $Ww; $Wh; $OT; $OL; $OB; $OR; $OL2; $OT2; $OR2; $OB2; $OL1; $OT1; $OR1; $OB1; $OL3; $OT3; $OR3; $OB3; $BTNW)
		GET WINDOW RECT:C443($WL; $WT; $WR; $WB)
		$Ww:=$WR-$WL
		OBJECT GET COORDINATES:C663(*; "Scroll2"; $OL2; $OT2; $OR2; $OB2)
		OBJECT GET COORDINATES:C663(*; "Scroll1"; $OL1; $OT1; $OR1; $OB1)
		OBJECT GET COORDINATES:C663(*; "MoveButton@"; $OL3; $OT3; $OR3; $OB3)
		OBJECT GET COORDINATES:C663(*; "Button@"; $OL4; $OT4; $OR4; $OB4)
		
		C_LONGINT:C283($BTNW; $MIDL; $MH2; $RH2; $RH1; $MHb; $SW; $BTNMID; $BTNMH)
		$BTNW:=$OR3-$OL3+20
		$MIDL:=($OR2-$OL1)/2
		$RH2:=0
		$RH1:=0
		$MHb:=(($OR2+$OL1)/2)-(($OR3+$OL3)/2)
		If ($MHb#0)  //if the middle buttons don't move then the rest would not need to move either.
			$MH2:=0
			$SW:=$MIDL-($BTNW/2)
			$RH1:=$SW-($OR1-$OL1)
			$MH2:=$OL1+$SW+$BTNW-$OL2
			$RH2:=$RH1
			$BTNMH:=(($OR2+$OL1)/2)-(($OR4+$OL4)/2)
			OBJECT MOVE:C664(*; "Scroll1"; 0; 0; $RH1)
			OBJECT MOVE:C664(*; "Text1"; 0; 0; $RH1)
			OBJECT MOVE:C664(*; "Scroll2"; $MH2; 0; $RH2)
			OBJECT MOVE:C664(*; "Text2"; $MH2; 0; $RH2)
			OBJECT MOVE:C664(*; "Move@"; $MHb; 0)
			OBJECT MOVE:C664(*; "Button@"; $BTNMH; 0)
		End if 
		
End case 