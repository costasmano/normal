//%attributes = {"invisible":true}
// Method: INSP_GetReviewRules
// Description
//  ` Get the review rules for an inspection based on owner and type. fill the results in pointers
// 
//  ` Parameters
//  ` $0 : $Done_b
//  ` $1 : $InspOwn_txt
//  ` $2 : $InspType_txt
//  ` $3 : $DBIEReqd_ptr
//  ` $4 : $AreaReqd_ptr
//  ` $5 : $FinalStage_ptr
//  ` $6 : $InspResp_txt
//  ` $7 : $DBIEGroupName_ptr
//  ` $8 : $AreaEGroupName_ptr
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/07/11, 09:57:58
	// ----------------------------------------------------
	Mods_2011_10
	// Modified by: costasmanousakis-(Designer)-(10/21/11 10:29:07)
	Mods_2011_10
	// Modified by: Costas Manousakis-(Designer)-(5/15/13 15:30:07)
	Mods_2013_05
	//  `Modificatioin for Tunnels , also modify ◊INSP_DBIE_b and ◊INSP_AreaEng_b based on the inspeciton type
	// Modified by: Costas Manousakis-(Designer)-(2/13/15 12:06:07)
	Mods_2015_02
	//  `for Tunnels use "T@" for inspection type
End if 
C_BOOLEAN:C305($0; $Done_b)
C_TEXT:C284($1; $InspOwn_txt; $2; $InspType_txt)
$InspOwn_txt:=$1
$InspType_txt:=$2
C_POINTER:C301($3; $4; $5)
C_TEXT:C284($6; $InspResp_txt)
$InspResp_txt:=$6
C_POINTER:C301($7; $8)

C_BOOLEAN:C305($DBIEReqd_b; $AreaReqd_b)
C_LONGINT:C283($FinalStage_L)
$DBIEReqd_b:=False:C215
$AreaReqd_b:=False:C215
$FinalStage_L:=-1
$Done_b:=False:C215
C_LONGINT:C283($loop_L; $Rowfound_L)
$Rowfound_L:=-1
For ($loop_L; 1; Size of array:C274(<>InspReview_Owner_atxt))
	If ((Length:C16(<>InspReview_Owner_atxt{$loop_L})=1) & (Character code:C91(<>InspReview_Owner_atxt{$loop_L})=Character code:C91("@")))
		If ($InspType_txt=<>InspReview_Type_atxt{$loop_L})
			
			//ALERT($a5_atxt{$loop_L})
			$Rowfound_L:=$loop_L
			$Done_b:=True:C214
			$loop_L:=Size of array:C274(<>InspReview_Owner_atxt)+1
		End if 
	Else 
		If (Position:C15($InspOwn_txt; <>InspReview_Owner_atxt{$loop_L})>0)
			
			If ($InspType_txt=<>InspReview_Type_atxt{$loop_L})
				//ALERT($a5_atxt{$loop_L})
				$Rowfound_L:=$loop_L
				$Done_b:=True:C214
				$loop_L:=Size of array:C274(<>InspReview_Owner_atxt)+1
			End if 
			
		End if 
		
	End if 
	
End for 

If ($Rowfound_L>0)
	$DBIEReqd_b:=(<>InspReview_DBIEReqd_atxt{$Rowfound_L}="Y")
	$AreaReqd_b:=(<>InspReview_AEReqd_atxt{$Rowfound_L}="Y")
	$FinalStage_L:=Num:C11(<>InspReview_FinalStage_atxt{$Rowfound_L})
End if 

C_TEXT:C284($DBIEGroupName_txt; $AreaEGroupName_txt)
C_LONGINT:C283($loop_L)
$DBIEGroupName_txt:="XXXXXXX"
$AreaEGroupName_txt:="XXXXXXX"
<>INSP_DBIE_b:=False:C215
<>INSP_AreaEng_b:=False:C215
For ($loop_L; 1; Size of array:C274(<>INSP_DBIEResp_atxt))
	If (<>INSP_DBIEResp_atxt{$loop_L}=$InspResp_txt)
		Case of 
			: ($InspType_txt="T@")
				
				If (<>INSP_DBIEGroups_atxt{$loop_L}="Tunnel@")
					$DBIEGroupName_txt:=<>INSP_DBIEGroups_atxt{$loop_L}
				End if 
				
			Else 
				If (<>INSP_DBIEGroups_atxt{$loop_L}#"Tunnel@")
					$DBIEGroupName_txt:=<>INSP_DBIEGroups_atxt{$loop_L}
				End if 
				
		End case 
		
	End if 
	
End for 
<>INSP_DBIE_b:=((GRP_UserInGroup($DBIEGroupName_txt)=1) | User in group:C338(Current user:C182; "Design Access Group"))
For ($loop_L; 1; Size of array:C274(<>INSP_AreaEngGrpResp_atxt))
	If (<>INSP_AreaEngGrpResp_atxt{$loop_L}=$InspResp_txt)
		Case of 
			: ($InspType_txt="T@")
				
				If (<>INSP_AreaEngGroups_atxt{$loop_L}="Tunnel@")
					$AreaEGroupName_txt:=<>INSP_AreaEngGroups_atxt{$loop_L}
				End if 
				
			Else 
				If (<>INSP_AreaEngGroups_atxt{$loop_L}#"Tunnel@")
					$AreaEGroupName_txt:=<>INSP_AreaEngGroups_atxt{$loop_L}
				End if 
				
		End case 
		
	End if 
	
End for 
<>INSP_AreaEng_b:=((GRP_UserInGroup($AreaEGroupName_txt)=1) | User in group:C338(Current user:C182; "Design Access Group"))
//
//$Rowfound_L:=Find in array(◊INSP_DBIEResp_atxt;$InspResp_txt)
//If ($Rowfound_L>0)
//$DBIEGroupName_txt:=◊INSP_DBIEGroups_atxt{$Rowfound_L}
//Else 
//End if 

//$Rowfound_L:=Find in array(◊INSP_AreaEngGrpResp_atxt;$InspResp_txt)
//If ($Rowfound_L>0)
//$AreaEGroupName_txt:=◊INSP_AreaEngGroups_atxt{$Rowfound_L}
//Else 
//End if 

$3->:=$DBIEReqd_b
$4->:=$AreaReqd_b
$5->:=$FinalStage_L
$7->:=$DBIEGroupName_txt
$8->:=$AreaEGroupName_txt
$0:=$Done_b