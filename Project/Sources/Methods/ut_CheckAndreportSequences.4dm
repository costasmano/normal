//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Chuck Miller
//Date and time: 06/21/17, 16:33:17
//----------------------------------------------------
//Method: ut_CheckAndreportSequences
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2017_06  //
	
	
	//Modified by: Chuck Miller (6/21/17 16:33:20)
	
End if 
Compiler_FieldVariables
C_TEXT:C284($Query_txt; $SeqQuery_txt; $ReplaceMe_txt; $Report_txt)
$ReplaceMe_txt:=Substring:C12(<>KeyMask_s; 1; Position:C15("-"; <>KeyMask_s))
$Query_txt:=$ReplaceMe_txt+"%"

C_TEXT:C284($Result_txt; $SequenceName_txt)
C_LONGINT:C283($NextNumber_L; $LocalNumber_L)
$SequenceName_txt:="LSS_AccessibilityId_s"
$NextNumber_L:=0
Begin SQL
	select [Sequences].[Value]
	from
	[Sequences] 
	where
	[Sequences].[Name] = :$SequenceName_txt
	into
	:$NextNumber_L;
	
	select max([LSS_Accessibility].[LSS_AccessibilityId_s])
	from
	[LSS_Accessibility]
	where
	[LSS_Accessibility].[LSS_AccessibilityId_s] like :$Query_txt
	into 
	:$Result_txt;
	
	
End SQL
$Report_txt:=$SequenceName_txt+Char:C90(Tab:K15:37)+String:C10($NextNumber_L)+Char:C90(Tab:K15:37)+$Result_txt+Char:C90(Tab:K15:37)

$LocalNumber_L:=Num:C11(Replace string:C233($Result_txt; $ReplaceMe_txt; ""))
If ($LocalNumber_L>$NextNumber_L)
	
	Begin SQL
		update
		[Sequences]
		set
		[Sequences].[Value] = :$LocalNumber_L
		where
		[Sequences].[Name] = :$SequenceName_txt;
		
		
		
	End SQL
	$Report_txt:=$Report_txt+"Updated sequence"
End if 
$Report_txt:=$Report_txt+Char:C90(Carriage return:K15:38)
C_LONGINT:C283($Max_L)

$SequenceName_txt:="LSS_AccessibilityElementId_L"
$NextNumber_L:=0
Begin SQL
	select [Sequences].[Value]
	from
	[Sequences] 
	where
	[Sequences].[Name] = :$SequenceName_txt
	into
	:$NextNumber_L;
	
	select max([LSS_AccessibilityElement].[LSS_AccessibilityElementId_L])
	from
	[LSS_AccessibilityElement]
	into 
	:$Max_L;
	
	
End SQL
$Report_txt:=$Report_txt+$SequenceName_txt+Char:C90(Tab:K15:37)+String:C10($NextNumber_L)+Char:C90(Tab:K15:37)+String:C10($Max_L)+Char:C90(Tab:K15:37)
If ($Max_L>$NextNumber_L)
	Begin SQL
		update
		[Sequences]
		set
		[Sequences].[Value] = :$Max_L
		where
		[Sequences].[Name] = :$SequenceName_txt
		
		
		
	End SQL
	$Report_txt:=$Report_txt+"Updated sequence"
End if 
$Report_txt:=$Report_txt+Char:C90(Carriage return:K15:38)
$SequenceName_txt:="LSS_ElementId_L"
$NextNumber_L:=0
Begin SQL
	select [Sequences].[Value]
	from
	[Sequences] 
	where
	[Sequences].[Name] = :$SequenceName_txt
	into
	:$NextNumber_L;
	
	select max([LSS_Element].[LSS_ElementId_L])
	from
	[LSS_Element]
	into 
	:$Max_L;
	
	
End SQL
$Report_txt:=$Report_txt+$SequenceName_txt+Char:C90(Tab:K15:37)+String:C10($NextNumber_L)+Char:C90(Tab:K15:37)+String:C10($Max_L)+Char:C90(Tab:K15:37)

If ($Max_L>$NextNumber_L)
	Begin SQL
		update
		[Sequences]
		set
		[Sequences].[Value] = :$Max_L
		where
		[Sequences].[Name] = :$SequenceName_txt
		
		
		
	End SQL
	$Report_txt:=$Report_txt+"Updated sequence"
End if 
$Report_txt:=$Report_txt+Char:C90(Carriage return:K15:38)
$SequenceName_txt:="LSS_DMeterId_s"
$NextNumber_L:=0
Begin SQL
	select [Sequences].[Value]
	from
	[Sequences] 
	where
	[Sequences].[Name] = :$SequenceName_txt
	into
	:$NextNumber_L;
	
	select max([LSS_DMeter].[LSS_DMeterId_s])
	from
	[LSS_DMeter]
	where
	[LSS_DMeter].[LSS_DMeterId_s] like :$Query_txt
	into 
	:$Result_txt;
	
	
