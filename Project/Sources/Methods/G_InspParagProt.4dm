//%attributes = {"invisible":true}
//G_InspParagProt
//Aug-2003 : Provide paragraph protection for element comments.
//   To attempt to keep element  or other comments in one page if possible.
//$mainarea:=$1  : 4d write are
//$numpages:=$2  : Num of pages before 
//$vlLine:=$3       : Line number where label was placed
//$vlStartSel:=$4: Position of start
//$i:=$5               : Number of carriage returns to be removed.
//$vElmTitle:=$6  : Title used to append the 'Cont'd'
If (False:C215)
	Mods_2005_CM03
	Mods_2005_CM05
	// Modified by: costasmanousakis-(Designer)-(12/2/11 16:11:11)
	Mods_2011_12
	//  `Make sure the continution header is in black and white by re-setting the default style sheet.
	// Modified by: Costas Manousakis-(Designer)-(2/25/12 15:33:19)
	Mods_2012_02
	//  `Fix code so that the second paragraph cut in half does not loose all formatting when the Apply stylesheet is done
	//  `Also so that the remaining text does not get new bullet or a first line indent.
	// Modified by: Costas Manousakis-(Designer)-(4/3/14 14:30:09)
	Mods_2014_04_bug
	//  `When adding line feeds to move the item to next page ($vbMovetoTop=true)  applystylesheet 1 after each char return
	// Modified by: Costas Manousakis-(Designer)-(2/29/16 12:15:01)
	Mods_2016_02_bug
	//  `removed TRACE at start
	// Modified by: Costas Manousakis-(Designer)-(11/2/17 12:43:11)
	Mods_2017_11_bug
	//  `use wr cmd insert page break instead of CR when splitting element comments
	// Modified by: Costas Manousakis-(Designer)-(12/26/17 17:47:48)
	Mods_2017_12
	//  `when moving to end of doc, use twice the char count to avoid miscounting by 4DWR
	// Modified by: Costas Manousakis-(Designer)-(11/14/18 15:00:36)
	Mods_2018_11
	//  `to avoid incorrect counting of page location, call G_Insp_ApplyLineSpacing after every insert of text.
	//  //use brute force method of going char by char from top of page to get to the start of the next page
	//  //also no need to add page breaks when spliting a commnent block in multiple pages. just add lines with the appropriate headers
	// Modified by: Costas Manousakis-(Designer)-(10/22/19 16:23:20)
	Mods_2019_10_bug
	//  `better handling of paragraph settings when splitting text to handle bullets correctly CallReference #655
	// Modified by: Costas Manousakis-(Designer)-(10/29/19 16:23:20)
	Mods_2019_10_bug
	//  `fix logic determining where to insert the (Cont'd) label when text spans multiple pages. 
	// Modified by: Costas Manousakis-(Designer)-(11/1/19 17:06:22)
	Mods_2019_11_bug
	//  `adjustments in the line spacing CallReference #668
	// Modified by: Costas Manousakis-(Designer)-(11/26/19 17:06:22)
	Mods_2019_11_bug
	//  `take only last line of element label - CallReference #677
	// Modified by: manousakisc (1/23/2020)
	Mods_2020_01_bug
	// //Work for CallReference #692
	// `Added testing code to save the 4DWrite area at various steps for debugging purposes. for CallReference #692
	// `while adding CRs to split the inserted comments, don't apply stylesheet 1 because it causes 
	// `the formatting in the split paragraph to be lost.  for CallReference #692
	
End if 
//TRACE

//C_LONGINT($1;$mainarea;$2;$numpages;$3;$vlLine;$4;$vlStartSel;$5;$i)
//C_TEXT($vElmTitle;$6)  // **Replaced old C_STRING length 132
//$mainarea:=$1
//$numpages:=$2  //$numpages : page count at start
//$vlLine:=$3  //$vlLine : first line where the label was inserted.
//$vlStartSel:=$4  //$vlStartSel := gets where we are at start - at the end of the text inserted before.
//$i:=$5  //number of CRs to be deleted later if the text goes into another page
//$vElmTitle:=$6

//ARRAY TEXT($titleLines_atxt;0)
//ut_TextToArray ($vElmTitle;->$titleLines_atxt;Char(13))
//$vElmTitle:=$titleLines_atxt{Size of array($titleLines_atxt)}  //use only the last line

//C_LONGINT($vlPageSpan;$vlPageno;$vlEndLine;$vlLastLine;$vlLastPage;$newst;$newend;\
$vlCol;$vlPos;$numnewpages;$lineSt;$lineEnd;$MyNumber_L)

//C_BOOLEAN($vbMovetoTop)
//$vbMovetoTop:=False
//  //check where we are now.
//WR GET CURSOR POSITION ($mainarea;$vlLastPage;$vlCol;$vlLastLine;$vlPos)  // this is at the end of the text inserted

