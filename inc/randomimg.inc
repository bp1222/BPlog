<?
// We need to start the session, so we can add a value to it
session_start();

// The following 2 functions were taken from the Eskimo Project
// Generate a random string from Caps/Lower/Number characters
function random_string ($len = 5, $str = '')
{
	//We only want numbers and caps/lower letters. 
	$chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPRQSTUVWXYZ0123456789";
	$code = "";

	for ($i = 0; $i < $len; $i++)
	{
		$code .= $chars[mt_rand(0,strlen($chars))];
	}
	return $code;
}

//create the random string using the upper function 
//(if you want more than 5 characters just modify the parameter)
$rand_str=random_string(5); 

//We memorize the sha1 sum of the string into a session variable
$_SESSION['image_value'] = sha1($rand_str);

//Get each letter in one valiable, we will format all letters different
$letter1=substr($rand_str,0,1);
$letter2=substr($rand_str,1,1);
$letter3=substr($rand_str,2,1);
$letter4=substr($rand_str,3,1);
$letter5=substr($rand_str,4,1);

//Creates an image from a png file. If you want to use gif or jpg images, 
//just use the coresponding functions: imagecreatefromjpeg and imagecreatefromgif.
$image=imagecreatefrompng("../img/noise.png");

//Get a random angle for each letter to be rotated with.
$angle1 = rand(-20, 20);
$angle2 = rand(-20, 20);
$angle3 = rand(-20, 20);
$angle4 = rand(-20, 20);
$angle5 = rand(-30, 20);

//Get a random font. (In this examples, the fonts are located in "fonts" directory and named from 1.ttf to 10.ttf)
$fontdir = "../static/fonts/";
$font1 = $fontdir.rand(1, 10).".ttf";
$font2 = $fontdir.rand(1, 10).".ttf";
$font3 = $fontdir.rand(1, 10).".ttf";
$font4 = $fontdir.rand(1, 10).".ttf";
$font5 = $fontdir.rand(1, 10).".ttf";

//Define a table with colors (the values are the RGB components for each color).
$colors[0]=array(122,229,112);
$colors[1]=array(85,178,85);
$colors[2]=array(226,108,97);
$colors[3]=array(141,214,210);
$colors[4]=array(214,141,205);
$colors[5]=array(100,138,204);

//Get a random color for each letter.
$color1=rand(0, 5);
$color2=rand(0, 5);
$color3=rand(0, 5);
$color4=rand(0, 5);
$color5=rand(0, 5);

//Allocate colors for letters.
$textColor1 = imagecolorallocate ($image, $colors[$color1][0],$colors[$color1][1], $colors[$color1][2]);
$textColor2 = imagecolorallocate ($image, $colors[$color2][0],$colors[$color2][1], $colors[$color2][2]);
$textColor3 = imagecolorallocate ($image, $colors[$color3][0],$colors[$color3][1], $colors[$color3][2]);
$textColor4 = imagecolorallocate ($image, $colors[$color4][0],$colors[$color4][1], $colors[$color4][2]);
$textColor5 = imagecolorallocate ($image, $colors[$color5][0],$colors[$color5][1], $colors[$color5][2]);

//Write text to the image using TrueType fonts.
$size = 20;
imagettftext($image, $size, $angle1, 10, $size+15, $textColor1, $font1, $letter1);
imagettftext($image, $size, $angle2, 35, $size+15, $textColor2, $font2, $letter2);
imagettftext($image, $size, $angle3, 60, $size+15, $textColor3, $font3, $letter3);
imagettftext($image, $size, $angle4, 85, $size+15, $textColor4, $font4, $letter4);
imagettftext($image, $size, $angle5, 110, $size+15, $textColor5, $font5, $letter5);

header('Content-type: image/jpeg');
//Output image to browser
imagejpeg($image);
//Destroys the image
imagedestroy($image); 

?>