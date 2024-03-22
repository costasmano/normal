//%attributes = {}
//Method: NextElmtUpdate
//Description
// retrieve next updates for current element in elementssafety
// Parameters
// $0 : $ResultObject
//  // .Description
//  // .Elementcollection
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Feb 24, 2023, 15:38:48
	Mods_2023_02
	// ----------------------------------------------------
	
	C_OBJECT:C1216(NextElmtUpdate; $0)
	
End if 
//
C_OBJECT:C1216($0)

C_TEXT:C284($Bin_s)
C_LONGINT:C283($ElemNo_L)
C_DATE:C307($InspDate_d)
$Bin_s:=[Bridge MHD NBIS:1]BIN:3
$InspDate_d:=[Inspections:27]Insp Date:78
$ElemNo_L:=[ElementsSafety:29]ElementNo:1
ARRAY DATE:C224($InspDates_ad; 0)
ARRAY TEXT:C222($Def_atxt; 0)
ARRAY TEXT:C222($Prio_atxt; 0)
ARRAY TEXT:C222($InspTypes_atxt; 0)
Begin SQL
	select [ElementsSafety].[Deficiency],
	[ElementsSafety].[Priority],
	[Inspections].[Insp Date],
	[inspections].[insp type]
	from [ElementsSafety], [Inspections]
	where [ElementsSafety].[InspID] =[Inspections].[InspID]
	and [Inspections].[BIN] = :$Bin_s
	and [Inspections].[Insp Date] > :$InspDate_d
	and [ElementsSafety].[ElementNo] = :$ElemNo_L
	into :$Def_atxt, :$Prio_atxt, :$InspDates_ad , :$InspTypes_atxt ;
	
End SQL

SORT ARRAY:C229($InspDates_ad; $Def_atxt; $Prio_atxt; $InspTypes_atxt; >)
C_TEXT:C284($result_txt)
$result_txt:=""
C_COLLECTION:C1488($events_c)
$events_c:=New collection:C1472
If (Size of array:C274($InspDates_ad)>0)
	C_COLLECTION:C1488($events_c)
	C_LONGINT:C283($loop_L)
	$loop_L:=1
	$result_txt:=" { "+String:C10($InspDates_ad{$loop_L})+" - "+\
		$InspTypes_atxt{$loop_L}+" - "+\
		$Def_atxt{$loop_L}+"-"+$Prio_atxt{$loop_L}+" } "
	$events_c.push(New object:C1471("InspDate"; $InspDates_ad{$loop_L}; \
		"InspType"; $InspTypes_atxt{$loop_L}; \
		"Deficiency"; $Def_atxt{$loop_L}; \
		"Priority"; $Prio_atxt{$loop_L}))
	
	For ($loop_L; 2; Size of array:C274($InspDates_ad))
		$result_txt:=$result_txt+Char:C90(Carriage return:K15:38)+\
			" { "+String:C10($InspDates_ad{$loop_L})+" - "+\
			$InspTypes_atxt{$loop_L}+" - "+\
			$Def_atxt{$loop_L}+"-"+$Prio_atxt{$loop_L}+" } "
		$events_c.push(New object:C1471("InspDate"; $InspDates_ad{$loop_L}; \
			"InspType"; $InspTypes_atxt{$loop_L}; \
			"Deficiency"; $Def_atxt{$loop_L}; \
			"Priority"; $Prio_atxt{$loop_L}))
	End for 
	
End if 

$0:=New object:C1471("Description"; $result_txt; "Events"; $events_c)

//End NextEmtUpdate   