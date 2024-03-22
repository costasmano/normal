//%attributes = {"invisible":true}
//Method: FHWA_InspReport
//Description
//  ` Generate an fhwa frequency check report. Metric 6 of the FHWA review.
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/2/12
	// ----------------------------------------------------
	//Created : 
	Mods_2012_11
End if 
//
C_TEXT:C284($QueryBySQL_txt)
ARRAY DATE:C224(TTTTINSPDATEs_ad; 0)
ARRAY DATE:C224(SIAItem90_ad; 0)
ARRAY TEXT:C222(TTTTINSPTYPE_atxt; 0)
ARRAY TEXT:C222(TTTTBINs_atxt; 0)
ARRAY TEXT:C222(TTTTBDEPTS_atxt; 0)
ARRAY DATE:C224(TTTTPASTINSPDATEs_ad; 0)
ARRAY TEXT:C222(TTTTPASTINSPTYPE_atxt; 0)
ARRAY TEXT:C222(TTTTPASTBINs_atxt; 0)
ARRAY LONGINT:C221(BRIDGEITEM91_aL; 0)
C_DATE:C307(LimitDate1_d; LimitDate2_d)
LimitDate1_d:=!2012-01-01!
LimitDate2_d:=!2006-01-01!
C_BOOLEAN:C305($aboveWater_b)
CONFIRM:C162("Do Above water or Dive inspections?"; "Above Water"; "Dive")
$aboveWater_b:=(OK=1)

$QueryBySQL_txt:="Select [inspections].[insp date], [Inspections].[Insp Type], [Inspections].[BIN], [Bridge MHD NBIS].BDEPT, "
If ($aboveWater_b)
	$QueryBySQL_txt:=$QueryBySQL_txt+"  [Bridge MHD NBIS].Item91, [Bridge MHD NBIS].Item90 "
Else 
	$QueryBySQL_txt:=$QueryBySQL_txt+"  [Bridge MHD NBIS].Item92BB, [Bridge MHD NBIS].Item93B "
End if 
$QueryBySQL_txt:=$QueryBySQL_txt+" from [inspections], [Bridge MHD NBIS] where "
If ($aboveWater_b)
	$QueryBySQL_txt:=$QueryBySQL_txt+"  [Inspections].[Insp Type] not in ('DVE', 'DVL', 'DVS', 'DAM', 'CLD', 'FRZ', 'OTH', 'RRR', 'PON', 'FLD', 'BOX' ) "
Else 
	$QueryBySQL_txt:=$QueryBySQL_txt+"  [Inspections].[Insp Type]  in ('DVE', 'DVL', 'DVS') "
End if 

$QueryBySQL_txt:=$QueryBySQL_txt+" and [Inspections].[Insp Date] >= :LimitDate1_d "
$QueryBySQL_txt:=$QueryBySQL_txt+" and CAST([Inspections].[InspComplete] AS INT) =1 "
$QueryBySQL_txt:=$QueryBySQL_txt+" and CAST([Bridge MHD NBIS].[FHWARecord] AS INT) =1 "
$QueryBySQL_txt:=$QueryBySQL_txt+" and [Bridge MHD NBIS].[Item91] = 24 "
$QueryBySQL_txt:=$QueryBySQL_txt+" and [bridge mhd nbis].[bin] = [inspections].[bin] "
$QueryBySQL_txt:=$QueryBySQL_txt+"order by [inspections].[insp date] DESC "

SQL LOGIN:C817

SQL EXECUTE:C820($QueryBySQL_txt; TTTTINSPDATEs_ad; TTTTINSPTYPE_atxt; TTTTBINs_atxt; TTTTBDEPTS_atxt; BRIDGEITEM91_aL; SIAItem90_ad)
SQL LOAD RECORD:C822(SQL all records:K49:10)

SQL CANCEL LOAD:C824

$QueryBySQL_txt:="Select [inspections].[insp date], [Inspections].[Insp Type], [Inspections].[BIN] from [inspections] where "
If ($aboveWater_b)
	$QueryBySQL_txt:=$QueryBySQL_txt+"  [Inspections].[Insp Type] not in ('DVE', 'DVL', 'DVS', 'DAM', 'CLD', 'FRZ', 'OTH', 'RRR', 'PON', 'FLD', 'BOX' ) "
Else 
	$QueryBySQL_txt:=$QueryBySQL_txt+"  [Inspections].[Insp Type]  in ('DVE', 'DVL', 'DVS' ) "
End if 
$QueryBySQL_txt:=$QueryBySQL_txt+" and [Inspections].[Insp Date] < :LimitDate1_d "
$QueryBySQL_txt:=$QueryBySQL_txt+" and [Inspections].[Insp Date] > :LimitDate2_d "
$QueryBySQL_txt:=$QueryBySQL_txt+" and cast([Inspections].[InspComplete] AS INT) =1 "
$QueryBySQL_txt:=$QueryBySQL_txt+"order by [inspections].[insp date] DESC "

