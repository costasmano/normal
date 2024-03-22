If (False:C215)
	Mods_2005_CM21
End if 
C_LONGINT:C283($NewTextTop; $txtL; $txtT; $txtR; $txtB; $txtMove; $Wl; $Wt; $Wr; $Wb)  //Command Replaced was o_C_INTEGER
OBJECT GET COORDINATES:C663(*; "ItemComments@"; $txtL; $txtT; $txtR; $txtB)
GET WINDOW RECT:C443($Wl; $Wt; $Wr; $Wb)

If (Self:C308->=1)
	WKHR_CommentsShown:=True:C214
	$txtMove:=80
	$NewTextTop:=WKHR_SetCmmtTxtTop
	OBJECT MOVE:C664(*; "ItemComments@"; $txtL; $NewTextTop; $txtR; $NewTextTop; *)
	GOTO OBJECT:C206(*; "ItemComments")
Else 
	WKHR_CommentsShown:=False:C215
	$NewTextTop:=WKHR_SetCmmtTxtTop
	$txtMove:=0
End if 
SET WINDOW RECT:C444($Wl; $Wt; $Wr; ($Wt+$NewTextTop+$txtMove+WKHR_LineEntryFormMargin))
OBJECT MOVE:C664(*; "ItemComments@"; $txtL; $NewTextTop; $txtR; ($NewTextTop+$txtMove); *)
OBJECT SET VISIBLE:C603(*; "ItemComments@"; WKHR_CommentsShown)
OBJECT SET ENTERABLE:C238(*; "ItemComments@"; WKHR_CommentsShown)
