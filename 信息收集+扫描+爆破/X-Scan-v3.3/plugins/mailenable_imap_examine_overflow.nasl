#
# (C) Tenable Network Security, Inc.
#



include("compat.inc");

if (description) {
  script_id(20322);
  script_version("$Revision: 1.11 $");

  script_cve_id("CVE-2005-4456");
  script_bugtraq_id(15985);
  script_xref(name:"OSVDB", value:"22007");

  script_name(english:"MailEnable IMAP EXAMINE Command Remote Overflow");
 
 script_set_attribute(attribute:"synopsis", value:
"It is possible to execute code on the remote IMAP server." );
 script_set_attribute(attribute:"description", value:
"The remote host is running a version of MailEnable's IMAP service that
is prone to a buffer overflow vulnerability triggered when processing
a EXAMINE command with a long mailbox name.  Once authenticated, an
attacker can exploit this flaw to execute arbitrary code subject to
the privileges of the affected application.  There are also reportedly
similar issues with other IMAP commands." );
 script_set_attribute(attribute:"see_also", value:"http://lists.grok.org.uk/pipermail/full-disclosure/2005-December/040388.html" );
 script_set_attribute(attribute:"solution", value:
"Install Hotfix ME-10010 for MailEnable Professional 1.71 and earlier or
MailEnable Enterprise Edition 1.1 and earlier." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:N/I:N/A:C" );


script_end_attributes();

 
  script_summary(english:"Checks for EXAMINE command buffer overflow in MailEnable's IMAP service");
  script_category(ACT_GATHER_INFO);
  script_family(english:"Windows");
  script_copyright(english:"This script is Copyright (C) 2005-2009 Tenable Network Security, Inc.");
  script_dependencie("find_service1.nasl", "global_settings.nasl");
  script_exclude_keys("imap/false_imap");
  script_require_ports("Services/imap", 143);

  exit(0);
}

include ("imap_func.inc");

port = get_kb_item("Services/imap");
if (!port) port = 143;
if (!get_port_state(port) || get_kb_item("imap/false_imap")) exit(0);

# Make sure the banner is for MailEnable.
banner = get_imap_banner(port:port);
if (!banner || "* OK IMAP4rev1 server ready" >!< banner) exit(0);

soc = open_sock_tcp (port);
if (!soc)
  exit (0);

send (socket:soc, data:string("a001 LOGOUT\r\n"));
buf = recv (socket:soc, length:1024);

close (soc);

if ("MailEnable" >!< buf)
  exit (0);

soc = open_sock_tcp (port);
if (!soc)
  exit (0);

# ME-10010 now limits the command size
send (socket:soc, data:string("a001 CAPABILITY " , crap(510), "\r\n"));
buf = recv (socket:soc, length:1024);

send (socket:soc, data:string ("a001 LOGOUT\r\n"));
recv (socket:soc, length:1024);

close (soc);

# Patched version replies with BAD COMMAND
if ("OK CAPABILITY completed" >< buf)
  security_hole(port);

