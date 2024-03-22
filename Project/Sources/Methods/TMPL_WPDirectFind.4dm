//%attributes = {"invisible":true}
//Method: TMPL_WPDirectFind
//Description
// look for a string or an expression in a list of records in [Templates]
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/12/21, 16:54:05
	// ----------------------------------------------------
	//Created : 
	Mods_2021_03
	// Modified by: Costas Manousakis-(Designer)-(2022-04-29 14:49:41)
	Mods_2022_04
	//  `added searching for WP templatees in addition to WRP
End if 
//
C_TEXT:C284($FoundSet; $OriginalTmpl; $SearchString_txt)
$FoundSet:="FOUNDBLOBSTRINGS"
$OriginalTmpl:="ORIGINALTEMPLATES"
CREATE EMPTY SET:C140([Templates:86]; $FoundSet)
$SearchString_txt:=Request:C163("Enter String to search for")
C_LONGINT:C283($RECS_L; $I)
CONFIRM:C162("Is this a string or a variable?"; "String"; "Variable")
C_BOOLEAN:C305($StringVar_b; $ReadWrite_b)
$StringVar_b:=(OK=1)
If (Read only state:C362([Templates:86]))
	$ReadWrite_b:=False:C215
Else 
	$ReadWrite_b:=True:C214
End if 
If ($ReadWrite_b)
	READ ONLY:C145([Templates:86])
