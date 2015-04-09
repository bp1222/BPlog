<?xml version="1.0"?>
<?xml-stylesheet type="text/xsl" href="presenter.xsl"?>
<slideshow>
	<title>Smart WebApp Developemt in PHP</title>
	<slide>
		<body>
			<h1 style="color:darkblue;margin-top:100px;margin-left: 100px; font-size: 28pt;margin-bottom:0px">
				Smart WebApp Developemnt With PHP
			</h1>
			<h4 style="font-style: italic; color: blue;margin-left: 200px;margin-top: 0px;"> 
				And Managing a Hectic HelpDesk
			</h4>

			<div style="position: absolute; right: 0px; bottom: 0px; margin: 50px;"> 
				Computer Science House
				<p/>
				David Walker<br/>
				azrail@csh.rit.edu
			</div>

		</body>
	</slide>

	<slide> 
		<title>Introduction</title>
		<body>
			Welcome to the seminar. I'm Dave your host to the wonderful world of PHP and WebApps
			<p/>
			If you have a question about any of the material feel free to ask.
			I will do my best to answer, or hold off if it is a topic to be covered later.
			<p/>
			Mostly, try to focus questions on confusion about the material, rather
			than focusing on "what if foo?" type questions. Write down other
			questions and save them for question breaks, if you can.
			<p/>
			Sorry for those who know PHP, the start of the presentation will be an 
			"Intro to PHP" where I will show some of the differences between it and other languages.
			<p/>
			The slides can be found online at:<br/>
			<a href="http://www.jdavidw.com/presentations/phpwebapp">http://www.jdavidw.com/presentations/phpwebapp</a>
		</body>
	</slide>

	<slide> 
		<title>Topics</title>
		<body>
			Subjects to be covered:
			<ul>
				<li>Intro to PHP / Syntactical Differences</li>
				<li>Caveats of PHP</li>
				<li>Simple PHP Examples</li>
				<li>Differences of Programming Logic</li>
				<li>What is a WebApp</li>
				<li>Programming Logic for WebApp</li>
				<li>Tips &amp; Tricks for WebApp Programming</li>
				<li>Data Storage, and PHP's interaction</li>
				<li>WebApp Frameworking</li>
				<li>Make Your WebApp Modular</li>
			</ul>
		</body>
	</slide>

	<slide>
		<title>What is PHP</title>
		<body>
			Quoting php.net:
			<blockquote>
			PHP  is a widely-used general-purpose scripting language that is especially suited for Web development and can be embedded into HTML
			</blockquote>

			PHP is a script programming language with a recurive acronym as a name:
			PHP Hypertext Processor.  It behaves in a similar manor to other 
			scripting languages: Perl, Python, Ruby.  However I use more of a C like syntax with it.
			<p/>
			The language is best documented at <a href="http://php.net">http://php.net</a>.  To find any 
			specific documentation about a function, or a library built into PHP, you can go to here:
			<a href="http://php.net/mysql">http://php.net/mysql</a>.
			<p/>
			A simple PHP program looks like this:
			<code>
<![CDATA[
<?php
echo "Hello World";
?>
]]>
			</code>
			Note, all PHP scripts should begin with a &lt;?php  and end with ?&gt;.
		</body>
	</slide>

	<slide>
		<title>Programming Logic</title>

		<body>
			One thing we need to realize is that PHP is not a continual functional language.
			It's a scripted language, and therefore ends when it's done outputting information.
			<p/>
			Other languages like C, C++, Java, etc... run until the user quits them.  With WebApps each page 
			is an instance, that starts, runs, and dies.  So we need to be thinking of that while developing.
			There are ways to retain information though the users "visit" to the WebApp, but that will be covered later.
		</body>
	</slide>

	<slide>
		<title>Simple PHP Program Example</title>

		<body>
			<code>
