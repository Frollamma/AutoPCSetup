# Introduction

This is for Installing default software and uninstalling useless software. Also it should be able to setup default network and domain configurations.

This was meant to be used at my job place, it can be generalized tho.

# Setup

Open powershell as administrator, run the following command to allow execution ofs for the entire machine

```
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine
```

or run the following command to allow execution ofs just for current user

```
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

Sometimes I simply use

```
Set-ExecutionPolicy Bypass
```

# Known problems

uninstaller doesn't work... The problem, at the moment, is near `$program_obj.Uninstall()`

# Steps to follow

- As admin user, run these scripts:
  - Network config
  - Domain config
  - Enable remote Desktop
  - Change hostname
- Restart the PC
- Log in as the future domain user of the PC
- As admin user, run the followings:
  - Scanner setup
  - Programs uninstaller
  - Programs installer
  - File backup
