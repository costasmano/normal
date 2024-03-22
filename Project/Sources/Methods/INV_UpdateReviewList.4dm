//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/13/06, 17:29:41
	// ----------------------------------------------------
	// Method: INV_UpdateReviewList
	// Description
	// 
	// 
	// Parameters
	// $1 : ArrayElmt : Longint
	// ----------------------------------------------------
	Mods_2007_CM02
End if 

C_LONGINT:C283($1; $arrayElmt; $InvInspFound_L)
$arrayElmt:=$1
SET QUERY DESTINATION:C396(Into variable:K19:4; $InvInspFound_L)
QUERY SELECTION:C341([InventoryPhotoInsp:112]; [InventoryPhotoInsp:112]InvPhotoInspID_L:1=InvPhotoInspID_aL{$arrayElmt})
SET QUERY DESTINATION:C396(Into current selection:K19:1)
If ($InvInspFound_L#1)
	//deleted inspection
	DELETE FROM ARRAY:C228(InvPhotoInspID_aL; $arrayElmt; 1)
	DELETE FROM ARRAY:C228(InvPhotoInspBIN_as; $arrayElmt; 1)
	DELETE FROM ARRAY:C228(InvPhotoInspBDEPT_as; $arrayElmt; 1)
	DELETE FROM ARRAY:C228(invPhotoInspDate_aD; $arrayElmt; 1)
	DELETE FROM ARRAY:C228(InvPhotoInspTmLdr_as; $arrayElmt; 1)
	DELETE FROM ARRAY:C228(invPhotoInspCompl_ab; $arrayElmt; 1)
	DELETE FROM ARRAY:C228(invPhotoInspAppr_aP; $arrayElmt; 1)
	If ($arrayElmt>Size of array:C274(InvPhotoInspID_aL))
		InvPhotoInspID_aL:=Size of array:C274(InvPhotoInspID_aL)
	End if 
Else 
	C_PICTURE:C286($PicFromLib; $BlankPic; $PicFromLibAppr; $PicFromLibRej)
	$BlankPic:=$BlankPic*0
	GET PICTURE FROM LIBRARY:C565("BMS ApproveIcon"; $PicFromLibAppr)
	GET PICTURE FROM LIBRARY:C565("BMS RejectIcon"; $PicFromLibRej)
	C_LONGINT:C283($TmLdr_L; $PersonPos_L)
	C_LONGINT:C283($InvApprvStat_I)  //Command Replaced was o_C_INTEGER
	C_BOOLEAN:C305($InvCompl_b)
	$TmLdr_L:=[InventoryPhotoInsp:112]TeamLeader_I:5
	$InvCompl_b:=[InventoryPhotoInsp:112]Complete_B:9
	$InvApprvStat_I:=[InventoryPhotoInsp:112]Approved_I:6
	Case of 
		: ($InvApprvStat_I=BMS Approved)
			$PicFromLib:=$PicFromLibAppr
		: ($InvApprvStat_I=BMS Rejected)
			$PicFromLib:=$PicFromLibRej
		Else 
			$PicFromLib:=$BlankPic*29
	End case 
	invPhotoInspAppr_aP{$arrayElmt}:=$PicFromLib
	$PersonPos_L:=Find in array:C230(aPeople_ID; $TmLdr_L)
	If ($PersonPos_L>0)
		InvPhotoInspTmLdr_as{$arrayElmt}:=aPeople{$PersonPos_L}
	Else 
		InvPhotoInspTmLdr_as{$arrayElmt}:=""
	End if 
	If ($InvCompl_b)
		invPhotoInspCompl_ab{$arrayElmt}:="x"
	Else 
		invPhotoInspCompl_ab{$arrayElmt}:="o"
	End if 
	$PicFromLib:=$BlankPic
	$PicFromLibAppr:=$BlankPic
	$PicFromLibRej:=$BlankPic
	
End if 
