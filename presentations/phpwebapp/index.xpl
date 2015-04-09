<?xml version="1.0"?>
<?xml-stylesheet type="text/xsl" href="presenter.xsl"?>
<slideshow>
	<title>Smart WebApp Developemt in PHP</title>
	<slide>
		<body>
			<h1 style="color:darkblue;margin-top:100px;margin-left: 100px; font-size: 28pt;margin-bottom:0px">
				Developing a Better WebApp
			</h1>
			<h4 style="font-style: italic; color: blue;margin-left: 200px;margin-top: 0px;"> 
				Using PHP (Expanded Version)
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
			Welcome to the seminar. I'm Dave, your host to the wonderful world of PHP and WebApps
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
			Most of the examples in this seminar are taken from a CMS that I wrote, BPLog.  The source
			to BPLog is available for download at <a href="http://www.jdavidw.com">http://www.jdavidw.com</a>
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
				<li>Make Your WebApp Modular</li>
				<li>Secure Authentication</li>
				<li>WebApp Frameworking</li>
			</ul>
			The last few topics will be mostly code examples with me explaining them.
		</body>
	</slide>

	<slide>
		<title>Goals</title>
		<body>
			Hopefully by the end of the presentation you will know more about how
			WebApps work, and how to make better, more modular, and more secure WebApps using PHP.
		</body>
	</slide>

	<slide>
		<title>Confessions</title>
		<body>
			I want to begin by saying I am not a PHP internals guru.  I have just used and programmed
			in PHP for many years, and can't stop reading documentation.  Topics I bring up
			are just the best way I have found to do a given task, hopefully they will be of use
			to some of you too.
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
		<title>Simple PHP Code Examples</title>

		<body>
			<code>
<![CDATA[<?php
$x = 4;
$y = 3;
$z = $x + $y;
echo "$z"; // Will give 7
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
// Neat Syntax
if ($x):
	some_function();
endif
// C like syntax
if ($x) {
	some_function();
}

function foo () {
	global $x;
	print "$x";
}

$obj = new Object();
$obj->helloWorld();
?>]]>
			</code>
			I hope many of you know this syntax, or figure it out quick, but for those that don't; `$` is a label for variable.  Unlike other languages; scalers, arrays, hashes, objects, bools, etc...
			are all prefixed by the `$`
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
<html>
  <form method='post' action="">
    <input type='text' name='foo'/>
	<input type='submit'/>
  </form>
</html>
<?php//end index.php?>

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
			<p/>
			I guess we should look at forms here.  HTML forms are used to 'post' information to 
			a PHP page.  We can access that information from a superglobal variable named $_REQUEST.
			That contains all information passed in to this script via the post method.
			The other superglobal we see here is $_SESSION.  It contains information regarding
			the session that we have begun.  We see that we can store informaion to it, like 
			an array, and retrieve information from it in the same way.
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
			We see the index file, the "main" of our webapp.  Then we see the folder 
			called inc.  Think of this as your main include, and your API area.  
			Since every "page" in this WebApp need very similar things done to 
			them we can re-use much of the same code to build our page.
		</body>
	</slide>

	<slide>
		<title>Main Page Example</title>
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
			Alright well the black box here is what is in header.inc.  This file should "set up" all defaults, restore the session, and "start" the application.
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
			Remember PHP is scripted, it goes from start to end, in that order.  
			The index file "included" the header.  So the header file does this 
			for every "page" in our WebApp.  Leaving body open gives you the ability 
			to just put content in your "page"-file.  Now here is a trick, instead 
			of closing the BODY and HTML tags, use <i>register_shutdown_function</i>.  
			This PHP call takes a function pointer, I will show you in the following example.
			<br/>
			Add the first two lines in the example below, before the <i>session_start();</i> line in the header.
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
?>
]]>
			</code>
			the <i>register_shutdown_function</i> will run right after your "page" 
			finishes execution.  So its the last portion of code to run before the 
			page is sent to the browser.  Note that in the <i>normalExit</i> we 
			clean up the tags we opened in the header.
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
  * header.inc
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
	<meta name="description" content="J. David Walker" />
	<meta name="author" content="David Walker" />
	<title>J. David Walker | <?=$title?></title>
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
				<li>Runs a function called isAuth, don't know what that does (yet)</li>
				<li>Loads Modules (will talk about that soon)</li>
				<li>Sees if a nooutput variable is true, if it is return if not call a function</li>
				<li>Has a pageHeader function, which does the page setup.  Note it leaves style open.</li>
			</ul>
			Why is the header information in a function, don't you always want to have the header print?
			<p/>
			Well, there are cases where you don't want to print out information too early.
		    Where printing information will prevent the system from using headers to
			send the client elsewhere in the application.  An example is after submiting a form
			we want the user to be sent to a different page than where the form was submitted.
			<p/>
			We will see that in the next few slides.
			<p/>
			And the expanded footer file for this would look like this:
			<code>