End SQL
$Report_txt:=$Report_txt+$SequenceName_txt+Char:C90(Tab:K15:37)+String:C10($NextNumber_L)+Char:C90(Tab:K15:37)+$Result_txt+Char:C90(Tab:K15:37)

$LocalNumber_L:=Num:C11(Replace string:C233($Result_txt; $ReplaceMe_txt; ""))
If ($LocalNumber_L>$NextNumber_L)
	Begin SQL
		update
		[Sequences]
		set
		[Sequences].[Value] = :$LocalNumber_L
		where
		[Sequences].[Name] = :$SequenceName_txt;
		
		
		
	End SQL
	$Report_txt:=$Report_txt+"Updated sequence"
End if 
$Report_txt:=$Report_txt+Char:C90(Carriage return:K15:38)
$SequenceName_txt:="LSS_ElementInspectionId_s"
$NextNumber_L:=0
Begin SQL
	select [Sequences].[Value]
	from
	[Sequences] 
	where
	[Sequences].[Name] = :$SequenceName_txt
	into
	:$NextNumber_L;
	
	select max([LSS_ElementInspection].[LSS_ElementInspectionId_s])
	from
	[LSS_ElementInspection]
	where
	[LSS_ElementInspection].[LSS_ElementInspectionId_s] like :$Query_txt
	into 
	:$Result_txt;
	
	
End SQL
$Report_txt:=$Report_txt+$SequenceName_txt+Char:C90(Tab:K15:37)+String:C10($NextNumber_L)+Char:C90(Tab:K15:37)+$Result_txt+Char:C90(Tab:K15:37)

$LocalNumber_L:=Num:C11(Replace string:C233($Result_txt; $ReplaceMe_txt; ""))
If ($LocalNumber_L>$NextNumber_L)
	Begin SQL
		update
		[Sequences]
		set
		[Sequences].[Value] = :$LocalNumber_L
		where
		[Sequences].[Name] = :$SequenceName_txt;
		
		
		
	End SQL
	$Report_txt:=$Report_txt+"Updated sequence"
End if 
$Report_txt:=$Report_txt+Char:C90(Carriage return:K15:38)
$SequenceName_txt:="LSS_InspectionId_s"
$NextNumber_L:=0
Begin SQL
	select [Sequences].[Value]
	from
	[Sequences] 
	where
	[Sequences].[Name] = :$SequenceName_txt
	into
	:$NextNumber_L;
	
	select max([LSS_Inspection].[LSS_InspectionId_s])
	from
	[LSS_Inspection]
	where
	[LSS_Inspection].[LSS_InspectionId_s] like :$Query_txt
	into 
	:$Result_txt;
	
	
End SQL
$Report_txt:=$Report_txt+$SequenceName_txt+Char:C90(Tab:K15:37)+String:C10($NextNumber_L)+Char:C90(Tab:K15:37)+$Result_txt+Char:C90(Tab:K15:37)

$LocalNumber_L:=Num:C11(Replace string:C233($Result_txt; $ReplaceMe_txt; ""))
If ($LocalNumber_L>$NextNumber_L)
	Begin SQL
		update
		[Sequences]
		set
		[Sequences].[Value] = :$LocalNumber_L
		where
		[Sequences].[Name] = :$SequenceName_txt;
		
		
		
	End SQL
	$Report_txt:=$Report_txt+"Updated sequence"
End if 
$Report_txt:=$Report_txt+Char:C90(Carriage return:K15:38)

//[LSS_Inventory]
$SequenceName_txt:="LSS_InventoryId_s"
$NextNumber_L:=0
Begin SQL
	select [Sequences].[Value]
	from
	[Sequences] 
	where
	[Sequences].[Name] = :$SequenceName_txt
	into
	:$NextNumber_L;
	
	select max([LSS_Inventory].[LSS_InventoryId_s])
	from
	[LSS_Inventory]
	where
	[LSS_Inventory].[LSS_InventoryId_s] like :$Query_txt
	into 
	:$Result_txt;
	
	
End SQL
$Report_txt:=$Report_txt+$SequenceName_txt+Char:C90(Tab:K15:37)+String:C10($NextNumber_L)+Char:C90(Tab:K15:37)+$Result_txt+Char:C90(Tab:K15:37)

