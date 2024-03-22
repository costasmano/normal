//%attributes = {"invisible":true}
//Method: INSP_CheckImages
//Description
// check images in current inspection to verify that they are not PICT or PDF type.
// return a text with a list of found errors : Type - sequence - bad format
// Parameters
// $0 : $ImageCheck_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 12/09/16, 10:15:47
	// ----------------------------------------------------
	//Created : 
	Mods_2016_12
	
	C_TEXT:C284(INSP_CheckImages; $0)
	
	// Modified by: Costas Manousakis-(Designer)-(9/15/20 12:11:45)
	Mods_2020_09
	//  `replaced calls to hmfree with call to GetPictureTypes
End if 
//
C_TEXT:C284($0; $ImageCheck_txt)

$ImageCheck_txt:=""
CUT NAMED SELECTION:C334([Standard Photos:36]; "INSPPRECHECKSELECTION")
QUERY:C277([Standard Photos:36]; [Standard Photos:36]InspID:1=[Inspections:27]InspID:2)
C_LONGINT:C283($loop_L; $hmfreeRes_L)
//If (hmFree_IsLicensed >=0)
//Else 
//$hmfreeRes_L:=hmFree_Register ("rLhAA-YcUAGWAAAAJCAMoBksABRAD+AGtAJbF-+")
//End if 
FIRST RECORD:C50([Standard Photos:36])
C_TEXT:C284($DeprType_txt; $ImageType_txt)
ARRAY TEXT:C222($DeprMsg_atxt; 0)
ARRAY TEXT:C222($DeprPhotType_atxt; 0)
ARRAY LONGINT:C221($DeprPhotoSeq_aL; 0)
ARRAY TEXT:C222($BadTypes_atxt; 0)
C_TEXT:C284($ListofBadTypes_txt; $RequireImageCheck_txt)
$ListofBadTypes_txt:="PICT;PDF"
$RequireImageCheck_txt:="TRUE"
$ListofBadTypes_txt:=ut_GetSysParameter("INSP_BADIMAGETYPES"; $ListofBadTypes_txt)
ut_TextToArray($ListofBadTypes_txt; ->$BadTypes_atxt; ";")
$RequireImageCheck_txt:=ut_GetSysParameter("INSP_REQIMAGECHECK"; $RequireImageCheck_txt)
If ([Inspections:27]Insp Type:6="D@")  //Dive inspections
	$RequireImageCheck_txt:=ut_GetSysParameter("INSP_REQIMAGECHECKD"; $RequireImageCheck_txt)
End if 
If ($RequireImageCheck_txt="TRUE")
	
	While (Not:C34(End selection:C36([Standard Photos:36])))
		ARRAY TEXT:C222($TypesFound_atxt; 0)
		$DeprType_txt:=""
		GetPictureTypes([Standard Photos:36]Std Photo:3; ->$TypesFound_atxt)
		If (Size of array:C274($TypesFound_atxt)>0)
			For ($loop_L; 1; Size of array:C274($BadTypes_atxt))
				
				If (Position:C15($BadTypes_atxt{$loop_L}; $TypesFound_atxt{1})>0)
					$DeprType_txt:=$BadTypes_atxt{$loop_L}
				End if 
			End for 
			
			If ($DeprType_txt#"")
				
				Case of 
					: ([Standard Photos:36]PictType:5=BMS Sketch)
						$ImageType_txt:="Sketch"
					: ([Standard Photos:36]PictType:5=BMS Chart)
						$ImageType_txt:="Chart"
					: ([Standard Photos:36]PictType:5=BMS Photo)
						$ImageType_txt:="Photo"
						
				End case 
				APPEND TO ARRAY:C911($DeprPhotType_atxt; [Standard Photos:36]PictType:5)
				APPEND TO ARRAY:C911($DeprPhotoSeq_aL; [Standard Photos:36]SeqNum:6)
				APPEND TO ARRAY:C911($DeprMsg_atxt; $ImageType_txt+" "+String:C10([Standard Photos:36]SeqNum:6)+" is a "+$DeprType_txt)
				
			End if 
		End if 
		
		NEXT RECORD:C51([Standard Photos:36])
	End while 
	If (Size of array:C274($DeprMsg_atxt)>0)
		ARRAY POINTER:C280($SortArrays_aPtr; 3)
		ARRAY LONGINT:C221($SortArrayOrder_aL; 3)
		$SortArrays_aPtr{1}:=->$DeprPhotType_atxt
		$SortArrayOrder_aL{1}:=1
		$SortArrays_aPtr{2}:=->$DeprPhotoSeq_aL
		$SortArrayOrder_aL{2}:=1
		$SortArrays_aPtr{3}:=->$DeprMsg_atxt
		$SortArrayOrder_aL{3}:=0
		MULTI SORT ARRAY:C718($SortArrays_aPtr; $SortArrayOrder_aL)
		
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274($DeprPhotType_atxt))
			$ImageCheck_txt:=$ImageCheck_txt+$DeprMsg_atxt{$loop_L}+"!"+<>sCR
		End for 
		
	End if 
	
	
End if 
USE NAMED SELECTION:C332("INSPPRECHECKSELECTION")
$0:=$ImageCheck_txt
//End INSP_CheckImages