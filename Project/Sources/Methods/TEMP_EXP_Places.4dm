//%attributes = {"invisible":true}
//  `GP TEMP_EXP_Places
//  `Copyright © 1998, Thomas D. Nee, All Rights Reserved.
//
//  `This procedure exports place codes and town names to a
//  `comma-delimited text file.  Append a Line Feed after the
//  `Carriage Return for DOS/WINTEL.
//
//C_TEXT($text;$file)
//C_INTEGER($i)
//C_TIME($dOutputFile)
//$file:="Tom's 8500 HD:Desktop Folder:Places.asc"
//$dOutputFile:=Create document($file)
//$text:=◊sQU+"bridge"+◊sQU+","+◊sQU+"placecode"+◊sQU+◊sCR+◊sLF
//SEND PACKET($dOutputFile;$text)
//ALL RECORDS([Town Data])
//ORDER BY([Town Data];[Town Data]Town Name)
//For ($i;1;Records in selection([Town Data]))
//$text:=◊sQU+[Town Data]Place_Code+◊sQU+","+◊sQU+[Town Data]Town Name+◊sQU+","+◊sQU+[Town Data]Town Name+◊sQU+◊sCR+◊sLF
//SEND PACKET($dOutputFile;$text)
//NEXT RECORD([Town Data])
//End for 
//CLOSE DOCUMENT($dOutputFile)