$LocalNumber_L:=Num:C11(Replace string:C233($Result_txt; $ReplaceMe_txt; ""))
If ($LocalNumber_L>$NextNumber_L)
	Begin SQL
		update
		[Sequences]
		set
		[Sequences].[Value] = :$LocalNumber_L
		where
		[Sequences].[Name] = :$SequenceName_txt;
		
		
		
	End SQL
	$Report_txt:=$Report_txt+"Updated sequence"
End if 
$Report_txt:=$Report_txt+Char:C90(Carriage return:K15:38)
//[LSS_Photos]
$SequenceName_txt:="LSS_PhotoId_s"
$NextNumber_L:=0
Begin SQL
	select [Sequences].[Value]
	from
	[Sequences] 
	where
	[Sequences].[Name] = :$SequenceName_txt
	into
	:$NextNumber_L;
	
	select max([LSS_Photos].[LSS_PhotoId_s])
	from
	[LSS_Photos]
	where
	[LSS_Photos].[LSS_PhotoId_s] like :$Query_txt
	into 
	:$Result_txt;
	
	
End SQL
$Report_txt:=$Report_txt+$SequenceName_txt+Char:C90(Tab:K15:37)+String:C10($NextNumber_L)+Char:C90(Tab:K15:37)+$Result_txt+Char:C90(Tab:K15:37)

$LocalNumber_L:=Num:C11(Replace string:C233($Result_txt; $ReplaceMe_txt; ""))
If ($LocalNumber_L>$NextNumber_L)
	Begin SQL
		update
		[Sequences]
		set
		[Sequences].[Value] = :$LocalNumber_L
		where
		[Sequences].[Name] = :$SequenceName_txt;
		
		
		
	End SQL
	$Report_txt:=$Report_txt+"Updated sequence"
End if 
$Report_txt:=$Report_txt+Char:C90(Carriage return:K15:38)
//[LSS_SignPanel]LSS_SignPanelId_s
$SequenceName_txt:="LSS_SignPanelId_s"
$NextNumber_L:=0
Begin SQL
	select [Sequences].[Value]
	from
	[Sequences] 
	where
	[Sequences].[Name] = :$SequenceName_txt
	into
	:$NextNumber_L;
	
	select max([LSS_SignPanel].[LSS_SignPanelId_s])
	from
	[LSS_SignPanel]
	where
	[LSS_SignPanel].[LSS_SignPanelId_s] like :$Query_txt
	into 
	:$Result_txt;
	
	
End SQL
$Report_txt:=$Report_txt+$SequenceName_txt+Char:C90(Tab:K15:37)+String:C10($NextNumber_L)+Char:C90(Tab:K15:37)+$Result_txt+Char:C90(Tab:K15:37)

$LocalNumber_L:=Num:C11(Replace string:C233($Result_txt; $ReplaceMe_txt; ""))
If ($LocalNumber_L>$NextNumber_L)
	Begin SQL
		update
		[Sequences]
		set
		[Sequences].[Value] = :$LocalNumber_L
		where
		[Sequences].[Name] = :$SequenceName_txt;
		
		
		
	End SQL
	$Report_txt:=$Report_txt+"Updated sequence"
End if 
$Report_txt:=$Report_txt+Char:C90(Carriage return:K15:38)
//[LSS_TowerDistance]LSS_TowerDistanceId_s
$SequenceName_txt:="LSS_TowerDistanceId_s"
$NextNumber_L:=0
Begin SQL
	select [Sequences].[Value]
	from
	[Sequences] 
	where
	[Sequences].[Name] = :$SequenceName_txt
	into
	:$NextNumber_L;
	
	select max([LSS_TowerDistance].[LSS_TowerDistanceId_s])
	from
	[LSS_TowerDistance]
	where
	[LSS_TowerDistance].[LSS_TowerDistanceId_s] like :$Query_txt
	into 
	:$Result_txt;
	
	
End SQL
$Report_txt:=$Report_txt+$SequenceName_txt+Char:C90(Tab:K15:37)+String:C10($NextNumber_L)+Char:C90(Tab:K15:37)+$Result_txt+Char:C90(Tab:K15:37)

$LocalNumber_L:=Num:C11(Replace string:C233($Result_txt; $ReplaceMe_txt; ""))
If ($LocalNumber_L>$NextNumber_L)
	Begin SQL
		update
		[Sequences]
		set
		[Sequences].[Value] = :$LocalNumber_L
		where
		[Sequences].[Name] = :$SequenceName_txt;
		
		
		
	End SQL
	$Report_txt:=$Report_txt+"Updated sequence"
