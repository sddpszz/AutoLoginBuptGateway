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
::ͨ��ping�����ж��Ƿ����У԰���绷��
ping -n 1 10.3.8.211>log
if %ERRORLEVEL% == 0 (goto SET) else (echo ����ǰ��δ���뱱��У԰���绷�� &&goto END)
:SET
::ͨ��ping�ٶ��ж��Ƿ��½����
ping -n 1 www.baidu.com -w 100>>log
if %ERRORLEVEL% == 0 (echo ���Ѿ���½�� &&goto END) else (goto LOGIN)
:LOGIN
::���ļ��ж�ȡ�û��������룬���浽����������
::��ȡǰ���У��ļ���һ��Ϊ�û������ڶ���Ϊ����
if exist data (
     echo ���ر����˻������ڵ�½...
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
     echo �����ڱ����˻���������
	 :RELOGIN
	 set /p user=�˻���
	 set /p pass=���룺
	 cls
	 ::���˻����浽����
	 echo !user!>data
	 echo !pass!>>data
     )
echo ��½�˻���!user!
curl -s http://10.3.8.211 -X POST -m 10000 -H "Host: 10.3.8.211" -H "Content-Type: application/x-www-form-urlencoded" --data "DDDDD=!user!&upass=!pass!&0MKKey=">>log
ping -n 1 www.baidu.com -w 100>>log
if %ERRORLEVEL% == 0 (echo=&&echo ��½�ɹ�) else (echo=&&echo ��½ʧ��&&echo �����˻�������Ƿ�������֧��&&echo= &&echo ���������룡&&goto RELOGIN)
:END
echo=
echo ����������˳�...��
pause>nul
exit