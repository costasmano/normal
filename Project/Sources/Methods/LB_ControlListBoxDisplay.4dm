//%attributes = {"invisible":true}
//Method: LB_ControlListBoxDisplay
//Description
//This method controls display of generic list box. It can hanle up to and inclduing 40 columns
//Before caling
//C_TEXT($NamedSelectionName_txt)
//$NamedSelectionName_txt:="◊QuerySelection_"+String(Current process)
//COPY NAMED SELECTION([Cond Units];$NamedSelectionName_txt)
//$pid:=New Process("LB_ControlListBoxDisplay";256*1024;"Cond Units LB";"CondUnitsQuery1";Table(->[Inspections]);"COND UNITS";$NamedSelectionName_txt)
// Parameters
// ----------------------------------------------------
//$1 Query name
//$2 Table number
//$3 Window Title (up 255 characters)
//$4 Interprocess named selection name

If (False:C215)
	//----------------------------------------------------
	//User name (OS): Charles Miller
	//Date and time: 01/03/12, 12:32:56
	//----------------------------------------------------
	Mods_2011_12  //r004
	//Modified by: Charles Miller (1/3/12 12:33:25)
	Mods_2019_01  // Add new list box itesm to display lss elements
	//Modified by: Chuck Miller (1/24/19 11:40:30)
End if 
READ ONLY:C145(*)

C_TEXT:C284($1; $QueryName_txt)
$QueryName_txt:=$1
C_LONGINT:C283($2)  //table number
C_TEXT:C284($3; $4)
C_TEXT:C284(NamedSelection_txt)
NamedSelection_txt:=$4

InitProcessVar
If (Current user:C182="Designer")
	READ WRITE:C146([LB_QueryTable:147])
Else 
	READ ONLY:C145([LB_QueryTable:147])
End if 
QUERY:C277([LB_QueryTable:147]; [LB_QueryTable:147]QueryName_s:1=$QueryName_txt)
C_BOOLEAN:C305($Continue_b)
$Continue_b:=True:C214
Case of 
	: (Records in selection:C76([LB_QueryTable:147])=0) & (Current user:C182="Designer")
		
		CREATE RECORD:C68([LB_QueryTable:147])
		[LB_QueryTable:147]QueryName_s:1:=$QueryName_txt
		[LB_QueryTable:147]TableNumber_l:3:=$2
		[LB_QueryTable:147]TableName_s:4:=Table name:C256([LB_QueryTable:147]TableNumber_l:3)
		[LB_QueryTable:147]WindowTitle_s:5:=$3
		Inc_Sequence("LB_QueryTable"; ->[LB_QueryTable:147]UniqueKey_l:6)
		LogNewRecord(->[LB_QueryTable:147]UniqueKey_l:6; ->[LB_QueryTable:147]UniqueKey_l:6; ->[LB_QueryTable:147]UniqueKey_l:6; 0; "LB_QueryTable")
		
		InitChangeStack(1)
		PushChange(1; ->[LB_QueryTable:147]QueryName_s:1)
		PushChange(1; ->[LB_QueryTable:147]TableNumber_l:3)
		PushChange(1; ->[LB_QueryTable:147]TableName_s:4)
		PushChange(1; ->[LB_QueryTable:147]WindowTitle_s:5)
		FlushGrpChgs(1; ->[LB_QueryTable:147]UniqueKey_l:6; ->[LB_QueryTable:147]UniqueKey_l:6; ->[LB_QueryTable:147]UniqueKey_l:6; 0)
		
		SAVE RECORD:C53([LB_QueryTable:147])
	: (Records in selection:C76([LB_QueryTable:147])=1)
	Else 
		$Continue_b:=False:C215
		ALERT:C41("Design of this search "+$QueryName_txt+" is not completed. Contact database adminstrator")
		
End case 
If ($Continue_b)
	If (Current user:C182="Designer")
		ut_LoadRecordInteractiveV2(->[LB_QueryTable:147])
	Else 
		LOAD RECORD:C52([LB_QueryTable:147])
	End if 
	[LB_QueryTable:147]WindowTitle_s:5:=$3
	SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
	
	InitPers
	Compiler_LB
	//add in pre processing stuff based upon query name
	Case of 
		: ($QueryName_txt="LSS_ElementQuery")
			C_LONGINT:C283($Progress_L)
			$Progress_L:=Progress New
			Progress SET TITLE($progress_L; "Retrieving data. Please wait…")
			Progress SET PROGRESS($progress_L; 0)
			LSS_SetUp
			USE NAMED SELECTION:C332(NamedSelection_txt)
			C_BOOLEAN:C305(vIncludeComments)
			
			
			//: ([LSS_Inventory]LSS_Category_s="Light")
			//QUERY([LSS_refInspectionType];[LSS_refInspectionType]LSS_InspectionTypeId_s="LI@";*)
			//End case 
			//QUERY([LSS_refInspectionType]; & ;[LSS_refInspectionType]LSS_Description_txt="Routine")
			ARRAY TEXT:C222($Insp_ids; 0)
			
			ARRAY TEXT:C222(v_164_002_atxt; 0)
			ARRAY TEXT:C222(v_164_001_atxt; 0)
			ARRAY DATE:C224(v_164_004_ad; 0)
			
			ARRAY TEXT:C222(v_165_001_atxt; 0)
			ARRAY TEXT:C222(v_165_006_atxt; 0)
			
			
			LSS_SetUpAndSortForElementRpt
			COPY NAMED SELECTION:C331([LSS_ElementInspection:163]; NamedSelection_txt)
			Progress QUIT($Progress_L)
			
			
	End case 
	C_LONGINT:C283($Width; $Height)
	FORM GET PROPERTIES:C674("SelectListBox"; $Width; $Height)
	ut_OpenNewWindow($Width; $Height; 2; 0; ""; "ut_CloseCancel")
	UpdatWindArray(""; Current process:C322)
	DIALOG:C40("SelectListBox")
	
	CLEAR SET:C117("MyLocalSet")
	CLEAR SET:C117("SelectedRecordsSet")
	CLEAR NAMED SELECTION:C333("MyLocalNamedSelection")
	CLOSE WINDOW:C154
	UpdatWindArray(""; Current process:C322; True:C214)
	
End if 
//End LB_ControlListBoxDisplay

