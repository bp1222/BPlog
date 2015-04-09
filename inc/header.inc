<?
/**
 * header.inc
 *
 * BPlog start the output
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

$blogTitle = "J. David Walker";
$BPlogVersion = "v0.3a1";

//include "functions.inc";
include "database.inc";
include "auth.inc";
include "lookup.inc";
include "contentFunctions.inc";

// How we end this thing!
register_shutdown_function (normalExit);

// If the page doesn't want output we won't force it.
if (!$nooutput)
	pageHeader();

function normalExit()
{
	include "footer.inc";

    if (@mysql_ping())
        mysql_close();
}

function pageHeader()
{
    global $blogTitle;
	global $devbuild;
    global $title;
?>
	<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
		<head>
			<meta http-equiv="content-type" content="text/html; charset=iso-8859-1" />
			<meta name="description" content="My Professional Page" />
			<meta name="author" content="David Walker" />
			<link rel="alternate" type="application/rss+xml" href="http://jdavidw.com/index.xml" title="J. David Walker : RSS Feed">
			<link rel="stylesheet" type="text/css" href="/stylesheets/jdavidw.css"/>
			<title><?=$blogTitle." - ".$title?></title>
		</head>
	
		<body>
            <div id="outer">
                <div id="wrapper">
                    <div id="body-top">
				        <div id="logo">
                            <h1><a href="index.php">J. David Walker<?=$devbuild ? "D" : ""?></a></h1>
                        </div>
                        <div id="nav">
                            <ul>
                                <li><a href="/about.php">About Me</a><?=isAuth() ? "<br/><a href='/contentEdit.php?con_type=ABOUT'>Edit</a>" : ""?></li>
                                <li><a href="/blog.php">Blog</a><?=isAuth() ? "<br/><a href='/contentEdit.php?con_type=BLOG'>New Entry</a>" : ""?></li>
                                <li><a href="/projects.php">Projects</a><?=isAuth() ? "<br/><a href='/contentEdit.php?con_type=PROJECT'>New Project</a>" : ""?></li>
                                <li><a href="/seminars.php">Seminars</a></li>
                                <?if (isAuth()) {?>
                                    <li><a href="/logout.php">Logout</a></li>
                                <?} else {?>
                                    <li><a href="/login.php">Login</a></li>
                                <?}?>
                            </ul>
                            <div class="clear"></div>
                        </div>
                        <div id="gbox">
                            <div id="gbox-bg">
                                    
                <!-- End header, will be cleaned up in footer, index handles after here -->
<?}?>
