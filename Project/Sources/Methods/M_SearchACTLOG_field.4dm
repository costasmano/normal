//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/02/07, 09:55:31
	// ----------------------------------------------------
	// Method: M_SearchACTLOG_field
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM12_5302
	Mods_2009_03  //CJM  r001   `03/06/09, 15:11:50`Upgrade from open form window to open window
	
End if 
COPY NAMED SELECTION:C331([Activity Log:59]; "ARCHStartSelection")
C_BOOLEAN:C305($DoneSearching_b)
$DoneSearching_b:=False:C215
C_LONGINT:C283($TableNum_L; $FieldNum_L; $NumFields_L)
CREATE EMPTY SET:C140([Activity Log:59]; "ARCHResultSet")

C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
C_TEXT:C284($Title_txt)
FORM GET PROPERTIES:C674([Activity Log:59]; "SearchForField"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10; $Title_txt; "ut_CloseCancel")
//$win:=Open form window([Activity Log];"SearchForField")
DIALOG:C40([Activity Log:59]; "SearchForField")
CLOSE WINDOW:C154
If (OK=1)
	
	If (Records in set:C195("ARCHResultSet")>0)
		USE SET:C118("ARCHResultSet")
	End if 
Else 
	USE NAMED SELECTION:C332("ARCHStartSelection")
End if 
CLEAR NAMED SELECTION:C333("ARCHStartSelection")
CLEAR SET:C117("ARCHResultSet")