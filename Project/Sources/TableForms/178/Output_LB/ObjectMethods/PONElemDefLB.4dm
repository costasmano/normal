//Method: [PON_ELEM_DEFS];"Output_LB".List Box
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Sep 28, 2022, 15:30:00
	Mods_2022_09
	// ----------------------------------------------------
	
End if 
//
C_LONGINT:C283($LBCol_L; LBRow_L)
C_TEXT:C284($lbName)
$lbName:=OBJECT Get name:C1087(Object current:K67:2)
C_POINTER:C301($currTable; $lb_ptr)
$currTable:=Current form table:C627
$lb_ptr:=OBJECT Get pointer:C1124(Object current:K67:2)
Case of 
	: (Form event code:C388=On Header Click:K2:40)
		
	: (Form event code:C388=On Display Detail:K2:22)
		
	: (Form event code:C388=On Double Clicked:K2:5)
		
		If (Not:C34(InDoubleClick_B))
			InDoubleClick_B:=True:C214
			
			LISTBOX GET CELL POSITION:C971(*; $lbName; $LBCol_L; LBRow_L)
			If (LBRow_L>0) & (LBRow_L<=Records in selection:C76($currTable->))
				COPY NAMED SELECTION:C331($currTable->; "$LBSelection")
				
				GOTO SELECTED RECORD:C245($currTable->; LBRow_L)
				If (ut_LoadRecordInteractiveV2($currTable)=1)
					C_LONGINT:C283($wl; $wt; $wr; $wb; $ol; $ot; $or; $ob; $ww; $wh)
					GET WINDOW RECT:C443($wl; $wt; $wr; $wb)
					$ww:=$wr-$wl
					$wh:=$wb-$wt
					OBJECT GET COORDINATES:C663(*; $lbName; $ol; $ot; $or; $ob)
					FORM SET INPUT:C55($currTable->; "Input")
					MODIFY RECORD:C57($currTable->)
					
					InDoubleClick_B:=False:C215
					
					GET WINDOW RECT:C443($wl; $wt; $wr; $wb)
					
					SET WINDOW RECT:C444($wl; $wt; $wl+$ww; $wt+$wh)
					OBJECT GET COORDINATES:C663(*; $lbName; $wl; $wt; $wr; $wb)
					
					OBJECT MOVE:C664(*; $lbName; 0; 0; $or-$wr; $ob-$wb)
					
					If (In transaction:C397)
						CANCEL TRANSACTION:C241
					End if 
					USE NAMED SELECTION:C332("$LBSelection")
					CLEAR NAMED SELECTION:C333("$LBSelection")
					
					LISTBOX SELECT ROW:C912(*; $lbName; LBRow_L)
					OBJECT SET SCROLL POSITION:C906(*; $lbName; LBRow_L)
					ut_SetReadWrite("read"; $currTable)
					REDRAW:C174($lb_ptr->)
				End if 
				
				WIN_SetWindowTitle($currTable)
				
			Else 
				InDoubleClick_B:=False:C215
			End if 
		End if 
	: (Form event code:C388=On Load:K2:1)
		WIN_SetWindowTitle(->[NTI_ELEM_DEFS:182])
		InDoubleClick_B:=False:C215
End case 

//End [PON_ELEM_DEFS];"Output_LB".List Box