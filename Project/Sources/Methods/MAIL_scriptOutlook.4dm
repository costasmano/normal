//%attributes = {"invisible":true}
//Method: MAIL_scriptOutlook
//Description
//  ` Create an applescript that creates an ms outlook message
// $1 : $ToArray_ptr 
// $2 : $CCArray_ptr
// $3 : $Subject_txt
// $4 : $Body_txt
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/18/15, 15:16:14
	// ----------------------------------------------------
	//Created : 
	Mods_2015_11
	
	C_TEXT:C284(MAIL_scriptOutlook; $0)
	
	C_POINTER:C301(MAIL_scriptOutlook; $1)
	C_POINTER:C301(MAIL_scriptOutlook; $2)
	C_TEXT:C284(MAIL_scriptOutlook; $3)
	C_TEXT:C284(MAIL_scriptOutlook; $4)
	C_POINTER:C301(MAIL_scriptOutlook; $5)
	// Modified by: Costas Manousakis-(Designer)-(11/7/16 17:07:17)
	Mods_2016_11
	//  `made this  so it is for both platforms. added name in mac outlook email address
	// Modified by: Costas Manousakis-(Designer)-(11/9/16 16:13:40)
	Mods_2016_11
	//  `use MAIL_ParseAddress
	
	// Modified by: Costas Manousakis (1/25/17)
	Mods_2017_01
	//  //Added attempt to bring the Outlook window to the front
	// Modified by: Costas Manousakis-(Designer)-(2024-01-10 11:43:45)
	Mods_2024_01
	//  `user PROCESS 4D tags to convert body to HTML
End if 
//

C_POINTER:C301($1)
C_POINTER:C301($2)
C_TEXT:C284($3)
C_TEXT:C284($4)

ARRAY TEXT:C222($attachments; 0)

C_TEXT:C284($scipt_txt; $Subj_txt; $body_txt; $temp_txt; tMailNote)
C_LONGINT:C283($loop_L)

$0:=""

//clean out body - make html 
//start of mods_2024_01
$temp_txt:=tMailNote  //save this in case used elsewhere - need process var for PROCESS 4D tags
tMailNote:=$4
PROCESS 4D TAGS:C816("$4DTEXT(tMailNote)"; $body_txt)
$body_txt:=Replace string:C233($body_txt; (Char:C90(13)+Char:C90(10)); "<br>")
$body_txt:=Replace string:C233($body_txt; Char:C90(13); "<br>")
$body_txt:=Replace string:C233($body_txt; Char:C90(10); "<br>")
tMailNote:=$temp_txt
//end of mods_2024_01

