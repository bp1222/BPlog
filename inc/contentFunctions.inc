<?
/**
 * contentFunctions.inc
 *
 * Functions for gettings and setting content
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

/*******************
 * Entry Functions *
 ******************/
function getOneContent ($con_id, $type = "") {
    if ($con_id)
        $sql = "SELECT * FROM content WHERE con_id = '$con_id'";
    else
        $sql = "SELECT * FROM content where con_type = '$type'";
    return mysql_fetch_assoc(mysql_query($sql));
}

function printEntry ($entry, $tags = false, $comments = false, $admins = true)
{
	// Print out main content and date
	$day = date("d", strtotime($entry['con_created']));
	$month = date("F", strtotime($entry['con_created']));
	$year= date("Y", strtotime($entry['con_created']));
	dateIcon($month, $day, $year);
	echo "<h2>".$entry['con_name']."</h2>\n";
	if (isAuth() && $admins)
	{
		echo "<h4><a href=\"entry.php?e_id=".$entry['con_id']."\">[Edit]</a>";
		echo "&nbsp<a href=\"entry.php?delete=true&e_id=".$entry['con_id']."\">[Delete]</a></h4><br/>";
	}
	if (isset($entry['con_picture']))
	{
		echo "<img src='img/".$entry['con_picture']."' class='right'/>\n";
	}
	echo "<p>".str_replace("\n", "<br/>", $entry['con_content'])."</p>\n";

	echo "<p class='tags'>";
	if ($tags)
    {
		$tagl = getTags($entry['con_id']);
        print "Tags: ";
		while ($tag = mysql_fetch_assoc($tagl))
		{
			$t_print .= "<a href='taglist.php?tag=".$tag['t_name']."'>".ucfirst($tag['t_name'])."</a>, ";
		}
		echo substr($t_print, 0, strlen($t_print)-2);
		echo "<br>\n";
    }


	if ($comments)
	//	printComments($entry['con_id']);
	echo "</p>";
}

function getPageOfContent ($page, $con) {
    global $con_type;

    $start = ($page * 15);

	$sql = "SELECT * FROM content WHERE con_type = '".$con_type[$con]."' ORDER BY con_id DESC LIMIT $start,15";
    
    $result = mysql_query($sql);
    return $result;
}

function numContent($con) {
    global $con_type;

    $sql = "SELECT count(*) FROM content WHERE con_type = '".$con_type[$con]."'";
    $res = mysql_fetch_assoc(mysql_query($sql));
    return $res['count(*)'];
}

function getProject ($project_id) {

}

function getProjects () {
    global $con_type;
	$sql = "SELECT * FROM content WHERE con_type = '".$con_type["PROJECT"]."' ORDER BY con_id DESC";
    
    $result = mysql_query($sql);
    return $result;
}

function printProject ($project, $short = false)
{
    if ($short) {
        print "<h3><a href=projects.php?con_id=".$project['con_id'].">".$project['con_name']."</a></h3>";
        print $project['con_short']."<br/>";
    } else {
        print "<h3>".$project['con_name']."</h3>";
        print $project['con_content']."<br/>";
    }
}

function getAbout () {
    global $con_type;

    $sql = "SELECT * FROM content WHERE con_type = '".$con_type["ABOUT"]."'";
    $result = mysql_query($sql);
    return mysql_fetch_assoc($result);
}
