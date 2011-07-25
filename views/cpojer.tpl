<?php
function getRepositoryName($name){
	// Ugh!
	if ($name == 'Form-AutoGrow') $name = 'form-autogrow';
	$name = ltrim(strtolower(preg_replace('/-?([A-Z])/', '-$1', $name)), '-');
	if ($name != 'scroll-loader' && $name != 'event-stack' && $name != 'mootilities') $name = 'mootools-' . $name;
	return $name;
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8" />
	<title><?php echo $config['title']; ?></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

	<link rel="stylesheet" type="text/css" media="screen" href="<?php echo BASE_PATH; ?>/libs/reset.css" />
	<link href="<?php echo BASE_PATH;?>/assets/packager.css" rel="stylesheet" type="text/css" media="screen" />
	<link rel="stylesheet" media="all" type="text/css" href="../CSS/Sub.css" />
	<link rel="stylesheet" media="all" type="text/css" href="../CSS/Packager.css" />

	<script src="<?php echo BASE_PATH;?>/../JavaScript/mootools-core.js" type="text/javascript"></script>
	<script src="<?php echo BASE_PATH;?>/assets/packager.js" type="text/javascript"></script>
	<script type="text/javascript">document.addEvent('domready', Packager.init);</script>

	<link rel="shortcut icon" href="../favicon.png" />

	<script type="text/javascript">
	  var _gaq = _gaq || [];
	  _gaq.push(['_setAccount', 'UA-353460-2']);
	  _gaq.push(['_trackPageview']);
	  (function(){
	    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
	    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
	    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
	  })();
	</script>
</head>
<body>
	<div class="head">
		<span style="float: right;">
			<a href="http://github.com/kamicane/packager-web">Packager-Web by @kamicane</a>
			and
			<a href="http://github.com/timwienk/packager-web">@timwienk</a>
		</span>

		<a href="../">« Back</a>
		<b>PowerTools! for MooTools by @cpojer.</b> Follow me on <a href="http://github.com/cpojer">GitHub</a> <a href="http://twitter.com/cpojer">Twitter</a>
	</div>
	<form id="packager" action="<?php echo BASE_PATH; ?>/web/download" method="post">

	<?php foreach ($packages as $name => $data): ?>

		<div id="package-<?php echo $name; ?>" class="package">

			<table class="vertical">
				<thead>
					<tr class="first">
						<th>
							<h2>
								<small style="float: right">
									<?php
							 			$path = $data['path'];
										if (file_exists($path . '/Demos'))
											echo '<a href="http://cpojer.net/' . trim(substr($path, 2), '/') . '/Demos' . (getRepositoryName($name) == 'mootools-interface' ? '/Example.js' : '') . '">Demo</a>';
									?>
									<a href="http://github.com/cpojer/<?php echo getRepositoryName($name); ?>/blob/master/README.md">How-To</a>
									<a href="http://github.com/cpojer/<?php echo getRepositoryName($name); ?>">GitHub</a>
									<?php
							 			$path = $data['path'];
										if (file_exists($path . '/Specs'))
											echo '<a href="http://cpojer.net/' . trim(substr($path, 2), '/') . '/Specs">Run Specs</a>';
									?>
								</small>
								<?php echo strip_tags($name); ?> <small><?php echo (count($data['files']) > 1) ? strip_tags($data['package_description']) : ''; ?></small>
							</h2>
							<div class="buttons">
								<input type="hidden" name="disabled[]" class="toggle" value="" />
								<div class="enabled">
									<input type="button" class="select" value="select package" />
									<input type="button" class="deselect disabled" value="deselect package" />
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

				<tr class="<?php echo ($i == $c) ? 'last' : 'middle'?> unchecked">
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

		<div id="options">
			<table class="horizontal">

			<?php if (!empty($config['blocks'])): ?>

				<tr class="first">
					<th class="first last" colspan="3">
						Include code blocks
					</th>
				</tr>

			<?php foreach($config['blocks'] as $block => $description): ?>

				<tr class="middle checked selected">
					<td class="first check">
						<div class="checkbox"></div>
						<input type="checkbox" name="blocks[]" value="<?php echo $block; ?>" checked="checked" />
					</td>
					<td class="middle"><?php echo $block ?></td>
					<td class="last"><?php echo $description ?></td>
				</tr>

			<?php

			endforeach;
			endif;

			if (!empty($config['compressors'])):

			?>

				<tr class="<?php echo (empty($config['blocks'])) ? 'first' : 'middle'; ?>">
					<th class="first last" colspan="3">
						Compression
					</th>
				</tr>

			<?php

			$compressors = $config['compressors'];

			$i = 0;

			foreach($compressors as $compressor):
				$i++

			?>

				<tr class="middle <?php echo ($i == 1) ? 'checked selected' : 'unchecked'; ?>">
					<td class="first check">
						<div class="radio"></div>
						<input type="radio" name="compressor" value="<?php echo $compressor; ?>"<?php if ($i == 1) echo ' checked="checked"'; ?> />
					</td>
					<td class="middle"><?php echo $compressor; ?> Compression</td>
					<td class="last">

					<?php

						switch (strtolower($compressor)){

							case 'yui':
								echo 'Uses <a href="http://www.julienlecomte.net/yuicompressor/">YUI Compressor</a>
								by <a href="http://www.julienlecomte.net/">Julien Lecomte</a>, to clean whitespace
								and rename internal variables to shorter values. Highest compression ratio.';
							break;

							case 'jsmin':
								echo 'Uses <a href="http://www.crockford.com/javascript/jsmin.html">JSMin</a> by
								<a href="http://www.crockford.com/">Douglas Crockford</a>. Cleans comments and
								whitespace.';
							break;

						}

					?>

					</td>
				</tr>

			<?php endforeach; ?>

				<tr class="last <?php echo (count($compressors)) ? 'unchecked' : 'checked selected'; ?>">
					<td class="first check">
						<div class="radio"></div>
						<input type="radio" name="compressor" value=""<?php if (!count($compressors)) echo ' checked="checked"'; ?> />
					</td>
					<td class="middle">No Compression</td>
					<td class="last">Uncompressed source. Recommended in testing phase.</td>
				</tr>

			<?php endif; ?>

			</table>
		</div>
		<p class="info">
			MooTools PowerTools! is targeted at MooTools 1.3. Most of the above plugins require Core/Class and Core/Class.Extras. The DOM plugins usually require Core/Element and Core/Element.Event. Tree and Collapse require Core/Fx.Tween, More/Drag.Move and More/Element.Delegation. You need to separately build <a href="http://mootools.net/core">mootools-core</a> and <a href="http://mootools.net/more">mootools-more</a>. For more information on the exact dependencies, look into the source files on GitHub. Usually your regular build of MooTools Core should include all necessary modules. If you have any questions, don't hesitate to get in touch in any way that works for you (e-mail, twitter, github, …).
		</p>
		<p class="submit">
			<input type="reset" value="reset" />
			<input type="submit" value="download" />
		</p>

	</form>

</body>
</html>
