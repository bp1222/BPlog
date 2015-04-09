<?
/**
 * viewcomments.php
 *
 * View Comments in the system
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

$title = "J. David Walker | Administration Page";
include "inc/header.inc";

requireAuth();

$sql = "SELECT c.c_author, c.c_content, c.c_created, c.e_id, e.e_title, e.e_id FROM ".
	   "comments AS c, entries AS e WHERE c.e_id = e.e_id ORDER BY c.e_id DESC";
$comments = mysql_query($sql);
?>
<table cellpadding="5px" border="1px">
	<th>
        <tr>
    		<td>Entry Title</td>
	    	<td>Commenter</td>
		    <td>Comment</td>
        </tr>
	</th>
<?
while (($row = mysql_fetch_assoc($comments))!=null)
{
?>
	<tr>
		<td><?=$row['e_title']?></td>
		<td><?=$row['c_author']?></td>
		<td><?=$row['c_content']?></td>
	</tr>
<?
}
?>
</table>


