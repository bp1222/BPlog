<?
/**
 * entry.php
 *
 * BPlog Entry Functionality
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

$title = "J. David Walker | Create Blog Entry";
$nooutput = true;
include "inc/header.inc";
requireAuth();

// Check to see if we are editing an entry
if ($_REQUEST['e_id'])
	$edit = true;

if ($_REQUEST['edit'])
{
	$p_id = $_REQUEST['p_id'];
	$p_title = mysql_real_escape_string($_REQUEST['p_title']);
	$p_content = mysql_real_escape_string($_REQUEST['p_content']);
	$p_created = date("Y-m-d h:i:s");
	$p_picture = $_FILES['p_picture']['name'];

	// Change Picture
	if (!empty($p_picture))
	{
		// See if we're uploading a new picture
		// 1. Get the image name
		$imgname = basename($_FILES['p_picture']['name']);
	
		// 2. See if this image exists in the img/$imgname dir
		if (!imageExists($imgname) && !empty($imgname))
		{
			// Need to upload the image!
			uploadImage();
		}

		$sql = "UPDATE entries SET e_title = '".$p_title."', e_content = '".$p_content."', e_picture = '".$imgname."' WHERE e_id = '$p_id'";
		mysql_query($sql);
	}
	// No Picture
	else
	{
		$sql = "UPDATE entries SET e_title = '".$p_title."', e_content = '".$p_content."' WHERE e_id = '$p_id'";
		mysql_query($sql);
	}

	/*
	   This section manages the update of tags
	*/
	// Clean tags, fixes a problem with empty field submissions and explode.
	if (empty($p_tags[0]))
		$p_tags = array();

	// Need to clean up the tag listing
	$p_tags = explode(",", $_REQUEST['p_tags']);
	$newTags = array();
	for ($i = 0; $i < sizeof($p_tags); $i++)
	{
		$tag = trim($p_tags[$i]);

		if (empty($tag))
			continue;
			
		$newTags[] = strtolower($tag);
	}
	$newTags = array_unique($newTags);

	// Get old list of tags
	$sql = "SELECT * FROM tags WHERE e_id = '$p_id'";
	$result = mysql_query($sql);
	$oldTags = array();
	while ($row = mysql_fetch_assoc($result))
	{
		$oldTags[] = $row['t_name'];
	}

	// Find tags that exist in the old list but not the new list.
	$toDelete = array_diff($oldTags, $newTags);
	$toAdd = array_diff($newTags, $oldTags);

	foreach ($toDelete as $del)
	{
		$sql = "DELETE FROM tags WHERE t_name = '$del' AND e_id = '$p_id'";
		mysql_query($sql);
	}

	foreach ($toAdd as $add)
	{
		$sql = "INSERT INTO tags (`t_id`, `t_name`, `e_id`) VALUES (NULL, '$add', '$p_id')";
		mysql_query($sql);
	}

	// Create the RSS Feed
	writeRSS();
	header ("Location: index.php");
}
else if ($_REQUEST['create'])
{
	// Add entry to database
	$p_title = mysql_real_escape_string($_REQUEST['p_title']);
	$p_content = mysql_real_escape_string($_REQUEST['p_content']);
	$p_tags = explode(",", $_REQUEST['p_tags']);
	$p_created = date("Y-m-d h:i:s");
	$p_picture = basename($_FILES['p_picture']['name']);

	if (empty($p_picture))
	{
		$sql = "INSERT INTO `entries` (`e_id`, `e_title`, `e_content`, `e_created`) VALUES (NULL, '$p_title', '$p_content', '$p_created')";
		$result = mysql_query($sql);
	}
	else
	{
		uploadImage();	

		// Insert this entry into the DB
		$sql = "INSERT INTO `entries` (`e_id`, `e_title`, `e_content`, `e_created`, `e_picture`) VALUES (NULL, '$p_title', '$p_content', '$p_created', '$p_picture')";
		mysql_query($sql);
	}

	// If there are tags with this entry, add them in.
	if (is_array($p_tags) && !empty($p_tags[0]))
	{
		$p_tags = array_unique($p_tags);
		$e_id = mysql_insert_id();
		$sql = "INSERT INTO `tags` (`t_id`, `t_name`, `e_id`) VALUES ";
		foreach ($p_tags as $tag)
		{
			$tag = strtolower(trim($tag));
			$sql .= "(NULL, '$tag', '$e_id'),";
		}
		$sql = substr($sql, 0, strlen($sql)-1);
		$result = mysql_query($sql);
	}

	// Create the RSS Feed
	writeRSS();
	header("Location: index.php");
}
else if ($_REQUEST['realdelete'])
{
	if ($_REQUEST['realdelete'] == "No")
	{
		header("Location: index.php");
		exit;
	}

	pageHeader();
	
	deleteEntry($_REQUEST['e_id']);
	echo "<center><h3 style='padding-top:7em;'>Entry has been deleted</h3></center>";
	// Create the RSS Feed
	writeRSS();
	return;
}

// Start HTML Output
pageHeader();

if ($_REQUEST['delete'])
{
?>
	Are you sure you wish to delete the following entry?
	<form method="post" action="<?=$_SERVER['PHP_SELF']?>">
		<input type="submit" name="realdelete" value="Yes"/>
		<input type="submit" name="realdelete" value="No"/>
		<input type="hidden" name="e_id" value="<?=$_REQUEST['e_id']?>"/>
	</form>
<?
	$sql = "SELECT * FROM entries WHERE e_id = '".$_REQUEST['e_id']."'";
	$entry = mysql_fetch_assoc(mysql_query($sql));

	printEntry($entry, false, false, false);
	return;
}

?>

<?if($edit){?>
	<h2>Edit Entry</h2>
<?
	$sql = "SELECT * FROM entries WHERE e_id = '".$_REQUEST['e_id']."'";
	$entry = mysql_fetch_assoc(mysql_query($sql));
} else {?>
	<h2>Create a new Entry</h2>
<?}?>
<form method='post' enctype="multipart/form-data" action='entry.php'>
	<table>
		<tr>
			<td>Entry Title:</td>
			<td><input type='text' name='p_title' value='<?=$entry['e_title']?>'/></td>
		</tr>
		<tr>
			<td valign="top">Entry Content:</td>
			<td><textarea rows="10" cols="50" name="p_content"><?=$entry['e_content']?></textarea></td>
		</tr>
		<tr>
			<td>Tags:</td>
			<td valign="top"><input type="text" name="p_tags" value="<?printTags($entry['e_id'], true)?>"/></td>
		</tr>
		<tr>
			<?if ($entry['e_picture']){?>
				<td>Replace Picture:</td>
				<td valign="top"><input type="file" name="p_picture" size="50"/>
					</br>Leave blank to do nothing
				</td>
			<?} else {?>
				<td>Picture:</td>
				<td><input type="file" name="p_picture" size="50"/></td>
			<?}?>
		</tr>
		<tr align="right">
			<td/>
			<td align="right">
				<?if ($edit){?>
					<input type="submit" name="edit" value="Modify Entry"/>
					<input type="hidden" name="p_id" value="<?=$entry['e_id']?>"/>
				<?} else {?>
					<input type="submit" name="create" value="Create Entry"/>
				<?}?>
			</td>
		</tr>
	</table>
</form>