<![CDATA[<?php
$x = 4;
$y = 3;
$z = $x + $y;
echo "$y"; // Will give 7
$arr = array(); // Empty Array
$arr[1] = "foobie"; // Set place 1 to foobie
$arr["bar"] = 3; // Set place "bar" to 3, think hashes

class Object {
	function __constructor ()
	{}

	function helloWorld()
	{
		echo "Hello World";
	}
}
$obj = new Object();
$obj->helloWorld();
?>]]>
			</code>
			I'm going to assume everyone here has done, or seen this kind of programming before.
			<p/>
			`$` is a label for variable.  Unlike other languages; scalers, arrays, hashes, objects, bools, etc...
			are all prefixd by the `$`
			<p/>
			You can also see the function declaration.  Since PHP is a variable typeless language,
			you don't need to declare a return type for functions.  The function <i>helloWorld</i>
			could return anything if it so chose.  We, the developer, know what and if a function 
			returns relevant information, and will set it if need be.
		</body>
	</slide>

	<slide>
		<title>What is a Web Application?</title>
		<body/>
	</slide>

	<slide>
		<title>What is a Web Application?</title>
		<body>
			WebApps are just that, applications developed to be run on a website.
			<p/>
			WebApps should be able to handle and manage multiple users connecting at the same time,
			manage some kind of central information, update information to share with others.
			<p/>
			Information is the key.  Without some content being used, there would be 
			no reason to have a WebApp.  So getting information to and from a store is a priority.
			Doing this in a smart, efficent fashion will keep wait-time at a minimum.
			<p/>
			So, WebApps should:
			<ol>
				<li>Keep simultanious connections separate</li>
				<li>Store current use information</li>
				<li>Have an efficent data storage system</li>
				<li>Do what the 'client' needs them to do</li>
				<li><b>Be Secure</b></li>
			</ol>
		</body>
	</slide>

	<slide>
		<title>How to maintain sanity in PHP</title>

		<body>
			How, you may ask, do we maintain information for the user, and maintain users; Sessions.
			<ol>
				<li>Keep simultanious connections separate</li>
				<li>Store current use information</li>
				<li>Secure</li>
			</ol>

			<code>
<![CDATA[<?php
// index.php
session_begin();
session_regenerate_id();

$passed_in_var = $_REQUEST['foo'];
$_SESSION['save_this_var'] = $passed_in_var;
?>

<?php
// foo.php
session_begin();
session_regenerate_id();

var_dump($_SESSION['save_this_var']);
?>
]]>
			</code>
			Woah, what's that id business?
			<p/>
			PHP Sessions track via cookies. 
			They generate a long ID, but unless you change the ID of the session all 
			the time, the session can be hijacked.  This at least makes the application slighly more secure.
		</body>
	</slide>

	<slide>
		<title>Back to Programming Logic</title>
		<body>
			We know PHP is a scripted language, so we must program it as such.  Below is a very simple directory structure for the most basic of WebApps
			<code>
<![CDATA[
/
 | inc
   | header.inc
   | footer.inc
   | functions.inc
 | img
 | stylesheets
   | main.css
 root.inc
 index.php
]]>
			</code>
			We see the index file, the "main" of our webapp.  Then we see the folder called inc.  Think of this as your main include, and your API area.  Since every "page" in this WebApp need very similar things done to them we can re-use much of the sameness to build our page.
		</body>
	</slide>

	<slide>
		<title>Main Example</title>
		<body>
			Here is what your sample "page" template can look like:
			<code>
<![CDATA[
<?php
/**
  * index.php
  */

include "inc/header.inc";

echo "Hello World";
?>
]]>
			</code>
			OK well the black box here is what is in header.inc.  This file should "set up" all defaults, restore the session, and "start" the application.
		</body>
	</slide>

	<slide>
		<title>Your Main Header</title>
		<body>
			Here is a short example of what a header.inc file can contain:
			<code>
<![CDATA[
<?php
/**
  * header.inc
  */

include "databaseConnection.inc";
session_start();
session_regenerate_id();
?>
<html>
	<head>
		<title>My First WebApp</title>
	</head>
	<body>
]]>
			</code>
			Woah! It doesn't close the HTML tag?!
			<br/>
			Remember PHP is scripted, it goes from start to end, in that order.  The index file "included" the header.  So the header file does this for every "page" in our WebApp.  Leaving body open gives you the ability to just put content in your "page"-file.  Now here is a trick, instead of closing the BODY and HTML tags, use <i>register_shutdown_function</i>.  This PHP call takes a function pointer, I will show you in the following example.
			<br/>
			Add the first two lines in the example below, before the session_start(); line in the header.
			<code>
