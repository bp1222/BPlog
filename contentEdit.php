<?
/**
 * contentEdit.php
 *
 * Modify Content in BPlog
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

$title = "Content Modification";
$nooutput = true;
include "inc/header.inc";
requireAuth();

// Make script variables
$con_id = $_REQUEST['con_id'];
$_REQUEST['con_type'] ? $content = strtolower($_REQUEST['con_type']) : $content = "ERROR";
$cName = ucfirst($content);

// See if we're updating
if ($_REQUEST['edit'])
{
    // Get our imputs
    $c_name = mysql_real_escape_string($_REQUEST['p_titke']);
    $c_short = mysql_real_escape_string($_REQUEST['p_short']);
    $c_content = mysql_real_escape_string($_REQUEST['p_content']);
    $c_tags = mysql_real_escape_string($_REQUEST['p_tags']);
    $c_picture = mysql_real_escape_string($_REQUEST['p_picture']);

    if ($content == "about")
    {
        $sql = "UPDATE content SET con_content = '$c_content' WHERE con_type = '2'";
        mysql_query($sql);
        header ("Location: /about.php");
    }
    else 
        $sql = "UPDATE content SET con_name = '$c_name', con_short = '$c_short', con_content = '$c_content' WHERE con_id = '$con_id'";
}
else if ($_REQUEST['create'])
{
    // Get our imputs
    $c_name = mysql_real_escape_string($_REQUEST['p_title']);
    $c_short = mysql_real_escape_string($_REQUEST['p_short']);
    $c_content = mysql_real_escape_string($_REQUEST['p_content']);
    $c_tags = mysql_real_escape_string($_REQUEST['p_tags']);
    $c_picture = mysql_real_escape_string($_REQUEST['p_picture']);

    if ($content == "project")
        $sql = "INSERT INTO content (`con_id`, `con_type`, `con_name`, `con_short`, `con_content`, `con_created`) VALUES (NULL, '1', '$c_name', '$c_short', '$c_content', NOW())";

    mysql_query($sql);

    header ("Location: /index.php");
}

// Display header now!
pageHeader();

// Form
if($edit){?>
	<h2>Edit <?=$cName?></h2>
<?
} else {?>
	<h2>Create a new <?=$cName?></h2>
<?}?>
<form method='post' enctype="multipart/form-data" action='<?=$_SERVER['PHP_SELF']?>'>
	<table>
        <?if ($content != "about"){?>
		    <tr>
		    	<td><?=$cName?> Title:</td>
		    	<td><input type='text' name='p_title' value='<?=$entry['con_name']?>'/></td>
		    </tr>
        <?}?>
        <?if ($content == "project"){?>
            <tr>
                <td valign="top">Short Description</td>
                <td><input type='text' name='p_short' value='<?=$entry['con_short']?>'/></td>
            </tr>
        <?}?>
		<tr>
			<td valign="top"><?=$cName?> Content:</td>
			<td><textarea rows="20" cols="75" name="p_content"><?=$entry['con_content']?></textarea></td>
		</tr>
        <?if ($content == "blog"){?>
	    	<tr>
	    		<td>Tags:</td>
	    		<td valign="top"><input type="text" name="p_tags" value="<printTags($entry['e_id'], true)?>"/></td>
	    	</tr>
	    	<tr>
	    		<?if ($entry['con_picture']){?>
	    			<td>Replace Picture:</td>
	    			<td valign="top"><input type="file" name="p_picture" size="50"/>
	    				</br>Leave blank to do nothing
	    			</td>
	    		<?} else {?>
	    			<td>Picture:</td>
	    			<td><input type="file" name="p_picture" size="50"/></td>
	    		<?}?>
	    	</tr>
        <?}?>
	    <tr align="right">
	    	<td/>
    		<td align="right">
	    		<?if ($edit){?>
	    			<input type="submit" name="edit" value="Modify <?=$cName?>"/>
	    			<input type="hidden" name="p_id" value="<?=$entry['con_id']?>"/>
	    		<?} else {?>
	    			<input type="submit" name="create" value="Create <?=$cName?>"/>
	    		<?}?>
	    		<input type="hidden" name="con_type" value="<?=strtoupper($content)?>"/>
	    	</td>
	    </tr>
	</table>
<form>
