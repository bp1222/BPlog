<?
/**
  * galfun.inc
  *
  * Functions for the gallery system
  *
  * @author	David Walker	(azrail@csh.rit.edu)
  */

/* Create a albums array, kinda complicated Here it is

$albums = ..
	"Album location" {
		name = Album Name
		desc = Album Description
		thumbnail = Album Thumbnail
		'images' {
			Title => image path,
			Title2 => Another Image
		}
	}
	"Album" { 
	...
	}
   
*/   

// As we load the XMl up we will need to see if this gallery has subs, and load them right.
function loadGalXML ($xmlFile)
{
	global $albums;

	$xml = new SimpleXMLElement(file_get_contents($xmlFile));
	$location = (string)$xml->location;

	$albums[$location]['desc'] = (string)$xml->desc;
	$albums[$location]['name'] = (string)$xml->name;
	$albums[$location]['thumbnail'] = (string)$xml->thumbnail;
	foreach ($xml->image as $image)
	{
		$albums[$location]['images'][(string)$image->title] = (string)$image->imgfile;
	}

	foreach ($xml->subgal as $subgal)
	{
		$sgalXMLPath = $location.DIRECTORY_SEPARATOR.(string)$subgal->location;
		// Make sure that this subgal is valid
		if (!file_exists($sgalXMLPath."/gal.xml"))
			continue;

		$subXML = new SimpleXMLElement(file_get_contents($sgalXMLPath."/gal.xml"));
		$subThumb = $sgalXMLPath."/".(string)$subXML->thumbnail;
		$subLocation = (string)$subXML->location;
		$subName = (string)$subXML->name;
		
		$albums[$location]['subgal'][$subName]['thumb'] = $subThumb;
		$albums[$location]['subgal'][$subName]['name'] = $subName;
		$albums[$location]['subgal'][$subName]['location'] = $subLocation;
	}
}

/*
   Attempt to load all the information contained in the "gallery" folders within
   the galleries directory.  If there is a gal.xml file, let's load it up.
*/
function loadGalleries ($gallery = null)
{
	// Load All galleries we can!
	if ($gallery == null)
	{
		$dIt = new DirectoryIterator("./galleries");
		foreach ($dIt as $file)
		{
			if (preg_match("/^\./", $file))
				continue;
	
			$galXML = "./galleries/$file/gal.xml";
			if (file_exists($galXML))
			{
				loadGalXML($galXML);
			}
		}
	}
	else
	{
		// Load only 1 gallery.
		$galXML = "$gallery/gal.xml";
		if (file_exists($galXML))
		{
			loadGalXML($galXML);
		}
	}
}

function displayGallery ($gallery = null)
{
	global $albums;
	loadGalleries($gallery);
	var_dump($gallery);

	if ($gallery == null)
	{
		// Lets show all the galleries with their highlighted picture
		foreach ($albums as $loc=>$content)
		{
			$thumb = $content['thumbnail'];

			if (!isset($content['images']))
				continue;

			echo '<div class="gallery">';
				echo "<div class='info'>".$content['name'];
				if (isAuth())
				{
					echo "<br/><a href='delgal.php?gal=$loc'>Delete Gallery</a>";
				}	
				echo "</div>";

				echo "<a href='index.php?gallery=$loc'><img src='$loc/$thumb' width='100' height='75'/></a>";
			echo '</div>';
		}
	}
	else
	{
		foreach ($albums as $loc=>$content)
		{
			if (!isset($content['images']))
				continue;

			echo '<div class="gallery">';
				if ($content['subgal'])
				{
					foreach ($content['subgal'] as $gal)
					{
						$name = $gal['name'];
						$location = $gal['location'];
						$thumb = $gal['thumb'];

						echo "<div class='info'>Gallery - ".$name;
							if (isAuth())
							{
								echo "<br/><a href='delgal.php?gal=$location'>Delete Gallery</a>";
							}
						echo "</div>";
						echo "<a href='index.php?gallery=$location'><img src='$thumb' width='100' height='75'/></a>";
					}
				}
				
				if ($content['images'])
				{
					foreach ($content['images'] as $name=>$img)
					{
						echo "<div class='info'>".$name."</div>";
						echo "<a href='$loc/$img' rel='lightbox[]' title='$name'><img src='$loc/$img' width='100' height='75'/></a>";
					}
				}
			echo '</div>';
		}
	}
}
?>
