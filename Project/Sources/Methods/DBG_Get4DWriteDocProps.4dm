//%attributes = {"invisible":true}
//Method: DBG_Get4DWriteDocProps
//Description
// get document properties of a 4D Write area - return as a text
// Parameters
// $0 : $opts_txt
// $1 : $Area_L
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/22/17, 11:22:55
	// ----------------------------------------------------
	//Created : 
	Mods_2017_11
	
	C_TEXT:C284(DBG_Get4DWriteDocProps; $0)
	C_LONGINT:C283(DBG_Get4DWriteDocProps; $1)
	
	Mods_2021_Delete
End if 
//

//C_TEXT($0)
//C_LONGINT($1)

//C_TEXT($opts_txt)
//$opts_txt:=""

//$opts_txt:=$opts_txt+"wr binding : "+Char(9)+String(WR Get doc property ($1;wr binding))+Char(13)
//$opts_txt:=$opts_txt+"wr column width : "+Char(9)+String(WR Get doc property ($1;wr column width))+Char(13)
//$opts_txt:=$opts_txt+"wr columns spacing : "+Char(9)+String(WR Get doc property ($1;wr columns spacing))+Char(13)
//$opts_txt:=$opts_txt+"wr data size : "+Char(9)+String(WR Get doc property ($1;wr data size))+Char(13)
//$opts_txt:=$opts_txt+"wr dead left margin : "+Char(9)+String(WR Get doc property ($1;wr dead left margin))+Char(13)
//$opts_txt:=$opts_txt+"wr dead top margin : "+Char(9)+String(WR Get doc property ($1;wr dead top margin))+Char(13)
//$opts_txt:=$opts_txt+"wr default tab : "+Char(9)+String(WR Get doc property ($1;wr default tab))+Char(13)
//$opts_txt:=$opts_txt+"wr different left right pages : "+Char(9)+String(WR Get doc property ($1;wr different left right pages))+Char(13)
//$opts_txt:=$opts_txt+"wr different on first page : "+Char(9)+String(WR Get doc property ($1;wr different on first page))+Char(13)
//$opts_txt:=$opts_txt+"wr draft mode : "+Char(9)+String(WR Get doc property ($1;wr draft mode))+Char(13)
//$opts_txt:=$opts_txt+"wr first page : "+Char(9)+String(WR Get doc property ($1;wr first page))+Char(13)
//$opts_txt:=$opts_txt+"wr first page bottom margin : "+Char(9)+String(WR Get doc property ($1;wr first page bottom margin))+Char(13)
//$opts_txt:=$opts_txt+"wr first page top margin : "+Char(9)+String(WR Get doc property ($1;wr first page top margin))+Char(13)
//$opts_txt:=$opts_txt+"wr footer 1st page bottom mg : "+Char(9)+String(WR Get doc property ($1;wr footer 1st page bottom mg))+Char(13)
//$opts_txt:=$opts_txt+"wr footer 1st page top margin : "+Char(9)+String(WR Get doc property ($1;wr footer 1st page top margin))+Char(13)
//$opts_txt:=$opts_txt+"wr footer bottom margin : "+Char(9)+String(WR Get doc property ($1;wr footer bottom margin))+Char(13)
//$opts_txt:=$opts_txt+"wr footer top margin : "+Char(9)+String(WR Get doc property ($1;wr footer top margin))+Char(13)
//$opts_txt:=$opts_txt+"wr header 1st page bottom mg : "+Char(9)+String(WR Get doc property ($1;wr header 1st page bottom mg))+Char(13)
//$opts_txt:=$opts_txt+"wr header 1st page top margin : "+Char(9)+String(WR Get doc property ($1;wr header 1st page top margin))+Char(13)
//$opts_txt:=$opts_txt+"wr header bottom margin : "+Char(9)+String(WR Get doc property ($1;wr header bottom margin))+Char(13)
//$opts_txt:=$opts_txt+"wr header top margin : "+Char(9)+String(WR Get doc property ($1;wr header top margin))+Char(13)
//$opts_txt:=$opts_txt+"wr horizontal splitter : "+Char(9)+String(WR Get doc property ($1;wr horizontal splitter))+Char(13)
//$opts_txt:=$opts_txt+"wr language : "+Char(9)+String(WR Get doc property ($1;wr language))+Char(13)
//$opts_txt:=$opts_txt+"wr links color : "+Char(9)+String(WR Get doc property ($1;wr links color))+Char(13)
//$opts_txt:=$opts_txt+"wr number of columns : "+Char(9)+String(WR Get doc property ($1;wr number of columns))+Char(13)
//$opts_txt:=$opts_txt+"wr opposite pages : "+Char(9)+String(WR Get doc property ($1;wr opposite pages))+Char(13)
//$opts_txt:=$opts_txt+"wr paper height : "+Char(9)+String(WR Get doc property ($1;wr paper height))+Char(13)
//$opts_txt:=$opts_txt+"wr paper width : "+Char(9)+String(WR Get doc property ($1;wr paper width))+Char(13)
//$opts_txt:=$opts_txt+"wr printable height : "+Char(9)+String(WR Get doc property ($1;wr printable height))+Char(13)
//$opts_txt:=$opts_txt+"wr printable width : "+Char(9)+String(WR Get doc property ($1;wr printable width))+Char(13)
//$opts_txt:=$opts_txt+"wr right first page : "+Char(9)+String(WR Get doc property ($1;wr right first page))+Char(13)
//$opts_txt:=$opts_txt+"wr text bottom margin : "+Char(9)+String(WR Get doc property ($1;wr text bottom margin))+Char(13)
//$opts_txt:=$opts_txt+"wr text inside margin : "+Char(9)+String(WR Get doc property ($1;wr text inside margin))+Char(13)
//$opts_txt:=$opts_txt+"wr text left margin : "+Char(9)+String(WR Get doc property ($1;wr text left margin))+Char(13)
//$opts_txt:=$opts_txt+"wr text outside margin : "+Char(9)+String(WR Get doc property ($1;wr text outside margin))+Char(13)
//$opts_txt:=$opts_txt+"wr text right margin : "+Char(9)+String(WR Get doc property ($1;wr text right margin))+Char(13)
//$opts_txt:=$opts_txt+"wr text top margin : "+Char(9)+String(WR Get doc property ($1;wr text top margin))+Char(13)
//$opts_txt:=$opts_txt+"wr undo buffer size : "+Char(9)+String(WR Get doc property ($1;wr undo buffer size))+Char(13)
//$opts_txt:=$opts_txt+"wr unit : "+Char(9)+String(WR Get doc property ($1;wr unit))+Char(13)
//$opts_txt:=$opts_txt+"wr vertical splitter : "+Char(9)+String(WR Get doc property ($1;wr vertical splitter))+Char(13)
//$opts_txt:=$opts_txt+"wr view borders palette : "+Char(9)+String(WR Get doc property ($1;wr view borders palette))+Char(13)
//$opts_txt:=$opts_txt+"wr view column separators : "+Char(9)+String(WR Get doc property ($1;wr view column separators))+Char(13)
//$opts_txt:=$opts_txt+"wr view first page footer : "+Char(9)+String(WR Get doc property ($1;wr view first page footer))+Char(13)
//$opts_txt:=$opts_txt+"wr view first page header : "+Char(9)+String(WR Get doc property ($1;wr view first page header))+Char(13)
//$opts_txt:=$opts_txt+"wr view footers : "+Char(9)+String(WR Get doc property ($1;wr view footers))+Char(13)
//$opts_txt:=$opts_txt+"wr view format palette : "+Char(9)+String(WR Get doc property ($1;wr view format palette))+Char(13)
//$opts_txt:=$opts_txt+"wr view frame area : "+Char(9)+String(WR Get doc property ($1;wr view frame area))+Char(13)
//$opts_txt:=$opts_txt+"wr view frames : "+Char(9)+String(WR Get doc property ($1;wr view frames))+Char(13)
//$opts_txt:=$opts_txt+"wr view headers : "+Char(9)+String(WR Get doc property ($1;wr view headers))+Char(13)
//$opts_txt:=$opts_txt+"wr view Hscrollbar : "+Char(9)+String(WR Get doc property ($1;wr view Hscrollbar))+Char(13)
//$opts_txt:=$opts_txt+"wr view invisible chars : "+Char(9)+String(WR Get doc property ($1;wr view invisible chars))+Char(13)
//$opts_txt:=$opts_txt+"wr view menubar : "+Char(9)+String(WR Get doc property ($1;wr view menubar))+Char(13)
//$opts_txt:=$opts_txt+"wr view mode : "+Char(9)+String(WR Get doc property ($1;wr view mode))+Char(13)
//$opts_txt:=$opts_txt+"wr view pictures : "+Char(9)+String(WR Get doc property ($1;wr view pictures))+Char(13)
//$opts_txt:=$opts_txt+"wr view references : "+Char(9)+String(WR Get doc property ($1;wr view references))+Char(13)
//$opts_txt:=$opts_txt+"wr view rulers : "+Char(9)+String(WR Get doc property ($1;wr view rulers))+Char(13)
//$opts_txt:=$opts_txt+"wr view standard palette : "+Char(9)+String(WR Get doc property ($1;wr view standard palette))+Char(13)
//$opts_txt:=$opts_txt+"wr view statusbar : "+Char(9)+String(WR Get doc property ($1;wr view statusbar))+Char(13)
//$opts_txt:=$opts_txt+"wr view style palette : "+Char(9)+String(WR Get doc property ($1;wr view style palette))+Char(13)
//$opts_txt:=$opts_txt+"wr view Vscrollbar : "+Char(9)+String(WR Get doc property ($1;wr view Vscrollbar))+Char(13)
//$opts_txt:=$opts_txt+"wr visited links color : "+Char(9)+String(WR Get doc property ($1;wr visited links color))+Char(13)
//$opts_txt:=$opts_txt+"wr widow orphan : "+Char(9)+String(WR Get doc property ($1;wr widow orphan))+Char(13)

//$0:=$opts_txt
//  //End DBG_Get4DWriteDocPropc