//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 11/24/15, 15:47:13
//----------------------------------------------------
//Method: NTI_SetUpAssignBINs
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_11  // 
	//Modified by: administrator (11/24/15 15:47:14)
	
End if 
C_TEXT:C284($1)
NTI_CurrentPage_L:=9
C_TEXT:C284($District_txt; $TunnelNumber_txt)
$TunnelNumber_txt:=[NTI_TunnelInfo:181]NTI_i1_s:6
$District_txt:=[NTI_TunnelInfo:181]NTI_i6_s:11
ARRAY TEXT:C222(NTI_A_Bins_atxt; 0)
ARRAY TEXT:C222(NTI_A_Item2_atxt; 0)
ARRAY TEXT:C222(NTI_A_Item8_atxt; 0)
ARRAY TEXT:C222(NTI_A_Item7_atxt; 0)
ARRAY TEXT:C222(NTI_A_Item6a_atxt; 0)
ARRAY TEXT:C222(NTI_S_Bins_atxt; 0)
ARRAY TEXT:C222(NTI_A_Item2_atxt; 0)
ARRAY TEXT:C222(NTI_S_Item8_atxt; 0)
ARRAY TEXT:C222(NTI_S_Item7_atxt; 0)
ARRAY TEXT:C222(NTI_S_Item6a_atxt; 0)
ARRAY TEXT:C222($Bins_atxt; 0)
ARRAY TEXT:C222($ABins_atxt; 0)

CLEAR VARIABLE:C89(AvailableBins_LB)
CLEAR VARIABLE:C89(SelectedBins_LB)
CLEAR VARIABLE:C89(NTI_FontColor_al)

Begin SQL
	select [Bridge MHD NBIS].[BIN],
	[Bridge MHD NBIS].[Item8], 
	[Bridge MHD NBIS].[Item7], 
	[Bridge MHD NBIS].[Item6A],
	[Bridge MHD NBIS].[item2]
	from
	[Bridge MHD NBIS]
	where
	([Bridge MHD NBIS].[Item8 BridgeCat]  like 'TNL%'
	or
	[Bridge MHD NBIS].[Item8 BridgeCat] like 'BTS%')
	into
	:NTI_A_Bins_atxt,
	:NTI_A_Item8_atxt,
	:NTI_A_Item7_atxt,
	:NTI_A_Item6a_atxt,
	:NTI_A_Item2_atxt;
	
	select
	[TunnelInfo].[BIN]
	from 
	[TunnelInfo]
	where
	[TunnelInfo].[NTI_i1_s]= :$TunnelNumber_txt
	into
	:$Bins_atxt;
	
	
	select
	[TunnelInfo].[BIN]
	from 
	[TunnelInfo]
	where
	[TunnelInfo].[NTI_i1_s] <> :$TunnelNumber_txt
	and 
	[TunnelInfo].[NTI_i1_s]  <> ''
	into
	:$ABins_atxt;
	
	
End SQL


C_LONGINT:C283($Loop_L; $Loc_L)

For ($Loop_L; 1; Size of array:C274($Bins_atxt))
	$Loc_L:=Find in array:C230(NTI_A_Bins_atxt; $Bins_atxt{$Loop_L})
	If ($Loc_L>0)
		APPEND TO ARRAY:C911(NTI_S_Bins_atxt; NTI_A_Bins_atxt{$Loc_L})
		APPEND TO ARRAY:C911(NTI_S_Item2_atxt; NTI_A_Item2_atxt{$Loc_L})
		APPEND TO ARRAY:C911(NTI_S_Item8_atxt; NTI_A_Item8_atxt{$Loc_L})
		APPEND TO ARRAY:C911(NTI_S_Item7_atxt; NTI_A_Item7_atxt{$Loc_L})
		APPEND TO ARRAY:C911(NTI_S_Item6a_atxt; NTI_A_Item6a_atxt{$Loc_L})
		DELETE FROM ARRAY:C228(NTI_A_Bins_atxt; $Loc_L; 1)
		DELETE FROM ARRAY:C228(NTI_A_Item2_atxt; $Loc_L; 1)
		DELETE FROM ARRAY:C228(NTI_A_Item8_atxt; $Loc_L; 1)
		DELETE FROM ARRAY:C228(NTI_A_Item7_atxt; $Loc_L; 1)
		DELETE FROM ARRAY:C228(NTI_A_Item6a_atxt; $Loc_L; 1)
	Else 
		C_TEXT:C284($Bin_txt; $Item8_txt; $Item7_txt; $Item6a_txt; $Item2_txt)
		$Bin_txt:=$Bins_atxt{$Loop_L}
		
		Begin SQL
			
			[Bridge MHD NBIS].[Item8], 
			[Bridge MHD NBIS].[Item7], 
			[Bridge MHD NBIS].[Item6A], 
			[Bridge MHD NBIS].[ITEM2]
			from
			[Bridge MHD NBIS]
			where
			[Bridge MHD NBIS].[BIN] = :$Bin_txt
			into 
			:$Item8_txt, 
			:$Item7_txt, 
			:$Item6a_txt,
			:$Item2_txt;
			
			
		End SQL
		APPEND TO ARRAY:C911(NTI_S_Bins_atxt; $Bin_txt)
		APPEND TO ARRAY:C911(NTI_S_Item2_atxt; $Item2_txt)
		APPEND TO ARRAY:C911(NTI_S_Item8_atxt; $Item8_txt)
		APPEND TO ARRAY:C911(NTI_S_Item7_atxt; $Item7_txt)
		APPEND TO ARRAY:C911(NTI_S_Item6a_atxt; $Item6a_txt)
	End if 
	
End for 
ARRAY LONGINT:C221(NTI_FontColor_al; Size of array:C274(NTI_A_Bins_atxt))
If ($1="")  //Show available only
	For ($Loop_l; 1; Size of array:C274($ABins_atxt))
		$Loc_L:=Find in array:C230(NTI_A_Bins_atxt; $ABins_atxt{$Loop_L})
		If ($Loc_L>0)
			DELETE FROM ARRAY:C228(NTI_A_Bins_atxt; $Loc_L; 1)
			DELETE FROM ARRAY:C228(NTI_A_Item2_atxt; $Loc_L; 1)
			DELETE FROM ARRAY:C228(NTI_A_Item8_atxt; $Loc_L; 1)
			DELETE FROM ARRAY:C228(NTI_A_Item7_atxt; $Loc_L; 1)
			DELETE FROM ARRAY:C228(NTI_A_Item6a_atxt; $Loc_L; 1)
			DELETE FROM ARRAY:C228(NTI_FontColor_al; $Loc_L; 1)
		End if 
	End for 
	REDRAW:C174(AvailableBins_LB)
Else 
	For ($Loop_l; 1; Size of array:C274($ABins_atxt))
		$Loc_L:=Find in array:C230(NTI_A_Bins_atxt; $ABins_atxt{$Loop_L})
		If ($Loc_L>0)
			NTI_FontColor_al{$Loc_L}:=0x00FF0000
		End if 
	End for 
	
	
	
End if 
LISTBOX SORT COLUMNS:C916(AvailableBins_LB; 2; >)
LISTBOX SORT COLUMNS:C916(SelectedBins_LB; 2; >)

REDRAW:C174(AvailableBins_LB)
REDRAW:C174(SelectedBins_LB)
FORM GOTO PAGE:C247(9)

//End NTI_SetUpAssignBINs