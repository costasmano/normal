//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/12/06, 22:58:35
	// ----------------------------------------------------
	// Method: INV_DisplayInvInspections
	// Description
	// Define Arrays to display Invent Photo Inspections
	// 
	// Parameters
	// $1 : ForReviewList (optional) : Boolean 
	// ----------------------------------------------------
	Mods_2007_CM02
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v11
End if 
C_BOOLEAN:C305($1; $ForReviewList_b)
If (Count parameters:C259=1)
	$ForReviewList_b:=$1
Else 
	$ForReviewList_b:=False:C215
End if 

ARRAY LONGINT:C221(InvPhotoInspID_aL; 0)
ARRAY LONGINT:C221(InvPhotoInspRecNum_aL; 0)
ARRAY DATE:C224(invPhotoInspDate_aD; 0)
ARRAY BOOLEAN:C223($invPhotoInspCompl_ab; 0)
ARRAY INTEGER:C220(invPhotoInspAppr_aI; 0)
ARRAY PICTURE:C279(invPhotoInspAppr_aP; 0)
C_PICTURE:C286($PicFromLib; $BlankPic; $PicFromLibAppr; $PicFromLibRej)
$BlankPic:=$BlankPic*0
C_LONGINT:C283($PersonPos_L; $NumInvPhotoInsp_L)

GET PICTURE FROM LIBRARY:C565("BMS ApproveIcon"; $PicFromLibAppr)
GET PICTURE FROM LIBRARY:C565("BMS RejectIcon"; $PicFromLibRej)
If ($ForReviewList_b)
	ARRAY TEXT:C222(InvPhotoInspBIN_as; 0)  //Command Replaced was o_ARRAY string length was 3
	ARRAY TEXT:C222(InvPhotoInspBDEPT_as; 0)  //Command Replaced was o_ARRAY string length was 6
	ARRAY INTEGER:C220($TmLdrs; 0)
End if 
LONGINT ARRAY FROM SELECTION:C647([InventoryPhotoInsp:112]; InvPhotoInspRecNum_aL)
SELECTION TO ARRAY:C260([InventoryPhotoInsp:112]InvPhotoInspID_L:1; InvPhotoInspID_aL; [InventoryPhotoInsp:112]InvPhotoDate_D:3; invPhotoInspDate_aD; [InventoryPhotoInsp:112]Complete_B:9; $invPhotoInspCompl_ab)
SELECTION TO ARRAY:C260([InventoryPhotoInsp:112]Approved_I:6; invPhotoInspAppr_aI)
C_LONGINT:C283($NumInvPhotoInsp)
$NumInvPhotoInsp_L:=Size of array:C274(InvPhotoInspID_aL)
If ($ForReviewList_b)
	SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
	SELECTION TO ARRAY:C260([InventoryPhotoInsp:112]InvPhotoInspID_L:1; InvPhotoInspID_aL; [InventoryPhotoInsp:112]BIN:2; InvPhotoInspBIN_as; [Bridge MHD NBIS:1]BDEPT:1; InvPhotoInspBDEPT_as)
	SELECTION TO ARRAY:C260([InventoryPhotoInsp:112]TeamLeader_I:5; $TmLdrs)
	ARRAY TEXT:C222(InvPhotoInspTmLdr_as; $NumInvPhotoInsp_L)  //Command Replaced was o_ARRAY string length was 45
End if 
ARRAY PICTURE:C279(invPhotoInspAppr_aP; $NumInvPhotoInsp_L)
ARRAY TEXT:C222(invPhotoInspCompl_ab; $NumInvPhotoInsp_L)  //Command Replaced was o_ARRAY string length was 1
C_LONGINT:C283($i)
For ($i; 1; $NumInvPhotoInsp_L)
	If ($i<=Size of array:C274(InvPhotoInspID_aL))
		If (InvPhotoInspID_aL{$i}>0)
			Case of 
				: (invPhotoInspAppr_aI{$i}=BMS Approved)
					$PicFromLib:=$PicFromLibAppr
				: (invPhotoInspAppr_aI{$i}=BMS Rejected)
					$PicFromLib:=$PicFromLibRej
				Else 
					$PicFromLib:=$BlankPic*29
			End case 
			invPhotoInspAppr_aP{$i}:=$PicFromLib
			If ($invPhotoInspCompl_ab{$i})
				invPhotoInspCompl_ab{$i}:="x"
			Else 
				invPhotoInspCompl_ab{$i}:="o"
			End if 
			If ($ForReviewList_b)
				$PersonPos_L:=Find in array:C230(aPeople_ID; $TmLdrs{$i})
				If ($PersonPos_L>0)
					InvPhotoInspTmLdr_as{$i}:=aPeople{$PersonPos_L}
				Else 
					InvPhotoInspTmLdr_as{$i}:=""
				End if 
				
			End if 
			
		Else 
			//record must have been deleted-delete array elements
			DELETE FROM ARRAY:C228(InvPhotoInspID_aL; $i; 1)
			DELETE FROM ARRAY:C228($TmLdrs; $i; 1)
			DELETE FROM ARRAY:C228($invPhotoInspCompl_ab; $i; 1)
			DELETE FROM ARRAY:C228(invPhotoInspAppr_aI; $i; 1)
			DELETE FROM ARRAY:C228(invPhotoInspAppr_aP; $i; 1)
			DELETE FROM ARRAY:C228(invPhotoInspCompl_ab; $i; 1)
			DELETE FROM ARRAY:C228(InvPhotoInspTmLdr_as; $i; 1)
			DELETE FROM ARRAY:C228(invPhotoInspDate_aD; $i; 1)
			DELETE FROM ARRAY:C228(InvPhotoInspBIN_as; $i; 1)
			DELETE FROM ARRAY:C228(InvPhotoInspBDEPT_as; $i; 1)
			$i:=$i-1
		End if 
		
	End if 
	
End for 
$PicFromLib:=$BlankPic
$PicFromLibAppr:=$BlankPic
$PicFromLibRej:=$BlankPic
