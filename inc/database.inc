<?
/**
 * database.inc
 *
 * Handler for database queries
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

$host = explode(".", $_SERVER['HTTP_HOST']);
if ($host[0] == "dev")
	$devbuild = true;

$hostname = "localhost";
$username = "jdavidw";
$password = "1209qwpo";
if ($devbuild)
	$database = "jdavidw_dev";
else
	$database = "jdavidw_dev";
$socket   = "/var/run/mysqld/mysqld.sock";

mysql_connect("$hostname:$socket", $username, $password);
mysql_select_db($database);
