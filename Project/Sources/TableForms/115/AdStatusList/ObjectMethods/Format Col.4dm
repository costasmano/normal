// ----------------------------------------------------
// Object Method: bColFmt
// User name (OS): charlesmiller
// Date and time: 03/06/09, 12:49:30
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2009_03  //CJM  r001   `03/06/09, 12:49:32`Upgrade from open form window to open window
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 


Case of 
	: (Form event code:C388=On Load:K2:1)
		If (Current user:C182="Designer")
			OBJECT SET VISIBLE:C603(Self:C308->; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(Self:C308->; False:C215)
		End if 
	: (Form event code:C388=On Clicked:K2:4)
		//C_LONGINT($VArea;$rows;$col;$Cols;$i;$BDEPTF)
		//$VArea:=AdStatusVArea
		//$rows:=Size of array(PRJAD_RecNum_aL)
		//$Rows:=PV Get document property ($VArea;pv row count)
		//$Cols:=PV Get document property ($VArea;pv column count)
		//ARRAY TEXT(PVCOLNAMES_atxt;$Cols)
		//C_TEXT($colHdr_txt)
		//For ($i;1;$Cols)
		//PV GET COLUMN HEADER ($VArea;$i;$colHdr_txt)
		//PVCOLNAMES_atxt{$i}:=$colHdr_txt
		//End for 
		
		//$col:=G_PickFromList (->PVCOLNAMES_atxt)
		//C_LONGINT(pv_colWidth;pv_horAlign;pv_vertAlign;pv_AlphaF;pv_NumF;pv_boolF;pv_DateF;pv_PicF)
		//pv_colWidth:=PV Get column width ($VArea;$col)
		//pv_horAlign:=PV Get range property ($VArea;$col;1;$col;$rows;pv style hor alignment)
		//pv_vertAlign:=PV Get range property ($VArea;$col;1;$col;$rows;pv style vert alignment)
		//pv_AlphaF:=PV Get range property ($VArea;$col;1;$col;$rows;pv style format alpha)
		//pv_NumF:=PV Get range property ($VArea;$col;1;$col;$rows;pv style format num)
		//pv_boolF:=PV Get range property ($VArea;$col;1;$col;$rows;pv style format bool)
		//pv_DateF:=PV Get range property ($VArea;$col;1;$col;$rows;pv style format date time)
		//pv_PicF:=PV Get range property ($VArea;$col;1;$col;$rows;pv style format picture)
		//ARRAY LONGINT(pv_formatlist;0)
		//ARRAY TEXT(pv_formatstrings;0)
		//C_TEXT($bdeptf_txt;$Item8f_txt;$Aashtof_txt;$moneyF_txt)
		//$bdeptf_txt:="#-##-#####-##-###"
		//$Item8f_txt:="######-###-###-###"
		//$Aashtof_txt:="##0.0"
		//$moneyF_txt:="$###,###,###,##0.00"
		//PV GET FORMAT LIST ($VArea;pv_formatlist;pv_formatstrings)
		//If (Find in array(pv_formatstrings;$bdeptf_txt)<=0)
		//$BDEPTF:=PV Add format ($VArea;$bdeptf_txt)
		//End if 
		//If (Find in array(pv_formatstrings;$Item8f_txt)<=0)
		//$BDEPTF:=PV Add format ($VArea;$Item8f_txt)
		//End if 
		//If (Find in array(pv_formatstrings;$Aashtof_txt)<=0)
		//$BDEPTF:=PV Add format ($VArea;$Aashtof_txt)
		//End if 
		//If (Find in array(pv_formatstrings;$moneyF_txt)<=0)
		//$BDEPTF:=PV Add format ($VArea;$moneyF_txt)
		//End if 
		//PV GET FORMAT LIST ($VArea;pv_formatlist;pv_formatstrings)
		
		
		//C_LONGINT($Width_l;$Height_l;$Win_l;$Pages_l)
		//C_BOOLEAN($FixedWidth_b;$FixedHeight_b)
		//C_TEXT($Title_txt)
		//FORM GET PROPERTIES([Dialogs];"PV_ColumnFormats";$Width_l;$Height_l;$Pages_l;$FixedWidth_b;$FixedHeight_b;$Title_txt)
		//$Win_l:=ut_OpenNewWindow ($Width_l;$Height_l;0;Plain form window;$Title_txt;"ut_CloseCancel")
		//  //$twin:=Open form window([Dialogs];"PV_ColumnFormats")
		//DIALOG([Dialogs];"PV_ColumnFormats")
		//CLOSE WINDOW($Win_l)
		//If (OK=1)
		//PV SET COLUMNS WIDTH ($VArea;$col;$col;pv_colWidth)
		//PV SET RANGE PROPERTY ($VArea;$col;1;$col;$rows;pv style hor alignment;pv_horAlign)
		//PV SET RANGE PROPERTY ($VArea;$col;1;$col;$rows;pv style vert alignment;pv_vertAlign)
		//PV SET RANGE PROPERTY ($VArea;$col;1;$col;$rows;pv style format alpha;pv_AlphaF)
		//PV SET RANGE PROPERTY ($VArea;$col;1;$col;$rows;pv style format num;pv_NumF)
		//PV SET RANGE PROPERTY ($VArea;$col;1;$col;$rows;pv style format date time;pv Short2)
		//PV SET RANGE PROPERTY ($VArea;$col;1;$col;$rows;pv style format bool;pv_BoolF)
		//End if 
		//ARRAY TEXT(PVCOLNAMES_atxt;0)
End case 

//End Object Method: bColFmt