<?
/**
 * functions.inc
 *
 * BPlog set of common functions for the site
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

// How we end the page
function normalExit()
{
	include "footer.inc";
}

/********************
 * System Functions *
 *******************/
function longDate ($date)
{
	return date("l \\t\h\e jS \of F Y", strtotime($date));
}

function dateIcon($month,$day, $year){
	echo '<div class="the_date">'
		.'<div class="date_m">'.$month.'</div>'
		.'<div class="date_d">'.$day.'</div>'
		.'<div class="date_y">'.$year.'</div>'
		.'</div>';
}

/*******************
 * Entry Functions *
 ******************/

function deleteEntry ($entry_id)
{
	$sql = "SELECT * FROM comments WHERE _id = '$entry_id'";
	$comments = mysql_query($sql);

	// Delete Comments
	while ($row = mysql_fetch_assoc($comments))
	{
		$sql = "DELETE FROM comments WHERE c_id = '".$row['c_id']."'";
		mysql_query($sql);
	}

	$sql = "SELECT * FROM tags WHERE e_id = '$e_id'";
	$tags = mysql_query($sql);

	// Delete Tags
	while ($row = mysql_fetch_assoc($tags))
	{
		$sql = "DELETE FROM tags WHERE t_id = '".$row['t_id']."'";
		mysql_query($sql);
	}

	// Delete the Entry
	$sql = "DELETE FROM entries WHERE e_id = '$e_id'";
	mysql_query($sql);
}

function getTags ($entry_id)
{
	// SQL to get the tags
	$sql = "SELECT t_name FROM tags WHERE con_id = '".$entry_id."'";
	$result = mysql_query($sql);

	if (!mysql_num_rows($result))
		return;

    return $result;
}

/*********************
 * Comment Functions *
 ********************/
function printComments ($entry_id)
{
	$sql = "SELECT * FROM comments WHERE c_id = '$entry_id'";
	$comments = mysql_num_rows(mysql_query($sql));

	echo "<a href=comment.php?entry=$entry_id>Comments (".$comments.")</a>";
}

function writeRSS()
{
	$xmlFile = $_SERVER['DOCUMENT_ROOT']."/index.xml";
	$fp = fopen($xmlFile, "w");

	fwrite($fp, "<rss version=\"2.0\">\n");
	fwrite($fp, "\t<channel>\n");

	fwrite($fp, "\t\t<title>J. David Walker</title>\n");
	fwrite($fp, "\t\t<link>http://jdavidw.com</link>\n");
	fwrite($fp, "\t\t<description>My home on the Tubes</description>\n");
	fwrite($fp, "\t\t<language>en</language>\n");
	fwrite($fp, "\t\t<copyright>Copyright 2007</copyright>\n");
	fwrite($fp, "\t\t<lastBuildDate>".date("D, d M Y H:i:s O")."</lastBuildDate>\n");
	fwrite($fp, "\t\t<generator>http://jdavidw.com</generator>\n");
	fwrite($fp, "\t\t<docs>http://blogs.law.harvard.edu/tech/rss</docs>\n");

	// have the most recent 15 entries in the XML
	$sql = "SELECT * FROM entries ORDER BY e_created DESC LIMIT 15";
	$entries = mysql_query($sql);

	while ($entry = mysql_fetch_assoc($entries))
	{	
		fwrite ($fp, "\t\t<item>\n");
		fwrite ($fp, "\t\t\t<title>".htmlspecialchars($entry['e_title'])."</title>\n");
		fwrite ($fp, "\t\t\t<description><![CDATA[".$entry['e_content']."]]></description>\n");
		fwrite ($fp, "\t\t\t<link>http://jdavidw.com/comment.php?e_id=".$entry['e_id']."</link>\n");
		fwrite ($fp, "\t\t\t<pubDate>".date("D, d M Y H:i:s O", strtotime($entry['e_created']))."</pubDate>\n");

		// SQL to get the tags
		$sql = "SELECT t_name FROM tags WHERE e_id = '".$entry['e_id']."'";
		$tags = mysql_query($sql);

		while ($tag = mysql_fetch_assoc($tags))
		{
			fwrite ($fp, "\t\t\t<category>".$tag['t_name']."</category>\n");
		}
		fwrite ($fp, "\t\t</item>\n");
	}
	fwrite ($fp, "\t</channel>\n");
	fwrite ($fp, "</rss>\n");
}

