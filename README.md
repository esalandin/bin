#dcs-get
Utility (based on expect) to get the files on the SD card of a Dlink *dcs-942l* (and possibly others).

## method 1: uu-tar-get
Only uses telnet. Prepares a tar and uuencodes it on the fly.

## method 2: tftp-get
Uses the tftp client found on the camera.
Uses telnet to issue the tftp put command.

## Notes
telnetd must be started on the camera using this command (where _dcs-942l_ is the ip address of the camera):
```
curl  --user admin:110684sa --referer http://dcs-942l/it/mainFrame.cgi http://dcs-942l/cgi/admin/telnetd.cgi?command=on
```

tested with camera firmware version 1.27
