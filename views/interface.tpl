<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8" />
	<title>Packager Web</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	
	<link rel="stylesheet" media="all" type="text/css" href="../CSS/Packager.css" />
	<link href="<?php echo BASE_PATH;?>/assets/packager.css" rel="stylesheet" type="text/css" media="screen" />
	<link rel="stylesheet" media="all" type="text/css" href="../CSS/PackagerContent.css" />
	
	<script src="<?php echo BASE_PATH;?>/libs/mootools.js" type="text/javascript"></script>
	<script src="<?php echo BASE_PATH;?>/assets/packager.js" type="text/javascript"></script>
</head>
<body>
	<div class="boxes">
		<span style="float: right;">
			<a href="http://github.com/kamicane/packager-web">Packager-Web by @kamicane</a>
			and
			<a href="http://github.com/timwienk/packager-web">@timwienk</a>
		</span>
		
		<b>Builder for MooTools PowerTools by @cpojer.</b> <a href="http://github.com/cpojer">GitHub</a> <a href="http://twitter.com/cpojer">Twitter</a>
	</div>
	<form id="packager" action="<?php echo BASE_PATH;?>/web/download" method="post">

	<?php foreach ($packages as $name => $data): ?>

		<div id="package-<?php echo $name; ?>" class="package">

			<table class="vertical">
				<thead>
					<tr class="first">
						<th>
							<h2><?php echo strip_tags($name); ?><small> - <?php echo strip_tags($data['package_description']); ?></small></h2>
							<div class="buttons">
								<input type="hidden" name="disabled[]" class="toggle" value="" />
								<div class="enabled">
									<input type="button" class="select" value="select package" />
									<input type="button" class="deselect" value="deselect package" />
									<input type="button" class="disable" value="disable package" />
								</div>
								<div class="disabled">
									<input type="button" class="enable" value="enable package" />
								</div>
							</div>
						</th>
					</tr>
				</thead>
				<tbody>
					<tr class="middle">
						<th>Web</th>
						<td><?php echo $data['package_web']; ?></td>
					</tr>
					<tr class="middle">
						<th>Description</th>
						<td><?php echo $data['package_description']; ?></td>
					</tr>
					<tr class="middle">
						<th>Copyright</th>
						<td><?php echo $data['package_copyright']; ?></td>
					</tr>
					<tr class="middle">
						<th>License</th>
						<td><?php echo $data['package_license']; ?></td>
					</tr>
					<tr class="last">
						<th>Authors</th>
						<td><?php echo $data['package_authors']; ?></td>
					</tr>
				</tbody>
			</table>

			<table class="horizontal">
				<tr class="first">
					<th class="first"></th>
					<th class="middle">File</th>
					<th class="middle">Provides</th>
					<th class="last">Description</th>
				</tr>
			<?php

			$files = $data['files'];

			$i = 0;
			$c = count($files);

			foreach ($files as $name => $file):
				$i++;

			?>

				<tr class="<?php echo ($i == $c) ? 'last ' : 'middle '?>unchecked">
					<td class="first check">
						<div class="checkbox"></div>
						<input type="checkbox" name="files[]" value="<?php echo $name; ?>" data-depends="<?php echo $file['depends']; ?>" />
					</td>
					<td class="middle file"><?php echo $file['name']; ?></td>
					<td class="middle provides"><?php echo $file['provides']; ?></td>
					<td class="last description"><?php echo $file['description']; ?></td>
				</tr>

			<?php endforeach; ?>

			</table>

		</div>

	<?php endforeach; ?>

		<p class="submit">
			<input type="hidden" name="addheaders" value="" />
			<input type="reset" value="reset" />
			<input type="submit" value="download" />
			<input type="submit" name="addheaders" value="download with package info" />
		</p>

		<div class="link">
			<label for="packager-link">Link to this build:</label>
			<input type="text" id="packager-link" size="50" value="" />
		</div>
	</form>

</body>
</html>
