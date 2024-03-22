//%attributes = {}
//Method: ARCH_AnnualMasterList
//Description
// Generate an annual Master List from records in the [BridgeMHDNBISArchive] table
// will use NBI Tape records
// requires templates WRP_MasterListStart and WRP_MasterListNonNBITitlePage
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Jan 3, 2024, 10:55:33
	Mods_2024_01
	// ----------------------------------------------------
	
End if 
//
C_OBJECT:C1216($WpArea; $letterhdArea)


READ ONLY:C145(*)
C_OBJECT:C1216($bridgearchives_o)
ARRAY TEXT:C222($NBITapes_; 0)

$bridgearchives_o:=ds:C1482.BridgeMHDNBISArchive.query("ArchiveReason_s = :1"; "NBI TAPE@")

ASSERT:C1129($bridgearchives_o.length>0; "No NBI Tape records found in table BridgeMHDNBISArchive")

C_COLLECTION:C1488($tapes_c)
$tapes_c:=$bridgearchives_o.distinct("ArchiveReason_s")

COLLECTION TO ARRAY:C1562($tapes_c; $NBITapes_)
SORT ARRAY:C229($NBITapes_; <)  // sort descending

C_LONGINT:C283($tape_)
$tape_:=G_PickFromList(->$NBITapes_; "Choose an NBI tape")

ASSERT:C1129($tape_>0; "Did not select an NBI Tape")

//check if WRP templates exist!
ASSERT:C1129(ds:C1482.Templates.query("TemplateName = :1"; "WRP_MasterListStart").length=1; "Template WRP_MasterListStart Does not exist!")
ASSERT:C1129(ds:C1482.Templates.query("TemplateName = :1"; "WRP_MasterListNonNBITitlePage").length=1; "Template WRP_MasterListNonNBITitlePage Does not exist!")

C_LONGINT:C283($MasterListYear)

$MasterListYear:=Num:C11($NBITapes_{$tape_})  // needed in the Write pro templates

SET PRINT OPTION:C733(Orientation option:K47:2; 2)  //Landscape
SET PRINT OPTION:C733(Paper option:K47:1; "Letter")
SET PRINT OPTION:C733(Scale option:K47:3; 100)
SET PRINT OPTION:C733(Spooler document name option:K47:10; "Master List "+String:C10($MasterListYear))
PRINT SETTINGS:C106
OPEN PRINTING JOB:C995
QUERY:C277([Templates:86]; [Templates:86]TemplateName:2="WRP_MasterListStart")
$WpArea:=WP New:C1317([Templates:86]Template_:3)
// replace YYYY with the master list
C_OBJECT:C1216($textrange_o)
C_LONGINT:C283($yyyy_L)

$textrange_o:=WP Text range:C1341($WpArea; wk start text:K81:165; wk end text:K81:164)
$yyyy_L:=Position:C15("YYYY"; WP Get text:C1575($textrange_o; wk expressions as value:K81:255))
$textrange_o:=WP Text range:C1341($WpArea; $yyyy_L; ($yyyy_L+4))
WP SET TEXT:C1574($textrange_o; String:C10($MasterListYear); wk replace:K81:177)

WP PRINT:C1343($WpArea; wk 4D Write Pro layout:K81:176)
QUERY:C277([BridgeMHDNBISArchive:139]; [BridgeMHDNBISArchive:139]ArchiveReason_s:223="NBI TAPE "+String:C10($MasterListYear); *)
QUERY:C277([BridgeMHDNBISArchive:139];  & [BridgeMHDNBISArchive:139]FHWARecord:173=True:C214)
C_OBJECT:C1216($params_)
$params_:=New object:C1471("title"; "Master List - NBIS Bridges")
ARCH_M_MasterList($params_)
If ($params_.pagecount%2>0)
	//add a blank page
	PAGE BREAK:C6
End if 
QUERY:C277([Templates:86]; [Templates:86]TemplateName:2="WRP_MasterListNonNBITitlePage")
$WpArea:=WP New:C1317([Templates:86]Template_:3)

$textrange_o:=WP Text range:C1341($WpArea; wk start text:K81:165; wk end text:K81:164)
$yyyy_L:=Position:C15("YYYY"; WP Get text:C1575($textrange_o; wk expressions as value:K81:255))
$textrange_o:=WP Text range:C1341($WpArea; $yyyy_L; ($yyyy_L+4))
WP SET TEXT:C1574($textrange_o; String:C10($MasterListYear); wk replace:K81:177)

WP PRINT:C1343($WpArea; wk 4D Write Pro layout:K81:176)

QUERY:C277([BridgeMHDNBISArchive:139]; [BridgeMHDNBISArchive:139]ArchiveReason_s:223="NBI TAPE "+String:C10($MasterListYear); *)
QUERY:C277([BridgeMHDNBISArchive:139];  & [BridgeMHDNBISArchive:139]FHWARecord:173=False:C215)
$params_.title:="Master List - Non-NBIS Bridges"
ARCH_M_MasterList($params_)

CLOSE PRINTING JOB:C996
SET PRINT OPTION:C733(Spooler document name option:K47:10; "Untitled")

//End ARCH_AnnualMasterList   