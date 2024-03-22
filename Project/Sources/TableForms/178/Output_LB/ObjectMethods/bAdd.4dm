//Method: [PON_ELEM_DEFS];"Output_LB".bAdd
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Sep 28, 2022, 15:36:43
	Mods_2022_09
	// ----------------------------------------------------
	
End if 
//

C_POINTER:C301($currTable)
$currTable:=Current form table:C627
C_TEXT:C284($LBName)
$LBName:="PONElemDefLB"

CREATE SET:C116($currTable->; "$BeforeAdd")
FORM SET INPUT:C55($currTable->; LISTBOX Get property:C917(*; $LBName; lk detail form name:K53:44))
C_LONGINT:C283($wl; $wt; $wr; $wb; $ol; $ot; $or; $ob; $LBCol_L; $LBRow_L)

GET WINDOW RECT:C443($wl; $wt; $wr; $wb)
OBJECT GET COORDINATES:C663(*; $LBName; $ol; $ot; $or; $ob)
LISTBOX GET CELL POSITION:C971(*; $LBName; $LBCol_L; $LBRow_L)
If ($LBRow_L<1)
	$LBRow_L:=1
End if 
ADD RECORD:C56($currTable->)
SET WINDOW RECT:C444($wl; $wt; $wr; $wb)
OBJECT GET COORDINATES:C663(*; $LBName; $wl; $wt; $wr; $wb)

OBJECT MOVE:C664(*; $LBName; 0; 0; $or-$wr; $ob-$wb)

If (OK=1)
	//Add to list
	
	LISTBOX SELECT ROW:C912(*; $LBName; LBRow_L)
	
	OBJECT SET SCROLL POSITION:C906(*; $LBName; LBRow_L; *)
	
Else 
	If (In transaction:C397)
		CANCEL TRANSACTION:C241
	End if 
	LISTBOX SELECT ROW:C912(*; $LBName; $LBRow_L)
	
	OBJECT SET SCROLL POSITION:C906(*; $LBName; $LBRow_L; *)
	
End if 
CLEAR SET:C117("$BeforeAdd")

WIN_SetWindowTitle($currTable)
//End [PON_ELEM_DEFS];"Output_LB".bAdd  