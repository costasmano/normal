//%attributes = {"shared":true}
// Method: PRJ_QR_BridgeRank
//  ` Retrieve the Bridge Rank of Bridges Related to a project file number
// Parameters
// $0 : $Res_txt  "BDEPT1[BIN1]:Rank1 - BDEPT2[BIN2]:Rank2 -...."
// $1 : $SortByRank_B (Optional) - default False - sort by Bdept/BIN
//  `  ` Sorting by Rank is done by first making Rank=0 to Rank=999999 so they end at the bottom
//  `  `  and then resetting them to 0
// $2 : $GetHighestRank_B (optional)
//  ` Get only the highest ranking Bridge - lowest rank number 
//  `  `-if $GetHighestRank_B=true implies $SortByRank_B=True
// $3 : $OutputOpt_L (optional)
//  ` 0 : Default output  "BDEPT1[BIN1]:Rank1 - BDEPT2[BIN2]:Rank2 -...."
//  ` The following are applicable only if $2 = TRUE
//  ` 1 : Rank Only
//  ` 2 : BIN only
//  ` 3 : BIN Only AND load RO the corresponding Bridge MHD NBIS record
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/20/10, 13:37:58
	// ----------------------------------------------------
	
	Mods_2010_09
	// Modified by: costasmanousakis-(Designer)-(1/12/12 16:28:19)
	Mods_2012_01
	//  `Added 3rd optional parameter for output options 
End if 
C_BOOLEAN:C305($SortByRank_B; $GetHighestRank_B)
C_LONGINT:C283($OutputOpt_L)
READ ONLY:C145([PRJ_ProjectDetailsIncludedBINS:122])
READ ONLY:C145([PRJ_ProjectDetails:115])
READ ONLY:C145([Bridge MHD NBIS:1])

QUERY:C277([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PF_FileID_l:3=[PRJ_ProjectFile:117]PF_FileID_l:1)
ARRAY LONGINT:C221($ProjIDs_aL; Records in selection:C76([PRJ_ProjectDetails:115]))
SELECTION TO ARRAY:C260([PRJ_ProjectDetails:115]PRJ_ProjectID_l:1; $ProjIDs_aL)
QUERY WITH ARRAY:C644([PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectID_l:1; $ProjIDs_aL)
QUERY SELECTION:C341([PRJ_ProjectDetailsIncludedBINS:122]; [PRJ_ProjectDetailsIncludedBINS:122]PDB_NewBIN_b:4=False:C215)
ARRAY TEXT:C222($inclBINs_as; Records in selection:C76([PRJ_ProjectDetailsIncludedBINS:122]))  //Command Replaced was o_ARRAY string length was 3
ARRAY TEXT:C222($InclBdepts_as; Records in selection:C76([PRJ_ProjectDetailsIncludedBINS:122]))  //Command Replaced was o_ARRAY string length was 6

SELECTION TO ARRAY:C260([PRJ_ProjectDetailsIncludedBINS:122]PDB_BIN_s:2; $inclBINs_as; [PRJ_ProjectDetailsIncludedBINS:122]PDB_BDEPT_s:3; $InclBdepts_as)
QUERY WITH ARRAY:C644([Bridge MHD NBIS:1]BIN:3; $inclBINs_as)
QUERY SELECTION:C341([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"DES")
ORDER BY:C49([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BDEPT:1; >; [Bridge MHD NBIS:1]BIN:3; >)
ARRAY TEXT:C222($inclBINs_as; Records in selection:C76([Bridge MHD NBIS:1]))  //Command Replaced was o_ARRAY string length was 3
ARRAY TEXT:C222($InclBdepts_as; Records in selection:C76([Bridge MHD NBIS:1]))  //Command Replaced was o_ARRAY string length was 6
ARRAY INTEGER:C220($Rank_aL; Records in selection:C76([Bridge MHD NBIS:1]))
SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]BIN:3; $inclBINs_as; [Bridge MHD NBIS:1]BDEPT:1; $InclBdepts_as; [Bridge MHD NBIS:1]Rank:6; $Rank_aL)
$SortByRank_B:=False:C215
$GetHighestRank_B:=False:C215
$OutputOpt_L:=0
If (Count parameters:C259>0)
	C_BOOLEAN:C305($1)
	$SortByRank_B:=$1
End if 
If (Count parameters:C259>1)
	C_BOOLEAN:C305($2)
	$GetHighestRank_B:=$2
	If ($GetHighestRank_B)
		$SortByRank_B:=True:C214
	End if 
	If (Count parameters:C259>2)
		If ($GetHighestRank_B)
			C_LONGINT:C283($3)
			$OutputOpt_L:=$3
		End if 
	End if 
	
End if 

If ($SortByRank_B)
	
	C_LONGINT:C283($loop_L)
	For ($loop_L; 1; Size of array:C274($Rank_aL))
		If ($Rank_aL{$loop_L}=0)
			$Rank_aL{$loop_L}:=MAXINT:K35:1
		End if 
	End for 
	SORT ARRAY:C229($Rank_aL; $InclBdepts_as; $inclBINs_as)
	For ($loop_L; 1; Size of array:C274($Rank_aL))
		If ($Rank_aL{$loop_L}=MAXINT:K35:1)
			$Rank_aL{$loop_L}:=0
		End if 
	End for 
	
End if 
C_TEXT:C284($Res_txt)
$Res_txt:=""
If (Records in selection:C76([Bridge MHD NBIS:1])>0)
	$Res_txt:=$InclBdepts_as{1}+"["+$inclBINs_as{1}+"]: "+String:C10($Rank_aL{1})
	Case of 
		: ($OutputOpt_L=1)
			$Res_txt:=String:C10($Rank_aL{1})
		: ($OutputOpt_L=2)
			$Res_txt:=$inclBINs_as{1}
		: ($OutputOpt_L=3)
			$Res_txt:=$inclBINs_as{1}
			READ ONLY:C145([Bridge MHD NBIS:1])
			QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=$Res_txt)
			LOAD RECORD:C52([Bridge MHD NBIS:1])
	End case 
	
	If (Not:C34($GetHighestRank_B))
		C_LONGINT:C283($loop_L)
		For ($loop_L; 2; Size of array:C274($InclBdepts_as))
			$Res_txt:=$Res_txt+" - "+$InclBdepts_as{$loop_L}+"["+$inclBINs_as{$loop_L}+"]: "+String:C10($Rank_aL{$loop_L})
		End for 
		
	End if 
	
End if 
READ WRITE:C146([PRJ_ProjectDetailsIncludedBINS:122])
READ WRITE:C146([PRJ_ProjectDetails:115])
READ WRITE:C146([Bridge MHD NBIS:1])

$0:=$Res_txt