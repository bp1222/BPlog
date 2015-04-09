<?
/**
 * auth.inc
 *
 * Authentication System
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

// Manage Sessions
session_start();
session_regenerate_id();

// Run this function to check to see if we're authenticating
isAuth();

function isAuth()
{
	if (isset($_REQUEST['login']))
	{
		if (!isset($_REQUEST['username']) || !isset($_REQUEST['password']))
		{
			print "You need to enter correct information";
			return false;
		}

		$sql = "SELECT * FROM users WHERE u_username = '".
               $_REQUEST['username']."' AND u_password = SHA1('".$_REQUEST['password']."')";
		$rows = mysql_num_rows(mysql_query($sql));

		if ($rows == 1)
		{
			$_SESSION['auth'] = true;
		}
		else
		{
			echo "Invalid Login";
		}
	}

	return ($_SESSION['auth'] ? true : false);
}

function requireAuth()
{
	// Check the authentication
	if (!isAuth())
	{
		displayAuthPage();
		exit;
        // Nope, not seeing the page
	}
}

function displayAuthPage()
{
?>
	<h2>Login to the System</h2>
	<form method="post" action="/index.php">
		<?if ($_REQUEST) {
			foreach ($_REQUEST as $request=>$value)
			{
				echo "<input type='hidden' value='".htmlspecialchars($value, ENT_QUOTES)."' name='$request'/>";
			}
		}
		?>
		<table>
			<tr>
				<td>Login:</td>
				<td><input type="text" name="username"/></td>
			</tr>
			<tr>
				<td>Password:</td>
				<td><input type="password" name="password"/></td>
			</tr>
			<tr>
				<td/><td align="right"><input type="submit" name="login" value="Login"/></td>
			</tr>
		</table>
	</form>

<?
	return;
}
