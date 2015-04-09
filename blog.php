<?
/**
 * index.php
 *
 * Head script, in charge of loading the main page
 *
 * Copyright (C) 2007 David Walker (azrail@csh.rit.edu)
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 2 of the License
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 */

$title = "My home on the tubes";
include "inc/header.inc";

// Get the "page" to display
$page = $_REQUEST['page'];
if (!is_numeric($page))
    $page = 0;

$entries = getPageOfContent($page, "entry");

while ($entry = mysql_fetch_assoc($entries))
{	
	printEntry($entry, true, true);
}

if (($numEntries = numContent("entry")) > 15)
{
    print "<center>";
    print "Pages: ";
    $page = 0;
    while ($numEntries > 0)
    {
        if ($_REQUEST['page'] == $page)
            print "<b><i><a href='blog.php?page=$page'>$page</a></i></b> ";
        else
            print "<a href='blog.php?page=$page'>$page</a> ";
        $page++;
        $numEntries = $numEntries - 15;
    }
    print "</center>";
}
?>