//  //if the pages increase,
//WR SET CURSOR POSITION ($mainarea;($numpages+1);1;1;1)  // go to next page  1st line 1st col
//WR GET SELECTION ($mainarea;$newst;$newend)
//WR SET SELECTION ($mainarea;($newst-1);($newst-1))  //move back one char - bottom of first page where text started
//WR GET CURSOR POSITION ($mainarea;$vlPageno;$vlCol;$vlEndLine;$vlPos)
//  //will move to next page if 
//  //  there are between 6 and 10 line on the 1st page and
//  //there is only one line on the next and last page.
//$vbMovetoTop:=((($vlEndLine-$vlLine)>5) & (($vlEndLine-$vlLine)<11))
//$vbMovetoTop:=($vbMovetoTop & ($vlLastPage=($numpages+1)) & ($vlLastLine=1))
//  // or less than 6 lines on prev page.
//$vbMovetoTop:=($vbMovetoTop | (($vlEndLine-$vlLine)<6))

//C_BOOLEAN(Testinghere_b)
//If (False)
//  //execute this first time to set the Document path - it is used later to save the rest of the files
//WR SAVE DOCUMENT ($mainarea;"";wr 4D Write document)  //starter
//End if 
//  //Testinghere_b:=True
//If (Testinghere_b)
//C_LONGINT($bcount_L)
//$bcount_L:=1
//WR SAVE DOCUMENT ($mainarea;GetPath (Document)+CleanFileName ($vElmTitle)+String($bcount_L;" 000")+"-"+"preParagraphProt";wr 4D Write document)  //preParagraphProt
//End if 

//If ($vbMovetoTop)  // will try to keep the element comments in one page.
//WR SET SELECTION ($mainarea;$vlStartSel;($vlStartSel+$i))  //move to the start of the insert
//  //delete the 1st linefeed only - should leave one
//WR DELETE SELECTION ($mainarea)  //if there is no select ($i=0) nothing will be deleted
//WR GET CURSOR POSITION ($mainarea;$numnewpages;$vlCol;$vlLine;$vlPos)
//While ($numnewpages=$numpages)
//WR INSERT TEXT ($mainarea;<>sCR)
//G_ApplySheet ($mainarea;1)
//G_Insp_ApplyLineSpacing ($mainarea)
//WR GET CURSOR POSITION ($mainarea;$numnewpages;$vlCol;$vlLine;$vlPos)
//End while 
//  // new starting page for the current text 
//$numpages:=$numnewpages
//WR BACKSPACE ($mainarea)  //we have all linefeeds we need

//End if 

//If (Testinghere_b)
//$bcount_L:=$bcount_L+1
//WR SAVE DOCUMENT ($mainarea;GetPath (Document)+CleanFileName ($vElmTitle)+String($bcount_L;" 000")+"-"+"aftermovetoTop";wr 4D Write document)  //aftermovetoTop
//End if 

//$numnewpages:=WR Count ($mainarea;wr nb pages)  //get count again, in case we moved the comments
//  //get number of pages where the text block is
//$vlPageSpan:=$numnewpages-$numpages
//C_REAL($CurLeftMar_r;$CurFirstLMar_r;$curBullet_R)

//  //need to add headers with the word Cont'd in extra pages
//$i:=1
//While ($i<=$vlPageSpan)

//WR SET CURSOR POSITION ($mainarea;($numpages+$i);1;1;1)  //go to top of nxt page
//WR GET SELECTION ($mainarea;$newst;$newend)
//WR SET SELECTION ($mainarea;($newst-1);($newst-1))  //move back one char.

//  //copy the current ruler 
//WR EXECUTE COMMAND ($mainarea;wr cmd copy ruler)
//  //determine whether we should clear any bullets that might be created when a carrRet is added.
//  //if we are in the midlle of a paragraph - then should clear bullet and re-copy the ruler.
//  // if not (ie at end of a paragraph) then bullet should not be cleared
//C_LONGINT($ParaBegin;$ParaEnd;$currselStart;$currSelEnd;$currPage_L)
//WR GET PARAGRAPHS ($mainarea;$ParaBegin;$ParaEnd)
//WR GET SELECTION ($mainarea;$currselStart;$currSelEnd)
//C_BOOLEAN($AtMiddleOfPar)
//$AtMiddleOfPar:=True
//If ($currselStart=($ParaEnd-1))
//  //we are at the end of a paragraph. will not clear the bullet if any for the next paragraph
//$AtMiddleOfPar:=False
//End if 
//WR GET CURSOR POSITION ($mainarea;$vlPageno;$vlCol;$vlLine;$vlPos)

//If ($vlPageno<($numpages+$i))
//  //WR SET TEXT PROPERTY ($mainarea;wr bullet;0)
//WR INSERT TEXT ($mainarea;<>sCR)
//  //now we should be at a new page - if not, add another CR
//WR GET CURSOR POSITION ($mainarea;$currPage_L;$vlCol;$vlLine;$vlPos)

