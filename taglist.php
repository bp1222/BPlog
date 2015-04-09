<?
/**
 * tags.php
 *
 * BPlog show entrys based on a tag type
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

$title = "J. David Walker | Entrys with tag ".$_REQUEST['tag'];
include "inc/header.inc";

// SQL to get the tags
$sql = "SELECT e_id FROM tags WHERE t_name = '".$_REQUEST['tag']."' ORDER BY e_id DESC LIMIT 15";
$t_entries = mysql_query($sql);

echo "<h2>Entries with ".ucfirst($_REQUEST['tag'])." tag</h2><br/>";

while ($t_entry = mysql_fetch_assoc($t_entries))
{
	$sql = "SELECT * FROM entries WHERE e_id = '".$t_entry['e_id']."'";
	$entry = mysql_fetch_assoc(mysql_query($sql));
	
	printEntry($entry);

	echo "<p class='tags'>";
	printTags($entry['e_id']);
	echo "</p>";
}
?>
