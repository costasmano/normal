//%attributes = {"shared":true}
//Method: QR_CalcDistrRank
//Description
// calculate the district rank of the current Bridge or by passing BIN and Item2 and Rank
// Parameters
// $0: $DistrRank_L
// $1 : $BIN  (Optional)
// $2 : $Item2  (Optional)
// $3 : $Rank  (Optional)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 10/12/16, 11:49:59
	// ----------------------------------------------------
	//Created : 
	Mods_2016_10
	
	C_LONGINT:C283(QR_CalcDistrRank; $0)
	C_TEXT:C284(QR_CalcDistrRank; $1)
	C_TEXT:C284(QR_CalcDistrRank; $2)
	C_LONGINT:C283(QR_CalcDistrRank; $3)
End if 
//
C_LONGINT:C283($0; $DistrRank_L)

C_LONGINT:C283($Rank_L)
C_TEXT:C284($BIN_txt; $Item2_txt)
$DistrRank_L:=0

If (Count parameters:C259>0)
	C_TEXT:C284($1)
	C_TEXT:C284($2)
	C_LONGINT:C283($3)
	$BIN_txt:=$1
	$Item2_txt:=$2
	$Rank_L:=$3
Else 
	$Rank_L:=[Bridge MHD NBIS:1]Rank:6
	$BIN_txt:=[Bridge MHD NBIS:1]BIN:3
	$Item2_txt:=[Bridge MHD NBIS:1]Item2:60
End if 


If ($Rank_L>0)
	ARRAY TEXT:C222($DistrBINS_atxt; 0)
	ARRAY LONGINT:C221($StRank_aL; 0)
	Begin SQL
		select [Bridge MHD NBIS].[BIN]
		,[Bridge MHD NBIS].[Rank]
		from [Bridge MHD NBIS]
		where
		[Bridge MHD NBIS].[Item2] = :$Item2_txt
		and [Bridge MHD NBIS].[Rank] > 0
		order by [Bridge MHD NBIS].[Rank] ASC
		into :$DistrBINS_atxt , :$StRank_aL ;
	End SQL
	ARRAY LONGINT:C221($DRank_aL; Size of array:C274($StRank_aL))
	C_LONGINT:C283($loop_L; $indx_L)
	$DRank_aL{1}:=1
	For ($loop_L; 2; Size of array:C274($StRank_aL))
		
		If ($StRank_aL{$loop_L}=$StRank_aL{$loop_L-1})
			$DRank_aL{$loop_L}:=$DRank_aL{$loop_L-1}
		Else 
			$DRank_aL{$loop_L}:=$loop_L
		End if 
		
	End for 
	
	$indx_L:=Find in array:C230($DistrBINS_atxt; $BIN_txt)
	If ($indx_L<1)  //just in case
		$DistrRank_L:=0
	Else 
		$DistrRank_L:=$DRank_aL{$indx_L}
	End if 
End if 

$0:=$DistrRank_L
//End CalcDistrRank