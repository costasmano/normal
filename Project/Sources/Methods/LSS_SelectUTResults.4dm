//%attributes = {"invisible":true}
// Method: LSS_SelectUTResults
// Description
// 
//
// Parameters
If (False:C215)
	
	// ----------------------------------------------------
	// User name (OS): administrator
	// Date and time: 09/04/14, 14:02:13
	// ----------------------------------------------------
	// ----------------------------------------------------
	
	// Modified by: Costas Manousakis-(Designer)-(5/13/16 16:03:07)
	Mods_2016_05_bug
	//  `Sort order for ut results should be location then Rod num.
	// Modified by: Costas Manousakis-(Designer)-(12/15/16 17:18:25)
	Mods_2016_12
	//  `use LSS_SortUTResults
	Mods_2018_08  //Add code to fix problem with UT page on ibput form where uncompoiled ut and ut results data not didplayed correctly
	//Changed list boxes to use named selections ""UT_LB" and "UTResults_LB"
	//Modified by: Chuck Miller (8/30/18 15:35:58)
	Mods_2018_10_bug  //Fix isse where UT seletion being lost. It looked like the results where not displaying.
	Mods_2019_02  //  //Change lss inspection input forms to use subforms wherever possible
	//Modified by: Chuck Miller (2/4/19 16:49:28)
	Mods_2019_10  //Made change to deselect row after editting
	//Modified by: Chuck Miller (10/7/19 14:03:22)
	// Modified by: Costas Manousakis-(Designer)-(8/24/20 17:47:56)
	Mods_2020_08_bug
	//  `get UTResults first then show the results LB and plus btn; also make sure plubtn for result si enabled if editable
End if 
C_LONGINT:C283($LBCol_L; LSS_UTRow_L)
USE NAMED SELECTION:C332("UT_LB")
LISTBOX GET CELL POSITION:C971(*; "UT_LB"; $LBCol_L; LSS_UTRow_L)
C_BOOLEAN:C305($SetButtons_B)
$SetButtons_B:=Not:C34(Read only state:C362([LSS_UT:175]))
LISTBOX SELECT ROW:C912(*; "UT_LB"; LSS_UTRow_L)
If (LSS_UTRow_L>0)
	GOTO SELECTED RECORD:C245([LSS_UT:175]; LSS_UTRow_L)
	QUERY:C277([LSS_UtResult:176]; [LSS_UtResult:176]LSS_UTId_s:2=[LSS_UT:175]LSS_UTId_s:1)
	LSS_SortUTResults
	
	COPY NAMED SELECTION:C331([LSS_UtResult:176]; "UTResults_LB")
	OBJECT SET VISIBLE:C603(*; "UTResults_@"; True:C214)
	OBJECT SET VISIBLE:C603(*; "PlusButton_UTResults"; LSS_AllowInspectionEdit_B)
	OBJECT SET VISIBLE:C603(*; "PlusButton_UT"; LSS_AllowInspectionEdit_B)
	OBJECT SET ENABLED:C1123(*; "PlusButton_UTResults"; LSS_AllowInspectionEdit_B)
	
	REDRAW:C174(UTResults_LB)
	//
	//ORDER BY([LSS_UtResult];[LSS_UtResult]LSS_Location_txt;>;[LSS_UtResult]LSS_RodNo_L;>)
Else 
	OBJECT SET VISIBLE:C603(*; "PlusButton_UTResults"; False:C215)
	OBJECT SET ENABLED:C1123(*; "PlusButton_UTResults"; False:C215)
	OBJECT SET VISIBLE:C603(*; "UTResults_@"; False:C215)
	LISTBOX SELECT ROW:C912(*; "UT_LB"; 0; 2)
End if 