Case of 
	: (<>WindowsPL_b)
		C_TEXT:C284(tToBuilt_txt; tCCBuilt_txt)
		C_TEXT:C284($scriptsource_txt; $script_path_t; $cscript_t; $vbs_out_t; $retVal_txt; $Body_txt)
		$scriptsource_txt:=$scriptsource_txt+" Set objOutlook = CreateObject(\"Outlook.Application\")"+Char:C90(13)
		$scriptsource_txt:=$scriptsource_txt+" Set objMail = objOutlook.CreateItem(0)"+Char:C90(13)
		tToBuilt_txt:=""
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274($1->))
			
			If ($loop_L=1)
				tToBuilt_txt:=$1->{$loop_L}
			Else 
				tToBuilt_txt:=tToBuilt_txt+" ; "+$1->{$loop_L}
			End if 
		End for 
		
		tCCBuilt_txt:=""
		For ($loop_L; 1; Size of array:C274($2->))
			
			If ($loop_L=1)
				tCCBuilt_txt:=$2->{$loop_L}
			Else 
				tCCBuilt_txt:=tCCBuilt_txt+" ; "+$2->{$loop_L}
			End if 
		End for 
		
		$scriptsource_txt:=$scriptsource_txt+" objMail.To =\""+tToBuilt_txt+"\""+Char:C90(13)
		$scriptsource_txt:=$scriptsource_txt+" objMail.cc =\""+tCCBuilt_txt+"\""+Char:C90(13)
		
		$scriptsource_txt:=$scriptsource_txt+" objMail.Subject =\""+$3+"\""+Char:C90(13)
		$scriptsource_txt:=$scriptsource_txt+" objMail.HTMLbody =\""+$Body_txt+"\""+Char:C90(13)
		
		If (Count parameters:C259>4)
			C_POINTER:C301($5)
			If (Size of array:C274($5->)>0)
				
				For ($loop_L; 1; Size of array:C274($5->))
					$scriptsource_txt:=$scriptsource_txt+"objMail.Attachments.Add(\""+$5->{$loop_L}+"\")"+Char:C90(13)
				End for 
				
			End if 
			
		End if 
		
		$scriptsource_txt:=$scriptsource_txt+" objMail.Display"+Char:C90(13)
		$scriptsource_txt:=$scriptsource_txt+" if Not (objOutlook.ActiveWindow is Nothing) Then"+Char:C90(13)+"objOutlook.ActiveWindow.Activate "+Char:C90(13)+"End if"+Char:C90(13)
		$scriptsource_txt:=$scriptsource_txt+" Set objMail=Nothing"+Char:C90(13)+" Set objOutlook=Nothing"+Char:C90(13)
		$script_path_t:=Temporary folder:C486+"$"+String:C10(Milliseconds:C459)+".vbs"
		C_BLOB:C604($stdin_x; $stdout_x; $stderr_x; $script_x)
		CONVERT FROM TEXT:C1011($scriptsource_txt; "UTF-16LE"; $script_x)
		BLOB TO DOCUMENT:C526($script_path_t; $script_x)
		
		SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE"; "true")
		
		$cscript_t:="cscript //Nologo //U \""+$script_path_t+"\""
		LAUNCH EXTERNAL PROCESS:C811($cscript_t; $stdin_x; $stdout_x; $stderr_x)
		$vbs_out_t:=Convert to text:C1012($stdout_x; "UTF-16LE")
		
		If (BLOB size:C605($stderr_x)#0) & (BLOB size:C605($stdout_x)=0)
			$res_txt:=Convert to text:C1012($stderr_x; "UTF-16LE")
			$0:=$res_txt
			
		Else 
			$res_txt:=Substring:C12($vbs_out_t; 1; Length:C16($vbs_out_t)-1)
		End if 
		
		If (User in group:C338(Current user:C182; "Design Access Group"))
			SHOW ON DISK:C922($script_path_t)
		End if 
		
	Else 
		//MAC Platform
		//generate the script content
		C_TEXT:C284($name_txt; $emailAddr_txt)
		$scipt_txt:=""
		C_LONGINT:C283($match_b)
		ARRAY LONGINT:C221($start_aL; 0)
		ARRAY LONGINT:C221($Len_aL; 0)
		For ($loop_L; 1; Size of array:C274($1->))
			MAIL_ParseAddress($1->{$loop_L}; ->$emailAddr_txt; ->$name_txt)
			$scipt_txt:=$scipt_txt+"set {ToNameAddr"+String:C10($loop_L)+"} to { "+<>sQu+$emailAddr_txt+<>sQu+"}"+Char:C90(13)
			$scipt_txt:=$scipt_txt+"set {ToName"+String:C10($loop_L)+"} to { "+<>sQu+$name_txt+<>sQu+"}"+Char:C90(13)
		End for 
		For ($loop_L; 1; Size of array:C274($2->))
			
			MAIL_ParseAddress($2->{$loop_L}; ->$emailAddr_txt; ->$name_txt)
			
			$scipt_txt:=$scipt_txt+"set {CCNameAddr"+String:C10($loop_L)+"} to { "+<>sQu+$emailAddr_txt+<>sQu+"}"+Char:C90(13)
			$scipt_txt:=$scipt_txt+"set {CCName"+String:C10($loop_L)+"} to { "+<>sQu+$name_txt+<>sQu+"}"+Char:C90(13)
		End for 
		
		//clean out subj
		$Subj_txt:=Replace string:C233($3; Char:C90(13); " ")
		$Subj_txt:=Replace string:C233($Subj_txt; Char:C90(10); " ")
		$scipt_txt:=$scipt_txt+"set The_Subject to "+<>sQu+$Subj_txt+<>sQU+Char:C90(13)
		
		$scipt_txt:=$scipt_txt+"set The_Content to ("+<>sQu+$body_txt+<>sQU+")"+Char:C90(13)
		
		If (Count parameters:C259>4)
			C_POINTER:C301($5)
			If (Size of array:C274($5->)>0)
				
				For ($loop_L; 1; Size of array:C274($5->))
					$scipt_txt:=$scipt_txt+"set the_attach"+String:C10($loop_L)+" to posix path of file "+<>sQu+$5->{$loop_L}+<>sQu+Char:C90(13)
				End for 
				
			End if 
		End if 
		
		$scipt_txt:=$scipt_txt+"tell application "+<>sQU+"Microsoft Outlook"+<>sQU+Char:C90(13)
		$scipt_txt:=$scipt_txt+"set OurNewMsg to make new outgoing message with properties {subject:The_Subject, content:The_Content}"+Char:C90(13)
		
		For ($loop_L; 1; Size of array:C274($1->))
			$scipt_txt:=$scipt_txt+"make new to recipient at OurNewMsg with properties {email address:{address:ToNameAddr"+String:C10($loop_L)+", name:ToName"+String:C10($loop_L)+" }}"+Char:C90(13)
		End for 
		
		For ($loop_L; 1; Size of array:C274($2->))
			$scipt_txt:=$scipt_txt+"make new cc recipient at OurNewMsg with properties {email address:{address:CCNameAddr"+String:C10($loop_L)+", name:CCName"+String:C10($loop_L)+" }}"+Char:C90(13)
		End for 
		
		If (Count parameters:C259>4)
			C_POINTER:C301($5)
			If (Size of array:C274($5->)>0)
				
				For ($loop_L; 1; Size of array:C274($5->))
					$scipt_txt:=$scipt_txt+"make new attachment at OurNewMsg with properties {file:the_attach"+String:C10($loop_L)+"}"+Char:C90(13)
				End for 
				
			End if 
		End if 
		
		$scipt_txt:=$scipt_txt+"open OurNewMsg"+Char:C90(13)
		$scipt_txt:=$scipt_txt+"end tell"+Char:C90(13)
		
		//create a temp script file
		C_BLOB:C604($scipt_x)
		TEXT TO BLOB:C554($scipt_txt; $scipt_x; Mac text without length:K22:10)
		C_TEXT:C284($sciptFile_txt)
		C_TIME:C306($sciptFile_t)
		$sciptFile_txt:="Tempscript"+ISODateTime(Current date:C33(*); Current time:C178(*))+".applescript"
		$sciptFile_txt:=Replace string:C233($sciptFile_txt; ":"; "")
		$sciptFile_txt:=Replace string:C233($sciptFile_txt; "-"; "")
		$sciptFile_txt:=Temporary folder:C486+$sciptFile_txt
		$sciptFile_t:=Create document:C266($sciptFile_txt)
		CLOSE DOCUMENT:C267($sciptFile_t)
		BLOB TO DOCUMENT:C526($sciptFile_txt; $scipt_x)
		C_TEXT:C284($res_txt)
		If (User in group:C338(Current user:C182; "Design Access Group"))
			SHOW ON DISK:C922($sciptFile_txt)
		End if 
		$res_txt:=ut_runApplescript($sciptFile_txt)
		$0:=$res_txt
End case 

//End MAIL_scriptOutlook