End if 
C_LONGINT:C283($NumRefs; $RefCount; $Table; $Field; $Type; $DateF; $TimeF)
C_TEXT:C284($RefName; $NumF)
COPY NAMED SELECTION:C331([Templates:86]; $OriginalTmpl)
QUERY SELECTION:C341([Templates:86]; [Templates:86]TemplateName:2="WRP@"; *)
QUERY SELECTION:C341([Templates:86];  | ; [Templates:86]TemplateName:2="WP@")
//start the bar
C_OBJECT:C1216($progress_o)
$progress_o:=ProgressNew("Searching Templates"; Records in selection:C76([Templates:86]); True:C214; " WP template"; 3)
FIRST RECORD:C50([Templates:86])
C_OBJECT:C1216($WpDoc; $part_o)
C_TEXT:C284($part_txt)
While (Not:C34(End selection:C36([Templates:86])))
	//update progress
	UpdateProgressNew($progress_o; Selected record number:C246([Templates:86]))
	$WpDoc:=WP New:C1317([Templates:86]Template_:3)
	If ($StringVar_b)
		
		//search in body
		$part_o:=WP Get body:C1516($WpDoc)
		$part_txt:=WP Get text:C1575($part_o; wk expressions as value:K81:255)
		If (Position:C15($SearchString_txt; $part_txt)>0)
			ADD TO SET:C119([Templates:86]; $FoundSet)
		Else 
			$part_o:=WP Get header:C1503($WpDoc; 1)
			
			If ($part_o=Null:C1517)
				$part_txt:=""
			Else 
				$part_txt:=WP Get text:C1575($part_o; wk expressions as value:K81:255)
			End if 
			
			If (Position:C15($SearchString_txt; $part_txt)>0)
				ADD TO SET:C119([Templates:86]; $FoundSet)
				
			Else 
				$part_o:=WP Get header:C1503($WpDoc; 1; wk first page:K81:203)
				
				If ($part_o=Null:C1517)
					$part_txt:=""
				Else 
					$part_txt:=WP Get text:C1575($part_o; wk expressions as value:K81:255)
				End if 
				
				If (Position:C15($SearchString_txt; $part_txt)>0)
					ADD TO SET:C119([Templates:86]; $FoundSet)
				Else 
					$part_o:=WP Get header:C1503($WpDoc; 1; wk left page:K81:204)
					
					If ($part_o=Null:C1517)
						$part_txt:=""
					Else 
						$part_txt:=WP Get text:C1575($part_o; wk expressions as value:K81:255)
					End if 
					
					If (Position:C15($SearchString_txt; $part_txt)>0)
						ADD TO SET:C119([Templates:86]; $FoundSet)
					Else 
						$part_o:=WP Get header:C1503($WpDoc; 1; wk right page:K81:205)
						
						If ($part_o=Null:C1517)
							$part_txt:=""
						Else 
							$part_txt:=WP Get text:C1575($part_o; wk expressions as value:K81:255)
						End if 
						
						If (Position:C15($SearchString_txt; $part_txt)>0)
							ADD TO SET:C119([Templates:86]; $FoundSet)
						Else 
							$part_o:=WP Get footer:C1504($WpDoc; 1)
							
							If ($part_o=Null:C1517)
								$part_txt:=""
							Else 
								$part_txt:=WP Get text:C1575($part_o; wk expressions as value:K81:255)
							End if 
							
							If (Position:C15($SearchString_txt; $part_txt)>0)
								ADD TO SET:C119([Templates:86]; $FoundSet)
							Else 
								$part_o:=WP Get footer:C1504($WpDoc; 1; wk first page:K81:203)
								
								If ($part_o=Null:C1517)
									$part_txt:=""
								Else 
									$part_txt:=WP Get text:C1575($part_o; wk expressions as value:K81:255)
								End if 
								
								If (Position:C15($SearchString_txt; $part_txt)>0)
									ADD TO SET:C119([Templates:86]; $FoundSet)
								Else 
									$part_o:=WP Get footer:C1504($WpDoc; 1; wk left page:K81:204)
									
									If ($part_o=Null:C1517)
										$part_txt:=""
									Else 
										$part_txt:=WP Get text:C1575($part_o; wk expressions as value:K81:255)
									End if 
									
									If (Position:C15($SearchString_txt; $part_txt)>0)
										ADD TO SET:C119([Templates:86]; $FoundSet)
									Else 
										$part_o:=WP Get footer:C1504($WpDoc; 1; wk right page:K81:205)
										
										If ($part_o=Null:C1517)
											$part_txt:=""
										Else 
											$part_txt:=WP Get text:C1575($part_o; wk expressions as value:K81:255)
										End if 
										
										If (Position:C15($SearchString_txt; $part_txt)>0)
											ADD TO SET:C119([Templates:86]; $FoundSet)
										End if 
										
									End if 
									
								End if 
								
							End if 
							
						End if 
						
					End if 
					
				End if 
				
			End if 
			
		End if 
		If (False:C215)
			
			Case of 
				: (Position:C15($SearchString_txt; WP Get text:C1575(WP Get body:C1516($WpDoc); wk expressions as value:K81:255))>0)  //search in body
					ADD TO SET:C119([Templates:86]; $FoundSet)
				: (Position:C15($SearchString_txt; WP Get text:C1575(WP Get header:C1503($WpDoc; 1); wk expressions as value:K81:255))>0)  //search in headers
					ADD TO SET:C119([Templates:86]; $FoundSet)
				: (Position:C15($SearchString_txt; WP Get text:C1575(WP Get header:C1503($WpDoc; 1; wk first page:K81:203); wk expressions as value:K81:255))>0)
					ADD TO SET:C119([Templates:86]; $FoundSet)
				: (Position:C15($SearchString_txt; WP Get text:C1575(WP Get header:C1503($WpDoc; 1; wk left page:K81:204); wk expressions as value:K81:255))>0)
					ADD TO SET:C119([Templates:86]; $FoundSet)
				: (Position:C15($SearchString_txt; WP Get text:C1575(WP Get header:C1503($WpDoc; 1; wk right page:K81:205); wk expressions as value:K81:255))>0)
					ADD TO SET:C119([Templates:86]; $FoundSet)
				: (Position:C15($SearchString_txt; WP Get text:C1575(WP Get footer:C1504($WpDoc; 1); wk expressions as value:K81:255))>0)  //search in footers
					ADD TO SET:C119([Templates:86]; $FoundSet)
				: (Position:C15($SearchString_txt; WP Get text:C1575(WP Get footer:C1504($WpDoc; 1; wk first page:K81:203); wk expressions as value:K81:255))>0)
					ADD TO SET:C119([Templates:86]; $FoundSet)
				: (Position:C15($SearchString_txt; WP Get text:C1575(WP Get footer:C1504($WpDoc; 1; wk left page:K81:204); wk expressions as value:K81:255))>0)
					ADD TO SET:C119([Templates:86]; $FoundSet)
				: (Position:C15($SearchString_txt; WP Get text:C1575(WP Get footer:C1504($WpDoc; 1; wk right page:K81:205); wk expressions as value:K81:255))>0)
					ADD TO SET:C119([Templates:86]; $FoundSet)
					
			End case 
			
			
		End if 
		
	Else 
		
		//search in body
		$part_o:=WP Get body:C1516($WpDoc)
		$part_txt:=WP Get text:C1575($part_o; wk expressions as source:K81:256)
		If (Position:C15($SearchString_txt; $part_txt)>0)
			ADD TO SET:C119([Templates:86]; $FoundSet)
		Else 
			$part_o:=WP Get header:C1503($WpDoc; 1)
			
			If ($part_o=Null:C1517)
				$part_txt:=""
			Else 
				$part_txt:=WP Get text:C1575($part_o; wk expressions as source:K81:256)
			End if 
			
			If (Position:C15($SearchString_txt; $part_txt)>0)
				ADD TO SET:C119([Templates:86]; $FoundSet)
				
			Else 
				$part_o:=WP Get header:C1503($WpDoc; 1; wk first page:K81:203)
				If ($part_o=Null:C1517)
					$part_txt:=""
				Else 
					$part_txt:=WP Get text:C1575($part_o; wk expressions as source:K81:256)
				End if 
				
				If (Position:C15($SearchString_txt; $part_txt)>0)
					ADD TO SET:C119([Templates:86]; $FoundSet)
				Else 
					$part_o:=WP Get header:C1503($WpDoc; 1; wk left page:K81:204)
					If ($part_o=Null:C1517)
						$part_txt:=""
					Else 
						$part_txt:=WP Get text:C1575($part_o; wk expressions as source:K81:256)
					End if 
					
					If (Position:C15($SearchString_txt; $part_txt)>0)
						ADD TO SET:C119([Templates:86]; $FoundSet)
					Else 
						$part_o:=WP Get header:C1503($WpDoc; 1; wk right page:K81:205)
						If ($part_o=Null:C1517)
							$part_txt:=""
						Else 
							$part_txt:=WP Get text:C1575($part_o; wk expressions as source:K81:256)
						End if 
						
						If (Position:C15($SearchString_txt; $part_txt)>0)
							ADD TO SET:C119([Templates:86]; $FoundSet)
						Else 
							$part_o:=WP Get footer:C1504($WpDoc; 1)
							If ($part_o=Null:C1517)
								$part_txt:=""
							Else 
								$part_txt:=WP Get text:C1575($part_o; wk expressions as source:K81:256)
							End if 
							
							If (Position:C15($SearchString_txt; $part_txt)>0)
								ADD TO SET:C119([Templates:86]; $FoundSet)
							Else 
								$part_o:=WP Get footer:C1504($WpDoc; 1; wk first page:K81:203)
								If ($part_o=Null:C1517)
									$part_txt:=""
								Else 
									$part_txt:=WP Get text:C1575($part_o; wk expressions as source:K81:256)
								End if 
								
								If (Position:C15($SearchString_txt; $part_txt)>0)
									ADD TO SET:C119([Templates:86]; $FoundSet)
								Else 
									$part_o:=WP Get footer:C1504($WpDoc; 1; wk left page:K81:204)
									If ($part_o=Null:C1517)
										$part_txt:=""
									Else 
										$part_txt:=WP Get text:C1575($part_o; wk expressions as source:K81:256)
									End if 
									
									If (Position:C15($SearchString_txt; $part_txt)>0)
										ADD TO SET:C119([Templates:86]; $FoundSet)
									Else 
										$part_o:=WP Get footer:C1504($WpDoc; 1; wk right page:K81:205)
										If ($part_o=Null:C1517)
											$part_txt:=""
										Else 
											$part_txt:=WP Get text:C1575($part_o; wk expressions as source:K81:256)
										End if 
										
										If (Position:C15($SearchString_txt; $part_txt)>0)
											ADD TO SET:C119([Templates:86]; $FoundSet)
										End if 
										
									End if 
									
								End if 
								
							End if 
							
						End if 
						
					End if 
					
				End if 
				
			End if 
			
		End if 
		
		If (False:C215)
			Case of 
				: (Position:C15($SearchString_txt; WP Get text:C1575(WP Get body:C1516($WpDoc); wk expressions as source:K81:256))>0)  //search in body
					ADD TO SET:C119([Templates:86]; $FoundSet)
				: (Position:C15($SearchString_txt; WP Get text:C1575(WP Get header:C1503($WpDoc; 1); wk expressions as source:K81:256))>0)  //search in headers
					ADD TO SET:C119([Templates:86]; $FoundSet)
				: (Position:C15($SearchString_txt; WP Get text:C1575(WP Get header:C1503($WpDoc; 1; wk first page:K81:203); wk expressions as source:K81:256))>0)
					ADD TO SET:C119([Templates:86]; $FoundSet)
				: (Position:C15($SearchString_txt; WP Get text:C1575(WP Get header:C1503($WpDoc; 1; wk left page:K81:204); wk expressions as source:K81:256))>0)
					ADD TO SET:C119([Templates:86]; $FoundSet)
				: (Position:C15($SearchString_txt; WP Get text:C1575(WP Get header:C1503($WpDoc; 1; wk right page:K81:205); wk expressions as source:K81:256))>0)
					ADD TO SET:C119([Templates:86]; $FoundSet)
				: (Position:C15($SearchString_txt; WP Get text:C1575(WP Get footer:C1504($WpDoc; 1); wk expressions as source:K81:256))>0)  //search in footers
					ADD TO SET:C119([Templates:86]; $FoundSet)
				: (Position:C15($SearchString_txt; WP Get text:C1575(WP Get footer:C1504($WpDoc; 1; wk first page:K81:203); wk expressions as source:K81:256))>0)
					ADD TO SET:C119([Templates:86]; $FoundSet)
				: (Position:C15($SearchString_txt; WP Get text:C1575(WP Get footer:C1504($WpDoc; 1; wk left page:K81:204); wk expressions as source:K81:256))>0)
					ADD TO SET:C119([Templates:86]; $FoundSet)
				: (Position:C15($SearchString_txt; WP Get text:C1575(WP Get footer:C1504($WpDoc; 1; wk right page:K81:205); wk expressions as source:K81:256))>0)
					ADD TO SET:C119([Templates:86]; $FoundSet)
					
			End case 
			
		End if 
		
		
	End if 
	
	//check if progress stopped
	If (Progress Stopped(OB Get:C1224($progress_o; "progress"; Is longint:K8:6)))
		//abort loop
		ON ERR CALL:C155("Error Handler")  //in case of bad record
		LAST RECORD:C200([Templates:86])
		NEXT RECORD:C51([Templates:86])
		ON ERR CALL:C155("")
	Else 
		ON ERR CALL:C155("Error Handler")  //in case of bad record
		NEXT RECORD:C51([Templates:86])
		ON ERR CALL:C155("")
	End if 
	
	
End while 

//quit progress
Progress QUIT(OB Get:C1224($progress_o; "progress"; Is longint:K8:6))

If (Records in set:C195($FoundSet)>0)
	USE SET:C118($FoundSet)
Else 
	ALERT:C41("No Records found!")
	USE NAMED SELECTION:C332($OriginalTmpl)
End if 
If ($ReadWrite_b)
	READ WRITE:C146([Templates:86])
End if 
CLEAR NAMED SELECTION:C333($OriginalTmpl)
CLEAR SET:C117($FoundSet)

//End TMPL_WPDirectFind