<![CDATA[
		</div>
		<?include 'sidebar.inc';?>

		<div id="footer">
			<p>Copyright &copy; 2007 J. David Walker 
			   Contact Me: dave at mudsite dot com</a></p>
		</div>
	</body>
</html>
]]>
			</code>
			We see it just closes the style, loads a sidebar page, and closes the tags.  Simple, no?
		</body>
	</slide>

	<slide>
		<title>App Datastorage</title>
		<body>
			I want to start by saying this is not a SQL seminar, so I won't teach syntax.
			<br/>
			With that said, PHP has bindings for many different versions of 
			SQL, LDAP, and other data storage.  Depending on what you want to use
			look at the PHP docs for them.  This WebApp will use MySQL as a data
			backend.
			<p/>
			Knowing what to store is very critical.  Since the purpose of a WebApp is to relay information
			from a datastore in a cohearant manor we need to think of what/how to display
			information.  In this example we will be using software entitled TCenter.
			<ul>
				<li>Content Information</li>
				<li>Comments</li>
				<li>Tag Information</li>
				<li>Author Information</li>
				<li>Other Modular Information (Will get to this later)</li>
			</ul>
			Knowing all that we can construct the database.  Which will consist of at least 4
			tables: 
			<dl>
				<dt>entries</dt>
				<dd>Content Information: created, author, content</dd>
				<dt>comments</dt>
				<dd>Comment Information: commenter, comment, entry (e_id)</dd>
				<dt>tags</dt>
				<dd>Tag Indormation: tag, entry (e_id)</dd>
				<dt>authors</dt>
				<dd>Author Information: name, password, salt, profile, contact, access</dd>
			</dl>
		</body>
	</slide>

	<slide>
		<title>Adding Datastorage to our WebApp</title>
	
		<body>
			Remember in a few examples back where we included a file called database.inc?
			Let's see what that does:

			<code>
<![CDATA[
$hostname = "localhost";
$username = "jdavidw_user";
$password = "password";
$database = "jdavidw";
$socket   = "/var/run/mysqld/mysqld.sock";

mysql_connect("$hostname:$socket", $username, $password);
mysql_select_db($database);
]]>
			</code>

			In short we can see it set a few variables, and pass them on to mysql_connet
			to make the connection to the database.  In the perfect world, you would have
			a page in your WebApp that will be able to edit those values.  Note, to do that
			the file will need to have write permisions for www-data (or webserver user).
		</body>
	</slide>

	<slide>
		<title>Question Break</title>
		<body>
			Questions about the basics?  Next will be more depth and code examples, and logic design.
		</body>
	</slide>

	<slide>
		<title>Creating a Basic Functional API (With Modules)</title>
		<body>
			I guess the first thing here that is new is the modules.  Why would we want them?
			<p/> Simple, you want modules to make extending the WebApp easier, This is covered
			in the next slide.  But what does the core API need to have to be useful?
			<ul>
				<li>Common Functions</li>
				<li>Functions that allow extending the system</li>
				<li>Structure and management of modules</li>
			</ul>
			Right, so what would that look like?

			<code>
