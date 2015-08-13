# buildJetsonRTCModule
Script for building a RTC Module for the Dallas DS3231 for the Jetson TK1 L4T kernel. The script builds and installs the DS1307 module. The module for the Dallas DS3231 is the same as the Dallas DS1307, which is register compatible.

Usefull tools for examining the I2C bus: 

$ sudo apt-get install libi2c-dev i2c-tools

The Dallas DS3231 appears as 0x68 on i2c bus 1 on the Jetson TK1 with this wiring:

<blockquote><p>GND J3A1-14 ->  DS3231 (GND)<br>
VCC J3A1-16 ->  DS3231 (VCC - 3.3V) <br>
SCL J3A1-18 ->  DS3231 (SCL)<br>
SDA J3A1-20 ->  DS3231 (SDA)</p></blockquote>

Note: VCC,SCL and SDA voltages are dependent on the RTC clock wiring. Most Raspberry Pi or Arduino addon boards that have been level-shifted to 3.3V should work for the SCL and SDA lines. Note also that VCC on most of these boards will work with 3.3V or 5V.

Run:
<blockquote>$ sudo ./prepareModule.sh</blockquote>
to build and install the RTC module. If you have the i2c tools installed, you can check to see if the RTC is available:
<blockquote>$ sudo i2cdetect -y -r 1</blockquote>
The address of the Dallas 3231 will show up as 0x68.

Then attach the RTC device:
<blockquote>$ echo ds3231 0x68 | sudo tee /sys/class/i2c-dev/i2c-1/device/new_device</blockquote>
You can set the clock on the RTC using:
<blockquote>sudo hwclock -w -f /dev/rtc1</blockquote>
You can read the the time stored on the RTC:
<blockquote>sudo hwclock -r -f /dev/rtc1</blockquote>
In order for the RTC to be loaded during startup, add the following two lines /etc/rc.local
(You can modify /etc/rc.local using '$ sudo gedit /etc/rc.local'_.
<blockquote>$ echo ds3231 0x68 | sudo tee /sys/class/i2c-dev/i2c-1/device/new_device
$ sudo hwclock -s -f /dev/rtc1</blockquote>
This tells the Jetson to attach the RTC, then set the system time from the RTC. The '-f /dev/rtc1' tells the Jetson that the DS3231 is attached to rtc1. 

There is an onboard RTC on the Jetson which is backed up using a small capacitor, an AS3722 which is /dev/rtc0. 

For more more information on the installation, please see: https://devtalk.nvidia.com/default/topic/769727/embedded-systems/-howto-battery-backup-rtc/




