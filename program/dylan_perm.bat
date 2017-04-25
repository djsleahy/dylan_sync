SET addr=%1

icacls %addr% /grant "%domain%\Users":(OI)(CI)F
icacls %addr% /grant "everyone":(OI)(CI)F
icacls %addr% /grant "Authenticated Users":(OI)(CI)F
