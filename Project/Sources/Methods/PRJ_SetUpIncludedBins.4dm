//%attributes = {"invisible":true}
//Method: PRJ_SetUpIncludedBins
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 12/10/19, 16:08:32
	// ----------------------------------------------------
	//Created : 
	Mods_2019_12
End if 
//

ARRAY TEXT:C222($v_1_065_atxt; 0)
ARRAY TEXT:C222($v_1_063_atxt; 0)

USE SET:C118("BDEPTset")
SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]BIN:3; v_1_003_atxt; [Bridge MHD NBIS:1]Item8:206; v_1_206_atxt; \
[Bridge MHD NBIS:1]Item7:65; $v_1_065_atxt; [Bridge MHD NBIS:1]Item6A:63; $v_1_063_atxt)


ARRAY TEXT:C222($Group_atxt; 0)
ARRAY LONGINT:C221($Group_al; 0)
ARRAY TEXT:C222($Type_atxt; 0)
ARRAY TEXT:C222($Bin_atxt; 0)
ARRAY TEXT:C222($BinDescP2_atxt; 0)
ARRAY LONGINT:C221($Colors_aL; 0)
ARRAY LONGINT:C221($Colors_aL; 2)
$Colors_aL{1}:=15990778
$Colors_aL{2}:=10747899
ARRAY BOOLEAN:C223($New_ab; 0)
C_LONGINT:C283($ProjectID_L)
//6339
$ProjectID_L:=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1
Begin SQL
	
	select
	[PRJ_ProjectDetailsIncludedBINS].[PDB_BIN_s],
	[PRJ_ProjectDetailsIncludedBINS].[PDB_NewBIN_b], 
	[PRJ_ProjectDetailsIncludedBINS].[PDB_GroupNumber_l]
	from
	[PRJ_ProjectDetailsIncludedBINS]
	where
	[PRJ_ProjectDetailsIncludedBINS].[PRJ_ProjectID_l] = :$ProjectID_L 
	into 
	:$Bin_atxt,
	:$New_ab,
	:$Group_al;
	
End SQL
MULTI SORT ARRAY:C718($Group_aL; >; $New_ab; >; $Bin_atxt; >)
ARRAY LONGINT:C221(PRJBackGroundColor_aL; 0)
C_BOOLEAN:C305($OddColor_B)

ARRAY TEXT:C222(BinDescP2_atxt; 0)
C_LONGINT:C283($LastGroup_L; $Size_L)
C_BOOLEAN:C305($AddNew_B)
$LastGroup_L:=0
v_122_006_L:=0
C_LONGINT:C283($loop_l)
$AddNew_B:=False:C215
ARRAY TEXT:C222($linecolor_atxt; 0)
C_LONGINT:C283($pos_L)

For ($loop_l; 1; Size of array:C274($Bin_atxt))
	
	$pos_L:=Find in array:C230(v_1_003_atxt; $Bin_atxt{$Loop_l})
	If ($Group_al{$loop_l}=0)
		$Group_al{$loop_l}:=1
	End if 
	Case of 
		: ($LastGroup_L#$Group_al{$loop_l}) & (Not:C34($New_ab{$loop_l}))
			APPEND TO ARRAY:C911(BinDescP2_atxt; "Existing")
			If (Not:C34($OddColor_B))
				$OddColor_B:=True:C214
				APPEND TO ARRAY:C911(PRJBackGroundColor_aL; $Colors_aL{1})
			Else 
				$OddColor_B:=False:C215
				APPEND TO ARRAY:C911(PRJBackGroundColor_aL; $Colors_aL{2})
			End if 
			
			$AddNew_B:=True:C214
			$LastGroup_L:=$Group_al{$loop_l}
			
		: ($LastGroup_L#$Group_al{$loop_l}) & ($New_ab{$loop_l})
			$AddNew_B:=True:C214
			$LastGroup_L:=$Group_al{$loop_l}
			If (Not:C34($OddColor_B))
				$OddColor_B:=True:C214
			Else 
				$OddColor_B:=False:C215
			End if 
	End case 
	If ($New_ab{$loop_l}) & ($AddNew_B)
		
		APPEND TO ARRAY:C911(BinDescP2_atxt; "Proposed")
		If ($OddColor_B)
			APPEND TO ARRAY:C911(PRJBackGroundColor_aL; $Colors_aL{1})
		Else 
			APPEND TO ARRAY:C911(PRJBackGroundColor_aL; $Colors_aL{2})
		End if 
		$AddNew_B:=False:C215
	End if 
	APPEND TO ARRAY:C911(BinDescP2_atxt; $Bin_atxt{$loop_l}+" - "+f_TrimStr($v_1_065_atxt{$pos_L}; True:C214; True:C214)+" / "+f_TrimStr($v_1_063_atxt{$pos_L}; True:C214; True:C214))
	If ($OddColor_B)
		APPEND TO ARRAY:C911(PRJBackGroundColor_aL; $Colors_aL{1})
	Else 
		APPEND TO ARRAY:C911(PRJBackGroundColor_aL; $Colors_aL{2})
	End if 
	If ($Group_al{$loop_l}>v_122_006_L)
		v_122_006_L:=$Group_al{$loop_l}
	End if 
	
	
End for 

OBJECT SET VISIBLE:C603(*; "NONewBIN"; Not:C34(Find in array:C230(BinDescP2_atxt; "Proposed")>0))

//End PRJ_SetUpIncludedBins