<?
/**
 * sidebar.inc
 *
 * BPlog sidebar
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

global $BPlogVersion;
echo '<div id="sidebar">';

if (isAuth())
{
?>
	<h2>Admin Menu:</h2>
	<ul>
		<li><a href="entry.php">Post new Entry</a></li>
		<li><a href="comments.php">View Comments</a></li>
		<li><a href="modules.php">Manage Modules</a></li>
		<?if($_SESSION['auth']) {?>
			<li><a href="logout.php">Logout</a></li>
		<?}?>
	</ul>
<?
}
?>
	<h2>Menu:</h2>
	<ul>
		<li><a href="/blog.php">Blog</a></li>
		<li><a href="/about.php">About Me</a></li>
		<li><a href="http://flickr.com/photos/bp1222">Photos</a></li>
		<li><a href="/projects.php">Projects</a></li>
		<li><a href="/seminars.php">Seminars</a></li>
		<li><a href="/resume.pdf">Resume</a></li>
		<li><a href="/index.xml">View the RSS feed</a></li>
		<?if(!$_SESSION['auth']) {?>
			<li><a href="/login.php">Login</a></li>
		<?}?>
	</ul>
	<h2>Tags:</h2>
	<ul>
		<?printTagCloud()?>
	</ul>
	<br/>
	<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/us/">
		<img alt="Creative Commons License" style="border-width:0" src="http://creativecommons.org/images/public/somerights20.png"/>
	</a>
	<h3>Powered by BPlog <?=$BPlogVersion;?></h3>
</div>
