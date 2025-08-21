# Case Study: Emulating operating systems on modern hardware for business-critical use

**Problem:** The client has been relying on a pair of RiscPC 700s from 1995 by Acorn Computers, which run RISC OS 3.60 as an operating system. 
They are used to run custom written software for the business. 
The original authors of the software are no longer in business, and the source code for the software was not made available to the client. 
The hardware is no longer reliable, and replacement hardware parts are both increasingly scarce and expensive. 
The business relies on the software, and any downtime can incur considerable expenses. 
The users of the software are in the latter part of their business career, meaning that they are also reluctant to change existing methods of working. 
  
**Alternative solutions considered:** The client considered commissioning new software to replicate the existing functionality, but this option was rejected due to the large business risks and costs involved.
It was also considered that the software could run under the latest versions of RISC OS, versions 5.28 and 6.20. 
A Raspberry Pi 400 was acquired for this purpose, but only version 5.28 was functional with this hardware. 
Although other hardware does exist that is compatible with RISC OS version 6.20, it is in short supply and most of it is no longer produced commercially. 
After testing, it was discovered RISC OS 5.28 only had limited backwards compatibility with previous versions and that the software in use had been written for the 26-bit program counter that was used in the ARM610 processor. 
As a result, the software was incompatible with the latest versions of RISC OS, which has the CPU operating in 32-bit mode only. 
In addition,  a careful examination of the costs relating to maintaining the existing RiscPC 700 installation was carried out. 
It was discovered that replacement parts were largely unavailable, and that second hand parts were unreliable. 
They were also sold without testing and warranties, increasing the risk for the business and potentially causing extended downtime for the business critical software in use.

**Solution implemented:** It was established by the project team that there were multiple software emulators in use for the purpose of emulating a RISC OS 3.60 operating system environment. 
These emulators were tested, and the results are given in the table below:

| Emulator | Host operating system | Result |
| -------- | --------------------- | ------ |
| RPCEmu | Linux - Ubuntu 22.04 LTS | Positive |
| QEMU 8.1.0 | macOS 13 Ventura | Negative – does not boot RISC OS 3.6 |
| ArcEm 1.50.2 | Windows 11 22H2 | Positive |
| VirtualRPC-Adjust 630796 | Windows 11 22H2 | Positive |
| Arculator 2.2 | Linux - Ubuntu 22.04 LTS | Positive | 

While four of the emulators worked well in the initial test environment, it was discovered that only Arculator 2.2 was currently being updated. 
Other emulators had not received recent updates, with one emulator, VirtualRPC-Adjust, not receiving updates for almost 12 years. 
From a security perspective, it was considered that using software that had not received updates for a long period of time was likely to be vulnerable to attack, meaning that they were not viable for use in a business environment. 

**Problems encountered during implementation:** 
During stress testing in the implementation phase, it was discovered that the Arculator emulator produced error messages after being in use for several hours. 
After contacting the author of the emulator, it was confirmed that the bugs were known, but that the author did not intend to fix them in the foreseeable future. 
The emulator is also closed source, meaning that it was not possible to create a forked version of the software for the client.  

The nature of the software is that it is only required to be run for short periods of time. 
The software produced the expected results in the emulation environment, and after a month of being run simultaneously, the chosen solution was deemed to be viable for commercial use. 
The bugs in the emulator were documented by the project team, and the author of the emulator has pledged to fix them in the next release. 

**Lessons learnt:** 
Emulation solutions must be considered as being only suitable for hobbyist use and not for lengthy critical business use. 
However, with careful testing and a long implementation period, it is possible to create a solution that meets the expectations of the client while being aware of the limitations of these emulators. 
