<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">

<html lang="en">
<head>
	
	<title>Packager Web</title>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	
	<script src="<?php echo BASE_PATH;?>/libs/mootools.js" type="text/javascript"></script>
	<script src="<?php echo BASE_PATH;?>/assets/packager.js" type="text/javascript"></script>
	
	<link href="<?php echo BASE_PATH;?>/libs/reset.css" rel="stylesheet" type="text/css" media="screen" />
	<link rel="stylesheet" media="all" type="text/css" href="../CSS/Style.css" />
	<link href="<?php echo BASE_PATH;?>/assets/packager.css" rel="stylesheet" type="text/css" media="screen" />
	<link rel="stylesheet" media="all" type="text/css" href="../CSS/Packager.css" />
</head>
<body>
	<div class="boxes">
		<a href="http://github.com/kamicane/packager-web" style="float: right;">Packager-Web by @kamicane</a>
		
		<b>Builder for MooTools Projects by @cpojer.</b> <a href="http://github.com/cpojer">GitHub</a> <a href="http://twitter.com/cpojer">Twitter</a>
	</div>
	<form action="<?php echo BASE_PATH;?>/web/download" method="post">

	<?php
	
	foreach ($packages as $name => $data){
		
	?>
	<div class="tableWrapper">
		<table class="vertical">
			<tr class="first">
				<th><h2><?php echo $name ?> <small>- <?php echo $data['package_description']; ?></small></h2></th>
			</tr>
		</table>
		
		<table class="horizontal">
			<tr class="first">
				<th class="first"></th>
				<th class="middle">File</th>
				<th class="middle">Provides</th>
				<th class="last">Description</th>
			</tr>
			<?php

			$c = 0;
			$i = 0;
			
			$files = $data['files'];

			foreach ($files as $name => $file) $c++;

			foreach ($files as $name => $file){
				$i++;
				$class_name = ($i == $c) ? 'last' : 'middle';
				echo "<tr class=\"$class_name unchecked\">";
				echo "<td class=\"first check\"><div class=\"checkbox\"></div>";
				$depends = $file['depends'];
				$provides = $file['provides'];
				echo "<input type=\"checkbox\" name=\"files[]\" value=\"$name\" depends=\"$depends\" /></td>";
				$file_name = $file['name'];
				echo "<td class=\"middle file\">$file_name</td>";
				echo "<td class=\"middle provides\">$provides</td>";
				$description = $file['description'];
				echo "<td class=\"last description\">$description</td>";
				echo "</tr>";
			}

			?>
		</table>
	</div>
	<?php
		
	}
	
	?>
	
	<p class="submit">
		<input type="submit" value="download" />
	</p>
	
	</form>
		
</body>
</html>
