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

For more next steps in the installation, please see: https://devtalk.nvidia.com/default/topic/769727/embedded-systems/-howto-battery-backup-rtc/




