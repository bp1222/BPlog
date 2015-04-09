<?
/**
 * comment.php
 *
 * BPlog show entry with comment entry
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

$title = "J. David Walker | Comment on my blog";
include "inc/header.inc";

if ($_REQUEST['submit'])
{
	$p_content = $_REQUEST['p_content'];
	$p_author = $_REQUEST['p_author'];
	$p_created = date("Y-m-d h:i:s");
	$p_verify = $_REQUEST['p_verify'];
	$e_id = $_REQUEST['e_id'];

	if ($_SESSION['image_value'] == sha1($p_verify))
	{
		$sql = "INSERT INTO `comments` (`c_id`, `c_content`, `c_author`, `c_created`, `e_id`) ".
		   "VALUES (NULL, '$p_content', '$p_author', '$p_created', '$e_id')";
		$result = mysql_query($sql);
		$p_content = "";
		$p_author = "";
		$p_verify = "";
	}
}

$sql = "SELECT * FROM entries WHERE e_id = '".$_REQUEST['e_id']."'";
$entry = mysql_fetch_assoc(mysql_query($sql));

// Print the entry out
printEntry($entry);

// Print out comments that are in the DB
$sql = "SELECT * FROM comments WHERE e_id = '".$entry['e_id']."'";
$comments = mysql_query($sql);

echo "<div id='comments'>";
	if (mysql_num_rows($comments) > 0){
		echo "<p class='comment-header'>Comments:</p>";
		while ($comment = mysql_fetch_assoc($comments))
		{
			echo "<p>".$comment['c_content']."</p>";
			echo "<p class='comment-footer'>By: ".$comment['c_author'].
				 " | Posted On: ".date('F j, Y', strtotime($comment['c_created']))."</p>";	
		}
	}

	// Show commenty entry page
	echo "<p class='comment-header'>Post a comment:</p>";
?>

	<form method='post' action='comment.php'>
		<table>
			<tr>
				<td>Name:</td>
				<td><input type='text' name='p_author' value='<?=$p_author?>'/></td>
			</tr>
			<tr>
				<td valign='top'>Comment:</td>
				<td><textarea rows='10' cols='50' name='p_content'><?=$p_content?></textarea></td>
			</tr>
			<tr>
				<td/>
				<td><img src="inc/randomimg.inc"/></td>
			<tr>
				<td valign='top'>Image Verify:</td>
				<td valign='top'><input type='text' name='p_verify' style="align: top"/></td>
			</tr>
			<tr>
				<td/>
				<td align='right'><input type='submit' name='submit' value='Create Comment'/></td>
			</tr>
			<input type='hidden' name='e_id' value='<?=$entry['e_id']?>'/>
		</table>
	</form>
<?
echo "</div>";
?>