<![CDATA[
include "footer.inc";
register_shutdown_function(normalExit);

<?php
/**
  * footer.inc
  */
function normalExit()
{
		</body>
	</html>
}
]]>
			</code>
			the register_shutdown_function will run right after your "page" finishes execution.  So its the last portion of code to run before the page is sent to the browser.  Note that in the normalExit we clean up the tags we opened in the header.
		</body>
	</slide>

	<slide>
		<title>Expanding the WebApp</title>
		<body>
			Ok, now that we have a really basic understanding let's get bigger.
			<br/>
			Below is an example from a project I have worked on.  It shows how you can use the header.inc file to get up your page environment, as well as get all your includes.
			<code>
<![CDATA[
<?php
/**
  * footer.inc
  */
$BPlogVersion = "v0.2b2";

require "root.inc";
include "auth.inc";
include "functions.inc";
include "database.inc";

isAuth();

loadModules();

register_shutdown_function (normalExit);

if ($nooutput)
  return;
else
  pageHeader();

function pageHeader()
{
  global $devbuild;
?>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
  <head>
	<meta name="description" content="The Brew Guys" />
	<meta name="author" content="Ryan Tenny & David Walker" />
	<title><?=$title?></title>
  </head>

  <body>
	<div id="content">
	  <div id="header">
		<h1>
		  <a href="/index.php">The Brew Guys</a>
		</h1>
	</div>
    <div id="maintext">
<?}?>
]]>
			</code>
			Ok this does a lot.  Lets break it down:
			<ul>
				<li>Declares a program version number</li>
				<li>Includes data from: root.inc, auth.inc, functions.inc, and database.inc</li>
				<li>Runs a function called isAuth, don't know what that does</li>
				<li>Loads Modules (will talk about that soon)</li>
				<li>Sees if something is outputting</li>
				<li>Has a pageHeader function, which does the page setup</li>
			</ul>
			Ok well why would it be this way, instead of the previous example?
			<p/>
			Well, there are cases where you don't want to print out information too early.
		    Where printing information will prevent the system from using headers to
			send the client elsewhere in the application.  An example is after submiting a form
			we want the user to be sent to a different page than where the form was submitted.
		</body>
	</slide>
	
	<slide>
		<title>App Datastorage</title>
		<body>
			I want to start by saying his is not a SQL seminar.
			<br/>
			With that said, PHP has bindings for many different versions of 
			SQL, LDAP, and other data storage.  Depending on what you want to use
			look at the PHP docs for them.  This WebApp will use MySQL as a data
			backend.
			<p/>
			Knowing what to store.  Since the purpose of a WebApp is to relay information
			from a datastore in a cohearant manor we need to think of what/how to display
			information.  In this example we will be using software entitled TCenter.
			<br/>
			TCenter is a helpdesk management system, with computer tracking and a 
			few other features.  Data that needs to be stored is:
			<ul>
				<li>User Information</li>
				<li>Computer Information</li>
				<li>Ticket Information</li>
				<li>Authenticated User Information</li>
				<li>Application Information</li>
			</ul>
			Knowing all that we can construct the database.  Which will consist of 5 
			tables: 
			<dl>
				<dt>users</dt>
				<dd>User Information: name, phone, email</dd>
				<dt>machines</dt>
				<dd>Machine Information: login user/passwd, description, owner (u_id)</dd>
				<dt>tickets</dt>
				<dd>Ticket Indormation: ticket number, who made (u_id), machine (m_id), open/close date, updates</dd>
				<dt>admins</dt>
				<dd>Admin Information: Users who have access to special information</dd>
				<dt>system</dt>
				<dd>System Information: wait time, alerts, auto-logoff</dd>
			</dl>
		</body>
	</slide>

</slideshow>