SQL EXECUTE:C820($QueryBySQL_txt; TTTTPASTINSPDATEs_ad; TTTTPASTINSPTYPE_atxt; TTTTPASTBINs_atxt)
SQL LOAD RECORD:C822(SQL all records:K49:10)

SQL LOGOUT:C872

C_LONGINT:C283($loop_L; $PrevInsp_L; $MonthFreq_L)
C_DATE:C307($PrevDate_d)
C_TEXT:C284($PrevTyp_txt; $freqCat_txt)
C_TIME:C306($reportDoc_t)
$reportDoc_t:=Create document:C266("")

If ($aboveWater_b)
	SEND PACKET:C103($reportDoc_t; "BIN"+Char:C90(9)+"BDEPT"+Char:C90(9)+"Item 90"+Char:C90(9)+"Item 91"+Char:C90(9)+"Insp Type"+Char:C90(9)+"Insp Date"+Char:C90(9)+"Prev Date"+Char:C90(9)+"Prev Type"+Char:C90(9)+"MonthFreq"+Char:C90(9)+"FreqCategory"+Char:C90(13))
Else 
	SEND PACKET:C103($reportDoc_t; "BIN"+Char:C90(9)+"BDEPT"+Char:C90(9)+"Item 93b"+Char:C90(9)+"Item 92BB"+Char:C90(9)+"Insp Type"+Char:C90(9)+"Insp Date"+Char:C90(9)+"Prev Date"+Char:C90(9)+"Prev Type"+Char:C90(9)+"MonthFreq"+Char:C90(9)+"FreqCategory"+Char:C90(13))
End if 

For ($loop_L; 1; Size of array:C274(TTTTBINs_atxt))
	$PrevInsp_L:=Find in array:C230(TTTTBINs_atxt; TTTTBINs_atxt{$loop_L}; ($loop_L+1))
	$PrevDate_d:=!00-00-00!
	$PrevTyp_txt:=""
	$MonthFreq_L:=0
	$freqCat_txt:="First Insp."
	If ($PrevInsp_L>0)
		
		If (TTTTINSPDATEs_ad{$PrevInsp_L}=TTTTINSPDATEs_ad{$loop_L})
			$PrevInsp_L:=Find in array:C230(TTTTBINs_atxt; TTTTBINs_atxt{$loop_L}; ($PrevInsp_L+1))
			
			If ($PrevInsp_L>0)
				$PrevDate_d:=TTTTINSPDATEs_ad{$PrevInsp_L}
				$PrevTyp_txt:=TTTTINSPTYPE_atxt{$PrevInsp_L}
			Else 
				$PrevInsp_L:=-1
			End if 
		Else 
			$PrevDate_d:=TTTTINSPDATEs_ad{$PrevInsp_L}
			$PrevTyp_txt:=TTTTINSPTYPE_atxt{$PrevInsp_L}
		End if 
	End if 
	
	If ($PrevInsp_L<0)
		$PrevInsp_L:=Find in array:C230(TTTTPASTBINs_atxt; TTTTBINs_atxt{$loop_L})
		If ($PrevInsp_L>0)
			$PrevDate_d:=TTTTPASTINSPDATEs_ad{$PrevInsp_L}
			$PrevTyp_txt:=TTTTPASTINSPTYPE_atxt{$PrevInsp_L}
		End if 
	End if 
	
	If ($PrevDate_d#!00-00-00!)
		$MonthFreq_L:=((Year of:C25(TTTTINSPDATEs_ad{$loop_L})*12)+Month of:C24(TTTTINSPDATEs_ad{$loop_L}))-((Year of:C25($PrevDate_d)*12)+Month of:C24($PrevDate_d))
		
		Case of 
			: ($MonthFreq_L<=24)
				$freqCat_txt:="1"
			: ($MonthFreq_L=25)
				$freqCat_txt:="2"
			: ($MonthFreq_L>25)
				$freqCat_txt:="3"
		End case 
		
	End if 
	
	SEND PACKET:C103($reportDoc_t; TTTTBINs_atxt{$loop_L}+Char:C90(9)+TTTTBDEPTS_atxt{$loop_L}+Char:C90(9)+String:C10(SIAItem90_ad{$loop_L})+Char:C90(9)+String:C10(BRIDGEITEM91_aL{$loop_L})+Char:C90(9)+TTTTINSPTYPE_atxt{$loop_L}+Char:C90(9)+String:C10(TTTTINSPDATEs_ad{$loop_L})+Char:C90(9)+String:C10($PrevDate_d)+Char:C90(9)+$PrevTyp_txt+Char:C90(9)+String:C10($MonthFreq_L)+Char:C90(9)+$freqCat_txt+Char:C90(13))
	
End for 

CLOSE DOCUMENT:C267($reportDoc_t)
SHOW ON DISK:C922(Document; *)
ALERT:C41("Done")
//End FHWA_InspReport