//While ($currPage_L=$vlPageno)
//WR INSERT TEXT ($mainarea;<>sCR)
//G_Insp_ApplyLineSpacing ($mainarea)
//WR GET CURSOR POSITION ($mainarea;$currPage_L;$vlCol;$vlLine;$vlPos)

//End while 

//End if 
//WR GET SELECTION ($mainarea;$newst;$newend)  //Get the begining of the line

//If (Testinghere_b)
//$bcount_L:=$bcount_L+1
//WR SAVE DOCUMENT ($mainarea;GetPath (Document)+CleanFileName ($vElmTitle)+String($bcount_L;" 000")+"-"+"afterPrepforTitle"+String($i;" 00");wr 4D Write document)  //afterPrepforTitle
//End if 

//WR INSERT TEXT ($mainarea;$vElmTitle)
//WR INSERT TEXT ($mainarea;" (Cont'd)")

//If (Testinghere_b)
//$bcount_L:=$bcount_L+1
//WR SAVE DOCUMENT ($mainarea;GetPath (Document)+CleanFileName ($vElmTitle)+String($bcount_L;" 000")+"-"+"beforeTitleLF"+String($i;" 00");wr 4D Write document)  //beforeTitleLF
//End if 

//WR GET SELECTION ($mainarea;$lineEnd;$lineEnd)  //Mark the end of the line
//WR INSERT TEXT ($mainarea;<>sCR)  //add a line feed so that the apply stylesheet does not affect the rest of the text

//If (Testinghere_b)
//$bcount_L:=$bcount_L+1
//WR SAVE DOCUMENT ($mainarea;GetPath (Document)+CleanFileName ($vElmTitle)+String($bcount_L;" 000")+"-"+"afterTitleLF"+String($i;" 00");wr 4D Write document)  //afterTitleLF
//End if 

//WR GET SELECTION ($mainarea;$lineSt;$lineSt)  //Mark the start of the line where the text is continued
//WR SET SELECTION ($mainarea;$newst;$lineEnd)  // This is just the new line(s) added
//G_ApplySheet ($mainarea;1)
//WR SET TEXT PROPERTY ($mainarea;wr bold;1)
//WR SET TEXT PROPERTY ($mainarea;wr underline;1)
//WR SET SELECTION ($mainarea;$lineSt;$lineSt)  //move to the new line

//If (Testinghere_b)
//$bcount_L:=$bcount_L+1
//WR SAVE DOCUMENT ($mainarea;GetPath (Document)+CleanFileName ($vElmTitle)+String($bcount_L;" 000")+"-"+"afterTitleFormat"+String($i;" 00");wr 4D Write document)  //afterTitleFormat
//End if 

//  //delete the first character in the line - if it is a space.
//WR SET SELECTION ($mainarea;$linest;($lineSt+1))
//If (WR Get selected text ($mainarea)=" ")
//WR DELETE SELECTION ($mainarea)
//End if 
//If ($AtMiddleOfPar)
//  //we are in the middle of a paragraph. need to restore the ruler and get rid of any bullet and first margin
//WR EXECUTE COMMAND ($mainarea;wr cmd paste ruler)
//WR SET TEXT PROPERTY ($mainarea;wr first indent;0)
//WR SET TEXT PROPERTY ($mainarea;wr bullet;0)
//End if 
//If (Testinghere_b)
//$bcount_L:=$bcount_L+1
//WR SAVE DOCUMENT ($mainarea;GetPath (Document)+CleanFileName ($vElmTitle)+String($bcount_L;" 000")+"-"+"afterRulerReset"+String($i;" 00");wr 4D Write document)  //afterRulerReset
//End if 

//WR GET CURSOR POSITION ($mainarea;$vlPageno;$vlCol;$vlLine;$vlPos)
//If ($vlLine=1)
//WR SET SELECTION ($mainarea;$newst;$newend)
//WR INSERT TEXT ($mainarea;<>sCR)
//End if 
//G_Insp_ApplyLineSpacing ($mainarea)

//If (Testinghere_b)
//$bcount_L:=$bcount_L+1
//WR SAVE DOCUMENT ($mainarea;GetPath (Document)+CleanFileName ($vElmTitle)+String($bcount_L;" 000")+"-"+"endofwhileLoop"+String($i;" 00");wr 4D Write document)
//End if 

//$numnewpages:=WR Count ($mainarea;wr nb pages)  //count again
//$vlPageSpan:=$numnewpages-$numpages

//$i:=$i+1
//End while 

//$MyNumber_L:=WR Count ($mainarea;wr nb characters)*2
//WR SET SELECTION ($mainarea;$MyNumber_L;$MyNumber_L)
//If (Testinghere_b)
//$bcount_L:=$bcount_L+1
//WR SAVE DOCUMENT ($mainarea;GetPath (Document)+CleanFileName ($vElmTitle)+String($bcount_L;" 000")+"-"+"endofParProt";wr 4D Write document)
//End if 
