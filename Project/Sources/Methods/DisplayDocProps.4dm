//%attributes = {"invisible":true}
If (False:C215)
	DisplayDocProps
	// Modified by: costasmanousakis-(Designer)-(2/7/2007 14:50:22)
	Mods_2007_CM06
	Mods_2009_03  //CJM  r001   `03/06/09, 13:07:51`Upgrade from open form window to open window
	
	Mods_2021_Delete
End if 
//ARRAY TEXT($aDocValues;70)  //Command Replaced was o_ARRAY string length was 32
//ARRAY TEXT($aLabels;70)  //Command Replaced was o_ARRAY string length was 60
//ARRAY INTEGER($aCodes;70)
//C_LONGINT($cvars;$i)  //Command Replaced was o_C_INTEGER
//$i:=1
//$acodes{$i}:=wr first page
//$aLabels{$i}:="wr first page-"+String(wr first page)
//$i:=$i+1
//$acodes{$i}:=wr view mode
//$aLabels{$i}:="wr view mode-"+String(wr view mode)
//$i:=$i+1
//$acodes{$i}:=wr view rulers
//$aLabels{$i}:="wr view rulers-"+String(wr view rulers)
//$i:=$i+1
//$acodes{$i}:=wr view frames
//$aLabels{$i}:="wr view frames-"+String(wr view frames)
//$i:=$i+1
//$acodes{$i}:=wr view headers
//$aLabels{$i}:="wr view headers-"+String(wr view headers)
//$i:=$i+1
//$acodes{$i}:=wr view footers
//$aLabels{$i}:="wr view footers-"+String(wr view footers)
//$i:=$i+1
//$acodes{$i}:=wr view pictures
//$aLabels{$i}:="wr view pictures-"+String(wr view pictures)
//$i:=$i+1
//$acodes{$i}:=wr view Hscrollbar
//$aLabels{$i}:="wr view Hscrollbar-"+String(wr view Hscrollbar)
//$i:=$i+1
//$acodes{$i}:=wr view Vscrollbar
//$aLabels{$i}:="wr view Vscrollbar-"+String(wr view Vscrollbar)
//$i:=$i+1
//$acodes{$i}:=wr view statusbar
//$aLabels{$i}:="wr view statusbar-"+String(wr view statusbar)
//$i:=$i+1
//$acodes{$i}:=wr view menubar
//$aLabels{$i}:="wr view menubar-"+String(wr view menubar)
//$i:=$i+1
//$acodes{$i}:=wr view standard palette
//$aLabels{$i}:="wr view standard palette-"+String(wr view standard palette)
//$i:=$i+1
//$acodes{$i}:=wr view format palette
//$aLabels{$i}:="wr view format palette-"+String(wr view format palette)
//$i:=$i+1
//$acodes{$i}:=wr view style palette
//$aLabels{$i}:="wr view style palette-"+String(wr view style palette)
//$i:=$i+1
//$acodes{$i}:=wr view borders palette
//$aLabels{$i}:="wr view borders palette-"+String(wr view borders palette)
//$i:=$i+1
//$acodes{$i}:=wr view invisible chars
//$aLabels{$i}:="wr view invisible chars-"+String(wr view invisible chars)
//$i:=$i+1
//$acodes{$i}:=wr view references
//$aLabels{$i}:="wr view references-"+String(wr view references)
//$i:=$i+1
//$acodes{$i}:=wr view column separators
//$aLabels{$i}:="wr view column separators-"+String(wr view column separators)
//$i:=$i+1
//$acodes{$i}:=wr different on first page
//$aLabels{$i}:="wr different on first page-"+String(wr different on first page)
//$i:=$i+1
//$acodes{$i}:=wr different left right pages
//$aLabels{$i}:="wr different left right pages-"+String(wr different left right pages)
//$i:=$i+1
//$acodes{$i}:=wr widow orphan
//$aLabels{$i}:="wr widow orphan-"+String(wr widow orphan)
//$i:=$i+1
//$acodes{$i}:=wr unit
//$aLabels{$i}:="wr unit-"+String(wr unit)
//$i:=$i+1
//$acodes{$i}:=wr default tab
//$aLabels{$i}:="wr default tab-"+String(wr default tab)
//$i:=$i+1
//$acodes{$i}:=wr language
//$aLabels{$i}:="wr language-"+String(wr language)
//$i:=$i+1
//$acodes{$i}:=wr number of columns
//$aLabels{$i}:="wr number of columns-"+String(wr number of columns)
//$i:=$i+1
//$acodes{$i}:=wr columns spacing
//$aLabels{$i}:="wr columns spacing-"+String(wr columns spacing)
//$i:=$i+1
//$acodes{$i}:=wr binding
//$aLabels{$i}:="wr binding-"+String(wr binding)
//$i:=$i+1
//$acodes{$i}:=wr opposite pages
//$aLabels{$i}:="wr opposite pages-"+String(wr opposite pages)
//$i:=$i+1
//$acodes{$i}:=wr right first page
//$aLabels{$i}:="wr right first page-"+String(wr right first page)
//$i:=$i+1
//$acodes{$i}:=wr text inside margin
//$aLabels{$i}:="wr text inside margin-"+String(wr text inside margin)
//$i:=$i+1
//$acodes{$i}:=wr text left margin
//$aLabels{$i}:="wr text left margin-"+String(wr text left margin)
//$i:=$i+1
//$acodes{$i}:=wr text outside margin
//$aLabels{$i}:="wr text outside margin-"+String(wr text outside margin)
//$i:=$i+1
//$acodes{$i}:=wr text right margin
//$aLabels{$i}:="wr text right margin-"+String(wr text right margin)
//$i:=$i+1
//$acodes{$i}:=wr text top margin
//$aLabels{$i}:="wr text top margin-"+String(wr text top margin)
//$i:=$i+1
//$acodes{$i}:=wr text bottom margin
//$aLabels{$i}:="wr text bottom margin-"+String(wr text bottom margin)
//$i:=$i+1
//$acodes{$i}:=wr header top margin
//$aLabels{$i}:="wr header top margin-"+String(wr header top margin)
//$i:=$i+1
//$acodes{$i}:=wr header bottom margin
//$aLabels{$i}:="wr header bottom margin-"+String(wr header bottom margin)
//$i:=$i+1
//$acodes{$i}:=wr footer top margin
//$aLabels{$i}:="wr footer top margin-"+String(wr footer top margin)
//$i:=$i+1
//$acodes{$i}:=wr footer bottom margin
//$aLabels{$i}:="wr footer bottom margin-"+String(wr footer bottom margin)
//$i:=$i+1
//$acodes{$i}:=wr paper width
//$aLabels{$i}:="wr paper width-"+String(wr paper width)
//$i:=$i+1
//$acodes{$i}:=wr paper height
//$aLabels{$i}:="wr paper height-"+String(wr paper height)
//$i:=$i+1
//$acodes{$i}:=wr dead left margin
//$aLabels{$i}:="wr dead left margin-"+String(wr dead left margin)
//$i:=$i+1
//$acodes{$i}:=wr dead top margin
//$aLabels{$i}:="wr dead top margin-"+String(wr dead top margin)
//$i:=$i+1
//$acodes{$i}:=wr printable width
//$aLabels{$i}:="wr printable width-"+String(wr printable width)
//$i:=$i+1
//$acodes{$i}:=wr printable height
//$aLabels{$i}:="wr printable height-"+String(wr printable height)
//$i:=$i+1
//$acodes{$i}:=wr data size
//$aLabels{$i}:="wr data size-"+String(wr data size)
//$i:=$i+1
//$acodes{$i}:=wr undo buffer size
//$aLabels{$i}:="wr undo buffer size-"+String(wr undo buffer size)
//$i:=$i+1
//$acodes{$i}:=wr horizontal splitter
//$aLabels{$i}:="wr horizontal splitter-"+String(wr horizontal splitter)
//$i:=$i+1
//$acodes{$i}:=wr vertical splitter
//$aLabels{$i}:="wr vertical splitter-"+String(wr vertical splitter)
//$i:=$i+1
//$acodes{$i}:=wr links color
//$aLabels{$i}:="wr links color-"+String(wr links color)
//$i:=$i+1
//$acodes{$i}:=wr visited links color
//$aLabels{$i}:="wr visited links color-"+String(wr visited links color)
//$i:=$i+1
//$acodes{$i}:=wr view frame area
//$aLabels{$i}:="wr view frame area-"+String(wr view frame area)
//$i:=$i+1
//$acodes{$i}:=wr view first page header
//$aLabels{$i}:="wr view first page header-"+String(wr view first page header)
//$i:=$i+1
//$acodes{$i}:=wr view first page footer
//$aLabels{$i}:="wr view first page footer-"+String(wr view first page footer)
//$i:=$i+1
//$acodes{$i}:=wr first page top margin
//$aLabels{$i}:="wr first page top margin-"+String(wr first page top margin)
//$i:=$i+1
//$acodes{$i}:=wr first page bottom margin
//$aLabels{$i}:="wr first page bottom margin-"+String(wr first page bottom margin)
//$i:=$i+1
//$acodes{$i}:=wr header 1st page top margin
//$aLabels{$i}:="wr header 1st page top margin-"+String(wr header 1st page top margin)
//$i:=$i+1
//$acodes{$i}:=wr header 1st page bottom mg
//$aLabels{$i}:="wr header 1st page bottom mg-"+String(wr header 1st page bottom mg)
//$i:=$i+1
//$acodes{$i}:=wr footer 1st page top margin
//$aLabels{$i}:="wr footer 1st page top margin-"+String(wr footer 1st page top margin)
//$i:=$i+1
//$acodes{$i}:=wr footer 1st page bottom mg
//$aLabels{$i}:="wr footer 1st page bottom mg-"+String(wr footer 1st page bottom mg)
//$i:=$i+1
//$acodes{$i}:=wr draft mode
//$aLabels{$i}:="wr draft mode-"+String(wr draft mode)
//$i:=$i+1
//$acodes{$i}:=wr column width
//$aLabels{$i}:="wr column width-"+String(wr column width)
//$cvars:=$i
//For ($i;1;$cvars)
//$aDocValues{$i}:=String(WR Get doc property ($1;$aCodes{$i}))
//End for 
//C_TEXT(msg)
//msg:=""
//For ($i;1;$cvars)
//msg:=msg+$aLabels{$i}+" : "+$aDocValues{$i}+Char(13)
//End for 
//C_LONGINT($newin)

//C_LONGINT($Width_l;$Height_l;$Win_l;$Pages_l)
//C_BOOLEAN($FixedWidth_b;$FixedHeight_b)
//C_TEXT($Title_txt)
//$Title_txt:="4DWriteDocProperites"
//FORM GET PROPERTIES([Dialogs];"Stats";$Width_l;$Height_l;$Pages_l;$FixedWidth_b;$FixedHeight_b;$Title_txt)
//$Win_l:=ut_OpenNewWindow ($Width_l;$Height_l;0;Plain form window;$Title_txt;"ut_CloseCancel")
//  //$newin:=Open form window([Dialogs];"Stats")
//  //SET WINDOW TITLE("4DWriteDocProperites";$newin)
//DIALOG([Dialogs];"Stats")
//CLOSE WINDOW($Win_l)