function printTagCloud()
{
	$t = array();
	$max = 0;
	$min = 1000000;
	$sql = "SELECT t_name, COUNT(t_name) AS tagCount FROM tags GROUP BY t_name";
	$tags = mysql_query($sql);
	$tl = "/taglist.php?tag=";

	while ($tag = mysql_fetch_assoc($tags))
	{
		if ($tag['tagCount'] > $max)
			$max = $tag['tagCount'];
		if ($tag['tagCount'] < $min)
			$min = $tag['tagCount'];
		array_push($t, $tag);
	}

	$distr = ($max-$min)/3;

	foreach ($t as $tag)
	{
		if ($tag['tagCount'] == $min)
		{
			echo "<a href='$tl".$tag['t_name']."' class='tagSmall'>".$tag['t_name']."</a> ";
		}
		else if ($tag['tagCount'] == $max)
		{
			echo "<a href='$tl".$tag['t_name']."' class='tagLarge'>".$tag['t_name']."</a> ";
		}
		else if ($tag['tagCount'] > ($min + ($distr * 2)))
		{
			echo "<a href='$tl".$tag['t_name']."' class='tagMLarge'>".$tag['t_name']."</a> ";
		}
		else 
		{
			echo "<a href='$tl".$tag['t_name']."' class='tagMSmall'>".$tag['t_name']."</a> ";
		}
	}
}

function uploadImage()
{
	// Make sure no funny-buisness is going on
	if (!is_uploaded_file($_FILES['p_picture']['tmp_name']))
	{
		echo "NOT UPLOADED FILE";
		return;
	}

	$imgfile = $_FILES['p_picture']['tmp_name'];
	/*== only resize if the image is larger than 250 x 200 ==*/
	$imgsize = GetImageSize($imgfile);

	/*== check size  0=width, 1=height ==*/
	if (($imgsize[0] > 250) || ($imgsize[1] > 200))
	{
		/*== temp image file -- use "tempnam()" to generate the temp
		  file name. This is done so if multiple people access the
		  script at once they won't ruin each other's temp file ==*/
		$tmpimg = tempnam("/tmp", "MKUP");

		/*== RESIZE PROCESS
		  1. decompress jpeg image to pnm file (a raw image type)
		  2. scale pnm image
		  3. compress pnm file to jpeg image
		  ==*/

		/*== Step 1: djpeg decompresses jpeg to pnm ==*/
		system("djpeg $imgfile >$tmpimg");

		/*== Steps 2&3: scale image using pnmscale and then
		  pipe into cjpeg to output jpeg file ==*/
		system("pnmscale -xy 250 200 $tmpimg | cjpeg -smoo 10 -qual 50 > $imgfile");

		// remove temp image =
		unlink($tmpimg);
	}

	$imgname = basename($_FILES['p_picture']['name']);
	// Set the new image name and move it into the img directory
	$newimage = $_SERVER['DOCUMENT_ROOT']."/img/".$imgname;
	move_uploaded_file($imgfile, $newimage);
}

function imageExists ($imgname)
{
	return file_exists($_SERVER['DOCUMENT_ROOT']."/img/".$imgname);
}

// Real delete directory...like for realz!
function rmdirr($dirname)
{
	// Sanity check
	if (!file_exists($dirname)) {
		return false;
	}

	// Simple delete for a file
	if (is_file($dirname) || is_link($dirname)) {
		return unlink($dirname);
	}

	// Loop through the folder
	$dir = dir($dirname);
	while (false !== $entry = $dir->read()) {
		// Skip pointers
		if ($entry == '.' || $entry == '..') {
			continue;
		}

		// Recurse
		rmdirr($dirname . DIRECTORY_SEPARATOR . $entry);
	}

	// Clean up
	$dir->close();
	return rmdir($dirname);
}	
?>
