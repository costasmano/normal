//%attributes = {"invisible":true}
If (False:C215)
	//Project Method : Set Doc Margins
	//Set Doc Margins(area)
	
	//$1 : area of document
	Mods_2004_CM11
	// Modified by: costasmanousakis-(Designer)-(5/15/09 10:17:58)
	Mods_2009_05
	//Removed unnecessary set of WR SET TEXT PROPERTY ($MyArea;wr line spacing; commands
	//they are called in G_Insp_ApplyLineSpacing
	// Modified by: Costas Manousakis-(Designer)-(9/14/12 16:07:45)
	Mods_2012_09
	//  `increased wr paper width  from 7.4 to 7.5 ; and wr text right margin from 0 to 0.1 to prevent cutting off letters.
	// Modified by: Costas Manousakis-(Designer)-(11/3/17 15:52:19)
	Mods_2017_11
	//  `Use Wr set print option (paper option) to set the page setup for printing
	//  //match the width and height in pixels = inches * 72
	// Modified by: Costas Manousakis-(Designer)-(4/6/18 16:51:26)
	Mods_2018_04
	//  `added blocking of CMD-new; CMD-Open; CMD-Save to disable cmd-N and cmd-O keystrokes.
End if 

//C_LONGINT($1;$MyArea)
//C_REAL($2)  //Paper Height
//C_REAL($vrPaperHt)
//$MyArea:=$1
//If (Count parameters=2)
//$vrPaperHt:=$2
//Else 
//$vrPaperHt:=9.18
//End if 

//  //testing:=True

//‘12000;109‘ ($MyArea;‘k12003;22‘;‘k12011;71‘)  //inches
//‘12000;109‘ ($MyArea;‘k12003;41‘;$vrPaperHt)
//‘12000;109‘ ($MyArea;‘k12003;40‘;7.5)
//  //WR SET PRINT OPTION ($MyArea;wr paper option;(7.5*72);($vrPaperHt*72))
//  //WR SET PRINT OPTION ($MyArea;wr orientation option;wr portrait)
//  //WR SET DOC PROPERTY ($MyArea;wr unit;wr pixels)
//  //WR SET PRINT OPTION ($MyArea;wr paper option;WR Get doc property ($MyArea;wr paper height);WR Get doc property ($MyArea;wr paper width))
//  //WR SET DOC PROPERTY ($MyArea;wr unit;wr inches)

//‘12000;109‘ ($MyArea;‘k12003;36‘;0)
//‘12000;109‘ ($MyArea;‘k12003;37‘;0)
//‘12000;109‘ ($MyArea;‘k12003;39‘;0)
//‘12000;109‘ ($MyArea;‘k12003;38‘;0)
//‘12000;109‘ ($MyArea;‘k12003;33‘;0.1)
//‘12000;109‘ ($MyArea;‘k12003;32‘;0)
//‘12000;109‘ ($MyArea;‘k12003;35‘;0)

//  //WR SET TEXT PROPERTY ($MyArea;wr line spacing ;1)
//If (False)
//If ([Inspections]Insp Type="DV@")  //use 1:1.1=Mac:PC for arial 11
//If (<>PL_LPlatfrm#3)  //if mac platform  
//‘12000;103‘ ($MyArea;‘k12000;17‘;1)
//Else 
//‘12000;103‘ ($MyArea;‘k12000;17‘;1.1)
//End if 
//Else   //use 1.1:1=Mac:PC for arial 11  
//If (<>PL_LPlatfrm#3)  //if mac platform  
//‘12000;103‘ ($MyArea;‘k12000;17‘;1.1)
//Else 
//‘12000;103‘ ($MyArea;‘k12000;17‘;1)
//End if 
//End if 
//End if 
//G_Insp_ApplyLineSpacing ($MyArea)
//‘12000;109‘ ($MyArea;‘k12003;34‘;0)
//‘12000;105‘ ($MyArea;vInspFontName)  //default font
//‘12000;103‘ ($MyArea;‘k12000;9‘;vInspFontSize)  //default font size
//‘12000;114‘ ($MyArea;100;1)  // lock file menu.
//‘12000;114‘ ($MyArea;‘k12007;44‘;1)  //includes file menu commands
//‘12000;114‘ ($MyArea;‘k12007;170‘;1)
//‘12000;114‘ ($MyArea;‘k12007;171‘;1)
//‘12000;114‘ ($MyArea;‘k12007;173‘;1)
//‘12000;114‘ ($MyArea;‘k12007;175‘;1)
//‘12000;114‘ ($MyArea;‘k12007;178‘;1)  //restrict font and size change
//‘12000;114‘ ($MyArea;‘k12007;179‘;1)
//‘12000;114‘ ($MyArea;‘k12007;177‘;1)
//‘12000;114‘ ($MyArea;‘k12007;53‘;1)
//‘12000;114‘ ($MyArea;‘k12007;11‘;1)
//‘12000;114‘ ($MyArea;‘k12007;12‘;1)
//‘12000;114‘ ($MyArea;‘k12007;13‘;1)
//‘12000;114‘ ($MyArea;‘k12007;14‘;1)
//‘12000;114‘ ($MyArea;‘k12007;15‘;1)

//‘12000;109‘ ($MyArea;‘k12003;12‘;0)  // dont' show std palette.
//‘12000;109‘ ($MyArea;‘k12003;13‘;0)
//‘12000;109‘ ($MyArea;‘k12003;14‘;1)
//‘12000;109‘ ($MyArea;‘k12003;15‘;0)
//‘12000;109‘ ($MyArea;‘k12003;10‘;0)
//‘12000;109‘ ($MyArea;‘k12003;11‘;0)
//‘12000;109‘ ($MyArea;‘k12003;3‘;0)
//‘12000;109‘ ($MyArea;‘k12003;48‘;0)
//‘12000;109‘ ($MyArea;‘k12003;49‘;0)
//‘12000;137‘ ($MyArea;‘k12004;1‘;0;"")  //no confirm dialog
//‘12000;149‘ ($MyArea;1;"Normal";0;"")
//‘12000;154‘ ($MyArea;1;vInspFontName)
//‘12000;152‘ ($MyArea;1;‘k12000;9‘;vInspFontSize;1)
//‘12000;137‘ ($MyArea;‘k12004;4‘;0;"")  // not modified


//DisplayDocProps ($MyArea)