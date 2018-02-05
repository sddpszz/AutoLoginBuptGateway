@echo off
goto start
 = Copyright (C) 2018 sddpszz.
 =
 =  Licensed under the Apache License, Version 2.0 (the "License");
 =  you may not use this file except in compliance with the License.
 =  You may obtain a copy of the License at
 =
 =      http://www.apache.org/licenses/LICENSE-2.0
 =
 =  Unless required by applicable law or agreed to in writing, software
 =  distributed under the License is distributed on an "AS IS" BASIS,
 =  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 =  See the License for the specific language governing permissions and
 =  limitations under the License.
:start
echo BuptNetGate [version 1.2.180203] sddpszz@163.com
echo Copyright (C) 2018 sddpszz.
echo=
setlocal enabledelayedexpansion
::通过ping网关判断是否接入校园网络环境
ping -n 1 10.3.8.211>log
if %ERRORLEVEL% == 0 (goto SET) else (echo 您当前尚未接入北邮校园网络环境 &&goto END)
:SET
::通过ping百度判断是否登陆网关
ping -n 1 www.baidu.com -w 100>>log
if %ERRORLEVEL% == 0 (echo 您已经登陆！ &&goto END) else (goto LOGIN)
:LOGIN
::从文件中读取用户名和密码，并存到环境变量中
::读取前两行，文件第一行为用户名，第二行为密码
if exist data (
     echo 加载本地账户，正在登陆...
	 set v=1
	 for /f %%i  in (data) do (
		 if !v!==1 (
			set user=%%i
			set v=2
			) else (
				if !v!==2 (
					set pass=%%i
					set v=3
					)
				)
			)
	) else (
     echo 不存在本地账户，请输入
	 :RELOGIN
	 set /p user=账户：
	 set /p pass=密码：
	 cls
	 ::将账户保存到本地
	 echo !user!>data
	 echo !pass!>>data
     )
echo 登陆账户：!user!
curl -s http://10.3.8.211 -X POST -m 10000 -H "Host: 10.3.8.211" -H "Content-Type: application/x-www-form-urlencoded" --data "DDDDD=!user!&upass=!pass!&0MKKey=">>log
ping -n 1 www.baidu.com -w 100>>log
if %ERRORLEVEL% == 0 (echo=&&echo 登陆成功) else (echo=&&echo 登陆失败&&echo 请检查账户密码或是否流量超支！&&echo= &&echo 请重新输入！&&goto RELOGIN)
:END
echo=
echo 【按任意键退出...】
pause>nul
exit