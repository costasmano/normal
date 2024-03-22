//%attributes = {"invisible":true}
If (False:C215)
	//fGetDataType
	//function to : Return a String indicating the data type
	//$1 : Integer code of the data type
	//$0 : String explaining the data type code
	// Modified by: Costas Manousakis-(Designer)-(9/8/14 13:01:38)
	Mods_2014_09
	//  `added Float; int 64 bits
	// Modified by: Costas Manousakis-(Designer)-(5/18/20 20:14:29)
	Mods_2020_05
	//  `updated with list from manual for Type
End if 

C_TEXT:C284($0)  // Command Replaced was o_C_STRING length was 80
C_LONGINT:C283($1)  //Command Replaced was o_C_INTEGER

Case of 
		
	: ($1=Array 2D:K8:24)
		$0:="Array 2D"
	: ($1=Blob array:K8:30)
		$0:="Blob array"
	: ($1=Boolean array:K8:21)
		$0:="Boolean array"
	: ($1=Date array:K8:20)
		$0:="Date array"
	: ($1=Integer array:K8:18)
		$0:="Integer array"
	: ($1=Is alpha field:K8:1)
		$0:="Is alpha field"
	: ($1=Is BLOB:K8:12)
		$0:="Is BLOB"
	: ($1=Is boolean:K8:9)
		$0:="Is Boolean"
	: ($1=Is date:K8:7)
		$0:="Is date"
		//: ($1=_o_Is float)
		//$0:="Is float"
	: ($1=Is integer:K8:5)
		$0:="Is integer"
	: ($1=Is integer 64 bits:K8:25)
		$0:="Is integer 64 bits"
	: ($1=Is null:K8:31)
		$0:="Is JSON null"
	: ($1=Is longint:K8:6)
		$0:="Is longint"
	: ($1=Is object:K8:27)
		$0:="Is object"
	: ($1=Is picture:K8:10)
		$0:="Is picture"
	: ($1=Is pointer:K8:14)
		$0:="Is pointer"
	: ($1=Is real:K8:4)
		$0:="Is real"
	: ($1=Is string var:K8:2)
		$0:="Is string var"
	: ($1=Is subtable:K8:11)
		$0:="Is subtable"
	: ($1=Is text:K8:3)
		$0:="Is text"
	: ($1=Is time:K8:8)
		$0:="Is time"
	: ($1=Is undefined:K8:13)
		$0:="Is undefined"
	: ($1=LongInt array:K8:19)
		$0:="LongInt array"
	: ($1=Object array:K8:28)
		$0:="Object array"
	: ($1=Picture array:K8:22)
		$0:="Picture array"
	: ($1=Pointer array:K8:23)
		$0:="Pointer array"
	: ($1=Real array:K8:17)
		$0:="Real array"
	: ($1=String array:K8:15)
		$0:="String array"
	: ($1=Text array:K8:16)
		$0:="Text array"
	: ($1=Time array:K8:29)
		$0:="Time array"
	Else 
		$0:="Unknown type"
End case 