//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/27/07, 09:03:39
	// ----------------------------------------------------
	// Method: WRT_GetSetMargins
	// Description
	// Get or set margins for an 4D Write area.
	// 
	// Parameters
	// $1 : $Area
	//$2 : $GetSetOption : text ("GET" | "SET")
	// ----------------------------------------------------
	
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(10/18/10 09:18:53)
	Mods_2010_10
	//  `Changed the order of the SET commands
End if 

//C_LONGINT($1;$Area)
//C_TEXT($2;$GetSetOption)
//$Area:=$1
//$GetSetOption:=$2

//C_REAL(QR_TxtInside_r;QR_TxtOutside_r;QR_TxtLeft_r;QR_TxtRight_r;QR_TxtTop_r;QR_TxtBot_r;QR_HeaderTop_r;QR_HeaderBot_r)
//C_REAL(QR_FooterTop_r;QR_FooterBot_r;QR_PaperW_r;QR_PaperH_r;QR_DeadLeft_r;QR_DeadTop_r;QR_PrintW_r;QR_PrintH_r)
//C_REAL(QR_DiffFirstPg_r;QR_FirstTop_r;QR_FirstBot_r;QR_FirstHeadTop_r;QR_FirstHeadBot_r;QR_FirstFootTop_r;QR_FirstFootBot_r)

//Case of 
//: ($GetSetOption="GET")
//QR_TxtInside_r:=WR Get doc property ($Area;wr text inside margin)
//QR_TxtOutside_r:=WR Get doc property ($Area;wr text outside margin)
//QR_TxtLeft_r:=WR Get doc property ($Area;wr text left margin)
//QR_TxtRight_r:=WR Get doc property ($Area;wr text right margin)
//QR_HeaderTop_r:=WR Get doc property ($Area;wr header top margin)
//QR_HeaderBot_r:=WR Get doc property ($Area;wr header bottom margin)
//QR_TxtTop_r:=WR Get doc property ($Area;wr text top margin)
//QR_TxtBot_r:=WR Get doc property ($Area;wr text bottom margin)
//QR_FooterTop_r:=WR Get doc property ($Area;wr footer top margin)
//QR_FooterBot_r:=WR Get doc property ($Area;wr footer bottom margin)
//QR_PaperW_r:=WR Get doc property ($Area;wr paper width)
//QR_PaperH_r:=WR Get doc property ($Area;wr paper height)
//QR_DeadLeft_r:=WR Get doc property ($Area;wr dead left margin)
//QR_DeadTop_r:=WR Get doc property ($Area;wr dead top margin)
//QR_PrintW_r:=WR Get doc property ($Area;wr printable width)
//QR_PrintH_r:=WR Get doc property ($Area;wr printable height)
//QR_DiffFirstPg_r:=WR Get doc property ($Area;wr different on first page)
//QR_FirstTop_r:=WR Get doc property ($Area;wr first page top margin)
//QR_FirstBot_r:=WR Get doc property ($Area;wr first page bottom margin)
//QR_FirstHeadTop_r:=WR Get doc property ($Area;wr header 1st page top margin)
//QR_FirstHeadBot_r:=WR Get doc property ($Area;wr header 1st page bottom mg)
//QR_FirstFootTop_r:=WR Get doc property ($Area;wr footer 1st page top margin)
//QR_FirstFootBot_r:=WR Get doc property ($Area;wr footer 1st page bottom mg)

//: ($GetSetOption="SET")
//WR SET DOC PROPERTY ($Area;wr paper width;QR_PaperW_r)
//WR SET DOC PROPERTY ($Area;wr paper height;QR_PaperH_r)
//WR SET DOC PROPERTY ($Area;wr printable width;QR_PrintW_r)
//WR SET DOC PROPERTY ($Area;wr printable height;QR_PrintH_r)
//WR SET DOC PROPERTY ($Area;wr dead left margin;QR_DeadLeft_r)
//WR SET DOC PROPERTY ($Area;wr dead top margin;QR_DeadTop_r)
//WR SET DOC PROPERTY ($Area;wr different on first page;QR_DiffFirstPg_r)
//WR SET DOC PROPERTY ($Area;wr text inside margin;QR_TxtInside_r)
//WR SET DOC PROPERTY ($Area;wr text outside margin;QR_TxtOutside_r)
//WR SET DOC PROPERTY ($Area;wr text left margin;QR_TxtLeft_r)
//WR SET DOC PROPERTY ($Area;wr text right margin;QR_TxtRight_r)
//WR SET DOC PROPERTY ($Area;wr header 1st page top margin;QR_FirstHeadTop_r)
//WR SET DOC PROPERTY ($Area;wr header 1st page bottom mg;QR_FirstHeadBot_r)
//WR SET DOC PROPERTY ($Area;wr first page top margin;QR_FirstTop_r)
//WR SET DOC PROPERTY ($Area;wr first page bottom margin;QR_FirstBot_r)
//WR SET DOC PROPERTY ($Area;wr footer 1st page top margin;QR_FirstFootTop_r)
//WR SET DOC PROPERTY ($Area;wr footer 1st page bottom mg;QR_FirstFootBot_r)
//WR SET DOC PROPERTY ($Area;wr header top margin;QR_HeaderTop_r)
//WR SET DOC PROPERTY ($Area;wr header bottom margin;QR_HeaderBot_r)
//WR SET DOC PROPERTY ($Area;wr text top margin;QR_TxtTop_r)
//WR SET DOC PROPERTY ($Area;wr text bottom margin;QR_TxtBot_r)
//WR SET DOC PROPERTY ($Area;wr footer top margin;QR_FooterTop_r)
//WR SET DOC PROPERTY ($Area;wr footer bottom margin;QR_FooterBot_r)
//WR SET AREA PROPERTY ($Area;wr modified;1;"")
//WR SET AREA PROPERTY ($Area;wr confirm dialog;0;"")
//End case 