<![CDATA[
<?php
$sidebar = array();

function normalExit()
{
	include "footer.inc";
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
]]>
			</code>
			
			Ok that's a bunch of code.  What all does it do?  Well remember from the first 
			half of the presentation the <i>register_shutdown_function</i> called <i>normalExit</i>
			here is where we can define it.  Then we have a function to upload an image.  Since
			more than one module may be wanting to upload images.  Then we have a function to 
			completely remove a directory.  This API call is there so modules can delete files
			or directories the user uploads.
		</body>
	</slide>

	<slide>
		<title>Making your WebApp Modular</title>
		<body>
			Ok so what's this about modules?
			<p/>
			Right, so modules are just what you think they are.  Provide different
			and new functionality to a WebApp.  The process of writing modules,
			and libraries to a WebApp should be easy.  And it can.  As we saw from 
			the previous slide, there is a simple way to "load" a module.  It's more like
			loading a header for the module, and letting it boot-strap.  The following slides
			show how modules are managed in the API, and how they are loaded.
		</body>
	</slide>

	<slide>
		<title>Extending the Core API to Modules</title>
		<body>
			The first thing we need to do is think about how modules will interact.
			Secondly, how they are stored in a file directory sence.  Then we need
			to think how they will be loaded, and what they can extend.
			<p/>
			Loading modules can be done in a multitude of ways, but one of which I found 
			to be better.  This involves a directory called modules, and each module being
			in a separate directory named after the module.
			<code>
/modules/myModule
			</code>

			Now all the contents of that module are contained into that directory.
			So now we need a way to load them.  Well the ability to enable and disable
			modules is important, so what we need is a config file to do just that.
			Below is an example of the config file to use.
			<h4>/modules/module.inc</h4>
			<code>
<![CDATA[
<?php
$modules["myModule"]	= 1;
$modules["offModule"]	= 0;
?>
]]>
			</code>

			So we see that myModule is turned on, and offModule is off.  The key in the array is 
			the name of the module in question.
			<p/>
			Next we need a way in the core API to load the modules into the system, and 
			allow them to extend the function set.

			<h4>/inc/functions.inc</h4>
			<code>
<![CDATA[
function loadModules ()
{
	global $modules;
	global $sidebar;

	include ROOTDIR."modules/module.inc";

	foreach ($modules as $key=>$val)
	{
		if ($val)
			include_once ROOTDIR."modules/$key/$key"."Load.php";
	}
}

function moduleEnabled ($mod)
{
	global $modules;
	if ($modules[$mod] == 1)
		return true;
	return false;
}

// Make sure that 
function includeFunctions($file)
{
	include_once ROOTDIR."modules/$file";
}
]]>
			</code>
			Awesome, so we now have a way to load modules, and extend the function set with the
			<i>includeFunctions</i> API call.  Seeing how to use these will be shown next.
		</body>
	</slide>

	<slide>
		<title>Writing a Simple Module</title>
		<body>
			The simplest module will make a button to click and echo out hello world.
			So lets do that now!
			<p/>First thing to know is that we need to know where we can put information on the page.
			Places we can post will be core dependant.  Since the different style will dicticate where
			we can post module information.  Chances are, that will be in a side bar for links.  So there
			will be a <i>$sidebar</i> variable that we will modify.
			<p/>
			Remember the module loading function searches in your module directory for a 
			modNameLoad.php file.  In this case, it will be <i>myModuleLoad.php</i>

			<h4>/module/myModule/myModuleLoad.php</h4>
			<code>
<![CDATA[
<?php
global $sidebar;

includeFunctions("myModule/moduleFunction.inc");

// Add a item to the sidebar
$sidebar["admin"]["SomeAdminFeature"] = "myModule/modAdmin.php";
$sidebar["public"]["SomePublicFeature"] = "myModule/modPublic.php";
?>
]]>
			</code>
			First I note that the file myModule/moduleFunction.inc is loaded.  This effectivly
			extends the API allowing these functions available to the system.
			We can see that the sidebar allows for two types of information, public and admin.
			I can guess that the admin side, will only be displayed to people with admin
			level access to the system, and that public will be shown to everyone.  We also
			see that the link that will be shown is: SomeAdminFeature and SomePublicFeature.
			Both of those will link to the given php page set to that part of the sidebar array.

			<p/>
			Next is the functions file.  In here is just a set of functions that will be added
			to the system for use by all parts of it.
			<h4>module/moduleFunctions.inc</h4>
			<code>
<![CDATA[
<?php
function myModule_fomeFunc ($param)
{
	echo "<h2>".$param['r_title']."</h2>\n";
	if (isAuth())
		echo "<h4><a href=\"modPublic.php?r_id=".$param['r_id']."\">[Edit]</a></h4>";

	echo "<p>".str_replace("\n", "<br/>", $param['r_desc'])."</p>\n";

	echo "</p>";
}
?>
]]>
			</code>
			Note a standard I try to follow.  Since this function is part of myModule, I prefece the 
			function with that and an underscore.
		</body>
	</slide>

	<slide>
		<title>Problems with Modules</title>
		<body>
			There are a few unavoidable problems with PHP and this scheme for modules.
			The most major is the inability to create namespaces.  PHP lacks this feature.
			There is talks on if it should be included in PHP6, but it is still unknown.
			That is why I highly recomend prefacing your module function names, and variables.
		</body>
	</slide>

	<slide>
		<title>Data Management</title>
		<body>
			Managing data can sometimes be really tricky with WebApps.  Trusting users to 
			always be nice is a mistake.  Chances are at some point a user will try to exploit
			the code of your App.
		</body>
	</slide>

	<slide>
		<title>Secure User Authentication</title>
		<body>

		</body>
	</slide>

	<slide>
		<title>User Management and Privledges</title>
		<body>

		</body>
	</slide>

	<slide>
		<title>Style Frameworks</title>
		<body>

		</body>
	</slide>

	<slide>
		<title>End</title>
		<body>
			Thank You for listening to the presentation.  I hope you learned something about 
			WebApp development and will be able to apply something to a later use.
			<p/>
			<p/>
			If you have any questions, ask away.
		</body>
	</slide>

</slideshow>