End if 
$Report_txt:=$Report_txt+Char:C90(Carriage return:K15:38)
//[LSS_UT]LSS_UTId_s
$SequenceName_txt:="LSS_UTId_s"
$NextNumber_L:=0
Begin SQL
	select [Sequences].[Value]
	from
	[Sequences] 
	where
	[Sequences].[Name] = :$SequenceName_txt
	into
	:$NextNumber_L;
	
	select max([LSS_UT].[LSS_UTId_s])
	from
	[LSS_UT]
	where
	[LSS_UT].[LSS_UTId_s] like :$Query_txt
	into 
	:$Result_txt;
	
	
End SQL
$Report_txt:=$Report_txt+$SequenceName_txt+Char:C90(Tab:K15:37)+String:C10($NextNumber_L)+Char:C90(Tab:K15:37)+$Result_txt+Char:C90(Tab:K15:37)

$LocalNumber_L:=Num:C11(Replace string:C233($Result_txt; $ReplaceMe_txt; ""))
If ($LocalNumber_L>$NextNumber_L)
	Begin SQL
		update
		[Sequences]
		set
		[Sequences].[Value] = :$LocalNumber_L
		where
		[Sequences].[Name] = :$SequenceName_txt;
		
		
		
	End SQL
End if 
$Report_txt:=$Report_txt+Char:C90(Carriage return:K15:38)
//[LSS_UtResult]LSS_UTResultId_s
$SequenceName_txt:="LSS_UTResultId_s"
$NextNumber_L:=0
Begin SQL
	select [Sequences].[Value]
	from
	[Sequences] 
	where
	[Sequences].[Name] = :$SequenceName_txt
	into
	:$NextNumber_L;
	
	select max([LSS_UtResult].[LSS_UTResultId_s])
	from
	[LSS_UtResult]
	where
	[LSS_UtResult].[LSS_UTResultId_s] like :$Query_txt
	into 
	:$Result_txt;
	
	
End SQL
$Report_txt:=$Report_txt+$SequenceName_txt+Char:C90(Tab:K15:37)+String:C10($NextNumber_L)+Char:C90(Tab:K15:37)+$Result_txt+Char:C90(Tab:K15:37)

$LocalNumber_L:=Num:C11(Replace string:C233($Result_txt; $ReplaceMe_txt; ""))
If ($LocalNumber_L>$NextNumber_L)
	Begin SQL
		update
		[Sequences]
		set
		[Sequences].[Value] = :$LocalNumber_L
		where
		[Sequences].[Name] = :$SequenceName_txt;
		
		
		
	End SQL
	$Report_txt:=$Report_txt+"Updated sequence"
End if 
$Report_txt:=$Report_txt+Char:C90(Carriage return:K15:38)
//[LSS_VerticalClearance]LSS_VerticalClearanceId_s

$SequenceName_txt:="LSS_VerticalClearanceId_s"
$NextNumber_L:=0
Begin SQL
	select [Sequences].[Value]
	from
	[Sequences] 
	where
	[Sequences].[Name] = :$SequenceName_txt
	into
	:$NextNumber_L;
	
	select max([LSS_VerticalClearance].[LSS_VerticalClearanceId_s])
	from
	[LSS_VerticalClearance]
	where
	[LSS_VerticalClearance].[LSS_VerticalClearanceId_s] like :$Query_txt
	into 
	:$Result_txt;
	
	
End SQL
$Report_txt:=$Report_txt+$SequenceName_txt+Char:C90(Tab:K15:37)+String:C10($NextNumber_L)+Char:C90(Tab:K15:37)+$Result_txt+Char:C90(Tab:K15:37)

$LocalNumber_L:=Num:C11(Replace string:C233($Result_txt; $ReplaceMe_txt; ""))
If ($LocalNumber_L>$NextNumber_L)
	Begin SQL
		update
		[Sequences]
		set
		[Sequences].[Value] = :$LocalNumber_L
		where
		[Sequences].[Name] = :$SequenceName_txt;
		
	End SQL
	$Report_txt:=$Report_txt+"Updated sequence"
End if 
$Report_txt:=$Report_txt+Char:C90(Carriage return:K15:38)
C_TIME:C306($doc_tm)

$doc_tm:=Create document:C266("")
SEND PACKET:C103($doc_tm; $Report_txt)
CLOSE DOCUMENT:C267($doc_tm)
SHOW ON DISK:C922(Document)


//[LSS_refInspectionType]LSS_InspectionTypeId_s

//[LSS_refRouteDirection]LSS_RouteDirectionId_s
//[LSS_refStructureCoating]LSS_StructureCoatingId_s
//[LSS_refStructureMaterial]LSS_StructureMaterialId_s
//[LSS_refStructureTypes]LSS_StructureTypeId_s



//End ut_CheckAndreportSequences

