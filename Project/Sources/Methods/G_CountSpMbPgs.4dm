//%attributes = {"invisible":true}
If (False:C215)
	//G_CountSpMbPgs
	//count Special memb pages for non-combined inspections
	Mods_2004_CM11  //twice
	Mods_2005_VN01
	// Modified by: costasmanousakis-(Designer)-(2/17/09 16:48:15)
	Mods_2009_CM_5404  // --- "FREEZETHAW"
	Mods_2013_01  //r001 ` Add railroad inspection types
	//Modified by: Charles Miller (2/12/13 16:38:48)
	Mods_2013_05  //r003 ` Add TSP inspection type
	//Modified by: Charles Miller (5/7/13 16:53:32)
	Mods_2013_05  //r003 ` Change number of items on page for  ([Inspections]Insp Type="TSP") to 6
	//Modified by: Charles Miller (5/21/13 15:39:26)
	// Modified by: Costas Manousakis-(Designer)-(4/14/14 11:36:38)
	Mods_2014_04
	//  `use method INSP_SetSpMbPrintForm to get form names and element counts
End if 

C_LONGINT:C283($0; $viNumpgs)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($vlnumrecs; $viElmtsPerPage; $viElmtsperPage2)
C_TEXT:C284($dummy1_txt; $dummy2_txt)
SET QUERY DESTINATION:C396(Into variable:K19:4; $vlnumrecs)
QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Rating:2#"N")
SET QUERY DESTINATION:C396(Into current selection:K19:1)
INSP_SetSpMbPrintForm([Inspections:27]Insp Type:6; ->$dummy1_txt; ->$viElmtsPerPage; ->$dummy2_txt; ->$viElmtsperPage2)
Case of 
	: ([Inspections:27]Insp Type:6="FRZ")
		$viNumpgs:=Print_Freeze_pg1(False:C215)
	Else 
		
		If ($vlnumrecs<=$viElmtsPerPage)
			$viNumpgs:=1
		Else 
			$vlnumrecs:=$vlnumrecs-$viElmtsPerPage
			$viNumpgs:=-(Trunc:C95(-($vlnumrecs/$viElmtsperPage2); 0))
			$viNumpgs:=$viNumpgs+1
		End if 
End case 

$0:=$viNumpgs