#notrayicon
#singleinstance force
process priority,,r
settitlematchmode 2
text:=strsplit("I am a cute eevee :3 ")
pos:=1
currentwin:=0
pressing:=0

settimer watch,100

loop 91{
	ch:=chr(a_index+31)
	stringlower ch,ch
	hotkey %ch%,keys
	hotkey +%ch%,keys
}

return

:*?:task::
	if(a_priorhotkey=":*?:kill"){
		loop 4{
			send {backspace}
		}
		send killtask
	}else{
		send kill
	}
return

:*?:kill::
	send task
return
:*?::bat::tab
:*?::cmd::dmc

*enter::
	send {blind}{enter}
	keywait enter
return

*#e::
	if(winexist("ahk_class CabinetWClass")){
		winactivate ahk_class CabinetWClass
	}else{
		run C:\Windows\explorer.exe
	}
return

*#1::
*#2::
*#3::
*#4::
*#5::
*#6::
*#7::
*#8::
*#9::
*#0::
return

*mbutton::
	coordmode mouse,screen
	mousegetpos,,y
	if(a_screenheight-y>100){
		click down m
		keywait mbutton
		click up m
	}
return

watch(){
	global
	winkill ahk_exe osk.exe
	newwin:=winexist("a")
	if(currentwin!=newwin){
		pos:=1
		currentwin:=newwin
	}
}

keys(){
	global
	if(a_thishotkey="*^v"){
		clipboard:="I am a cute eevee :3 "
		send ^{v}
	}else{
		char:=text[pos]
		clipboard:=char
		send ^{v}
		pos:=mod(pos,text.length())+1
	}
	noplus:=regexreplace(a_thishotkey,"^[\*\+\^]+")
	keywait %noplus%
}

*^v::
*backspace::
*del::
	keys()
return