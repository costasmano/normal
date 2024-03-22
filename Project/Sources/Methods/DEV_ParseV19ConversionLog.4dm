//%attributes = {"invisible":true}
//Method: DEV_ParseV19ConversionLog
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Jul 13, 2022, 19:58:55
	Mods_2022_07
	// ----------------------------------------------------
	
End if 
C_TEXT:C284($file_t; $verifyLog_t; $message_t; $logParse_t; $msg_t; $count_t)
C_OBJECT:C1216($json_o; $warnings_o; $errors_o; $msg_o)
C_COLLECTION:C1488($messages_c)

$file_t:=Select document:C905(Get 4D folder:C485(Logs folder:K5:19); "*"; "List of Logs"; 2)

If (OK=1)
	$verifyLog_t:=Document to text:C1236(Document; UTF8 C string:K22:15)
	$json_o:=JSON Parse:C1218($verifyLog_t)
	$messages_c:=$json_o.messages
	$warnings_o:=New object:C1471
	$errors_o:=New object:C1471
	
	For each ($msg_o; $messages_c)
		$message_t:=$msg_o.message
		
		If ($msg_o.severity="warning")
			
			If (Value type:C1509($warnings_o[$message_t])=Is undefined:K8:13)
				$warnings_o[$message_t]:=1
			Else 
				$warnings_o[$message_t]:=$warnings_o[$message_t]+1
			End if 
			
		Else 
			If ($msg_o.severity="error")
				If (Value type:C1509($errors_o[$message_t])=Is undefined:K8:13)
					$errors_o[$message_t]:=1
					//C_COLLECTION($messages_c)
					//$messages_c:=New collection($msg_o)
					//OB SET($errors_o[$message_t];"messages";$messages_c)
				Else 
					$errors_o[$message_t]:=$errors_o[$message_t]+1
					//$errors_o[$message_t].messages.push($msg_o)
					
				End if 
				
			End if 
			
		End if 
		
	End for each 
	
End if 

$logParse_t:="Errors"
For each ($msg_t; $errors_o)
	$count_t:=String:C10($errors_o[$msg_t])
	$logParse_t:=$logParse_t+Char:C90(Carriage return:K15:38)+$msg_t+Char:C90(Tab:K15:37)+$count_t
End for each 

$logParse_t:=$logParse_t+Char:C90(Carriage return:K15:38)+Char:C90(Carriage return:K15:38)+"Warnings"
For each ($msg_t; $warnings_o)
	$count_t:=String:C10($warnings_o[$msg_t])
	$logParse_t:=$logParse_t+Char:C90(Carriage return:K15:38)+$msg_t+Char:C90(Tab:K15:37)+$count_t
End for each 

TEXT TO DOCUMENT:C1237("logParse.txt"; $logParse_t)
SHOW ON DISK:C922("logParse.txt")
//
//End DEV_ParseV19ConversionLog   