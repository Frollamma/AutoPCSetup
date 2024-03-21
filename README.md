# Introduction

This is for Installing default software and uninstalling useless software. Also it should be able to setup default network and domain configurations.

This was meant to be used at my job place, it can be generalized tho.

# Setup

Open powershell as administrator, run the following command to allow execution of scripts for the entire machine

```
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine
```

or run the following command to allow execution of scripts just for current user

```
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

Sometimes I simply use

```
Set-ExecutionPolicy Bypass
```

# Known problems

uninstaller script doesn't work... The problem, at the moment, is near `$program_obj.Uninstall()`

# Order to follow

- Domain config
