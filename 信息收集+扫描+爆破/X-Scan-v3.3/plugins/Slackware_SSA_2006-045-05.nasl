# This script was automatically generated from the SSA-2006-045-05
# Slackware Security Advisory
# It is released under the Nessus Script Licence.
# Slackware Security Advisories are copyright 1999-2004 Slackware Linux, Inc.
# SSA2nasl Convertor is copyright 2004 Tenable Network Security, Inc.
# See http://www.slackware.com/about/ or http://www.slackware.com/security/
# Slackware(R) is a registered trademark of Slackware Linux, Inc.

if (! defined_func("bn_random")) exit(0);


include("compat.inc");

if (description) {
script_id(20916);
script_version("$Revision: 1.3 $");
script_category(ACT_GATHER_INFO);
script_family(english: "Slackware Local Security Checks");
script_dependencies("ssh_get_info.nasl");
script_copyright("This script is Copyright (C) 2006 Tenable Network Security, Inc.");
script_require_keys("Host/Slackware/release", "Host/Slackware/packages");
 script_set_attribute(attribute:"synopsis", value:
"The remote host is missing the SSA-2006-045-05 security update." );
 script_set_attribute(attribute:"description", value:
"New kdelibs packages are available for Slackware 10.0, 10.1, 
and 10.2 to fix a security issue with kjs.

More details about this issue may be found in the Common
Vulnerabilities and Exposures (CVE) database:

  http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2006-0019

Additional information may be found on the KDE website:

  http://www.kde.org/info/security/advisory-20060119-1.txt" );
 script_set_attribute(attribute:"solution", value:
"Update the packages that are referenced in the security advisory." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P");
script_end_attributes();


script_xref(name: "SSA", value: "2006-045-05");
script_summary("SSA-2006-045-05 kdelibs ");
name["english"] = "SSA-2006-045-05 kdelibs ";
script_name(english:name["english"]);
script_cve_id("CVE-2006-0019");
exit(0);
}

include('slackware.inc');
include('global_settings.inc');

desc="";
if (slackware_check(osver: "10.0", pkgname: "kdelibs", pkgver: "3.2.3", pkgnum:  "3", pkgarch: "i486")) {
w++;
if (report_verbosity > 0) desc = strcat(desc, '
The package kdelibs is vulnerable in Slackware 10.0
Upgrade to kdelibs-3.2.3-i486-3 or newer.
');
}
if (slackware_check(osver: "10.1", pkgname: "kdelibs", pkgver: "3.3.2", pkgnum:  "3", pkgarch: "i486")) {
w++;
if (report_verbosity > 0) desc = strcat(desc, '
The package kdelibs is vulnerable in Slackware 10.1
Upgrade to kdelibs-3.3.2-i486-3 or newer.
');
}
if (slackware_check(osver: "10.2", pkgname: "kdelibs", pkgver: "3.4.2", pkgnum:  "2", pkgarch: "i486")) {
w++;
if (report_verbosity > 0) desc = strcat(desc, '
The package kdelibs is vulnerable in Slackware 10.2
Upgrade to kdelibs-3.4.2-i486-2 or newer.
');
}

if (w) { security_hole(port: 0, extra: desc); }
