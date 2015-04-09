<?
/** 
 * projects.php
 *
 * BPlog projects page
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

$title = "Projects";
include "inc/header.inc";

if ($_REQUEST['con_id'])
{
    printProject(getOneContent($_REQUEST['con_id']));
    exit;
}
?>
View my work.  All of my projects listed here are released under the GPL and can be viewed on my <a href="/projects">Online Project Repository</a>
<hr/>
<?
$projects = getProjects();
while ($project = mysql_fetch_assoc($projects))
{
    printProject ($project, true);
    print "</br>";
}
exit;
if (!$_REQUEST['edit']) {
    if ($_REQUEST['update']) {
        print "Update";
    }
}

if ($_SERVER['PATH_INFO'])
{
    // Take the path and get the entry
    $project = explode('/', $_SERVER['PATH_INFO']);
    $project = $project[1];

    $sql = "SELECT * FROM projects WHERE p_name = '".$project."'";
    $result = mysql_query($sql);

    if (mysql_num_rows($result) == 0)
    {
        print "Error - Project does not exist";
        exit;
    }

    $result = mysql_fetch_assoc($result);

    print "<h4>".$result['p_name']."</h4>";
    print $result['p_content'];
    exit;
} else if (!$_REQUEST['project']) {
    // List all projects
    $sql = "SELECT * FROM projects";
    $result = mysql_query($sql);

    print "<h2>Projects</h2>";
    while ($row = mysql_fetch_assoc($result)) {
        if (isAuth()) {
            print "<a href='/projects.php/".$row['p_name']."'>".$row['p_name']."</a> - ".$row['p_short']."</br>";
            print "<a href='/projects.php?edit=true&project=".$row['p_name']."'>[Edit]</a>";
        } else {
            print "<a href='/projects.php/".$row['p_name']."'>".$row['p_name']."</a> - ".$row['p_short']."</br>";
        }
    }
}

exit;
?>

<h2>Projects</h2>

<h4>Touchscreen</h4>
<p>The Touchscreen project was a software interface that Juozas Gaigalas and I created over a course of a weekend.  The software was written in C and designed to be mounted around the <a href='http://www.csh.rit.edu'>Computer Science House</a> floor.  The software was to interface with the floors networked drink machine, as well as provide an RSS reader for news and events.  The software was deployed in 2005 but has since been re-written by new CSH members.</p>
<br/>
<h4>Blast Wiki</h4>
<p>BlastWiki is a project by Aram Cho.  It is a pretty simple Wiki that does CamelWords as well as a nice searching and listing feature.  I improved this Wiki by adding a Database Abstraction Layer.  The database will be capable of using: Oracle, MySQL, PostgreSQL, and Microsoft SQL without changes to the code.</p>
<p> BlastWiki was released under a JDWYWWT (Just Do Whatever You Want With This) Licence.  This version of BlastWiki-DAL is released under the GPLv2 licence.</p>
<p>Download <a href='projects/BlastWiki-DAL-0.2.tar'>BlastWiki</a></p>
<br/>
<h4>Greek Portal</h4>
<p> This is a project I started for my Fraternity as a simplified chapter management tool.  It will provide a system in which brothers can post news events, schedule events on a calendar, and manage finances.  It also has an alert system, in which brothers can be alerted for financial balances, events, or due-dates.</p>
<p>The software is currently not licenced or available for download</p>
<p>You can view the development site <a href='http://jdavidw.com/sae'>Here</a>
<br/>
<h4>BPlog</h4>
<p>This website is another one of my projects.  I started this blog because I got fed up with MovableType.  It did not do what I needed it to do, so I wrote something that would.  This site has taught me a lot with web programming and style.  I plan on working on this page, and making it do more cool things in the coming weeks.  It already has an authentication system, RSS feeds, and easy way to post pictures to entries.</p>
<p>You can download BPlog v0.1 source: <a href="projects/BPlog-0.1.tgz">here</a></p>
